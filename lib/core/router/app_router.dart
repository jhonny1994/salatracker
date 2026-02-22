import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/core/notifications/notification_listener_widget.dart';
import 'package:salat_tracker/core/router/root_shell.dart';
import 'package:salat_tracker/features/calendar/calendar.dart';
import 'package:salat_tracker/features/onboarding/onboarding.dart';
import 'package:salat_tracker/features/security/security.dart';
import 'package:salat_tracker/features/settings/settings.dart';
import 'package:salat_tracker/features/today/today.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'app_router.g.dart';

/// Main router configuration.
///
/// Uses [GoRouter] for navigational state and deep-link handling.
/// Includes redirect guard for onboarding flow.
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final refreshNotifier = _RouterRefreshNotifier(ref);
  ref.onDispose(refreshNotifier.dispose);

  return GoRouter(
    initialLocation: '/today',
    observers: [SentryNavigatorObserver()],
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final settingsAsync = ref.read(settingsProvider);
      final lockStatus = ref.read(appLockControllerProvider);

      // 1. Check App Lock status first
      final isLocked = lockStatus == AppLockStatus.locked;
      final onLockScreen = state.matchedLocation == '/lock';

      if (isLocked) {
        return onLockScreen ? null : '/lock';
      }

      if (onLockScreen && !isLocked) {
        // If unlocked but still on lock screen, go to home
        return '/today';
      }

      // 2. Check Onboarding status
      final settings = settingsAsync.asData?.value;
      final onboardingComplete = settings?.onboardingComplete ?? false;
      final isOnboarding = state.matchedLocation == '/onboarding';

      // First launch: redirect to onboarding
      if (!onboardingComplete && !isOnboarding) {
        return '/onboarding';
      }

      // Onboarding complete but on onboarding page: redirect to today
      if (onboardingComplete && isOnboarding) {
        return '/today';
      }

      return null;
    },
    routes: [
      // Lock Screen (highest priority, outside shell)
      GoRoute(
        path: '/lock',
        builder: (context, state) => const AppLockScreen(),
      ),

      // Onboarding route (outside shell)
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Main app shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NotificationListenerWidget(
            child: RootShell(navigationShell: navigationShell),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/today',
                builder: (context, state) => const TodayScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/calendar',
                builder: (context, state) => const CalendarScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      final l10n = S.of(context);
      return Scaffold(
        body: Center(
          child: Text(state.error?.toString() ?? l10n.routerError),
        ),
      );
    },
  );
}

class _RouterRefreshNotifier extends ChangeNotifier {
  _RouterRefreshNotifier(this._ref) {
    _settingsSub = _ref.listen<AsyncValue<Settings>>(
      settingsProvider,
      (_, _) => notifyListeners(),
    );

    _lockSub = _ref.listen<AppLockStatus>(
      appLockControllerProvider,
      (_, _) => notifyListeners(),
    );
  }

  final Ref _ref;
  late final ProviderSubscription<AsyncValue<Settings>> _settingsSub;
  late final ProviderSubscription<AppLockStatus> _lockSub;

  @override
  void dispose() {
    _settingsSub.close();
    _lockSub.close();
    super.dispose();
  }
}
