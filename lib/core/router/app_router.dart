import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/badges/badges.dart';
import 'package:salat_tracker/features/calendar/calendar.dart';
import 'package:salat_tracker/features/notification_entry/notification_entry.dart';
import 'package:salat_tracker/features/onboarding/onboarding.dart';
import 'package:salat_tracker/features/security/security.dart';
import 'package:salat_tracker/features/settings/settings.dart';
import 'package:salat_tracker/features/today/today.dart';
import 'package:salat_tracker/features/update/update.dart';
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
      final lockAsync = ref.read(appLockControllerProvider);
      final settingsAsync = ref.read(settingsProvider);
      final updateAsync = ref.read(updateProvider);
      return resolveAppRedirect(
        lockAsync: lockAsync,
        settingsAsync: settingsAsync,
        updateAsync: updateAsync,
        matchedLocation: state.matchedLocation,
      );
    },
    routes: [
      GoRoute(
        path: '/boot',
        builder: (context, state) => const _RouterBootScreen(),
      ),

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

      GoRoute(
        path: '/update-required',
        builder: (context, state) => const RequiredUpdateScreen(),
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
              GoRoute(
                path: '/notification/entry',
                builder: (context, state) => const NotificationEntryScreen(),
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
                routes: [
                  GoRoute(
                    path: 'prayer-schedule',
                    builder: (context, state) => const PrayerScheduleScreen(),
                  ),
                  GoRoute(
                    path: 'daily-reminders',
                    builder: (context, state) => const DailyRemindersScreen(),
                  ),
                  GoRoute(
                    path: 'badges',
                    builder: (context, state) => const BadgesScreen(),
                  ),
                ],
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

String? resolveAppRedirect({
  required AsyncValue<AppLockStatus> lockAsync,
  required AsyncValue<Settings> settingsAsync,
  required AsyncValue<UpdateDecision> updateAsync,
  required String matchedLocation,
}) {
  final lockLoading = lockAsync.isLoading;
  final settingsLoading = settingsAsync.isLoading;
  final isBoot = matchedLocation == '/boot';
  final isUpdateRequiredRoute = matchedLocation == '/update-required';

  if (lockLoading || settingsLoading) {
    return isBoot ? null : '/boot';
  }

  // 1. Check App Lock status first
  final lockStatus = lockAsync.requireValue;
  final isLocked = lockStatus == AppLockStatus.locked;
  final onLockScreen = matchedLocation == '/lock';

  if (isLocked) {
    return onLockScreen ? null : '/lock';
  }

  // 2. Check Onboarding status
  final settings = settingsAsync.requireValue;
  final onboardingComplete = settings.onboardingComplete;
  final isOnboarding = matchedLocation == '/onboarding';

  // 3. Hard block when required update grace expired
  final updateStatus = updateAsync.asData?.value.status;
  final updateBlocked = updateStatus == UpdateStatus.requiredBlocked;
  if (updateBlocked) {
    return isUpdateRequiredRoute ? null : '/update-required';
  }

  if (isUpdateRequiredRoute) {
    if (!onboardingComplete) {
      return '/onboarding';
    }
    return '/today';
  }

  // First launch: redirect to onboarding
  if (!onboardingComplete && !isOnboarding) {
    return '/onboarding';
  }

  // Onboarding complete but on onboarding page: redirect to today
  if (onboardingComplete && isOnboarding) {
    return '/today';
  }

  // Unlocked but still on lock screen: redirect to today
  if (onLockScreen) {
    return '/today';
  }

  return null;
}

class _RouterBootScreen extends StatelessWidget {
  const _RouterBootScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _RouterRefreshNotifier extends ChangeNotifier {
  _RouterRefreshNotifier(this._ref) {
    _settingsSub = _ref.listen<AsyncValue<Settings>>(
      settingsProvider,
      (_, _) => notifyListeners(),
    );

    _lockSub = _ref.listen<AsyncValue<AppLockStatus>>(
      appLockControllerProvider,
      (_, _) => notifyListeners(),
    );

    _updateSub = _ref.listen<AsyncValue<UpdateDecision>>(
      updateProvider,
      (_, _) => notifyListeners(),
    );
  }

  final Ref _ref;
  late final ProviderSubscription<AsyncValue<Settings>> _settingsSub;
  late final ProviderSubscription<AsyncValue<AppLockStatus>> _lockSub;
  late final ProviderSubscription<AsyncValue<UpdateDecision>> _updateSub;

  @override
  void dispose() {
    _settingsSub.close();
    _lockSub.close();
    _updateSub.close();
    super.dispose();
  }
}
