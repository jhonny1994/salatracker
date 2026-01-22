import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/core/notifications/notification_listener_widget.dart';
import 'package:salat_tracker/core/router/root_shell.dart';
import 'package:salat_tracker/features/calendar/calendar.dart';
import 'package:salat_tracker/features/onboarding/onboarding.dart';
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
  // Watch settings to react to onboarding completion
  final settingsAsync = ref.watch(settingsProvider);

  return GoRouter(
    initialLocation: '/today',
    observers: [SentryNavigatorObserver()],
    redirect: (context, state) {
      // Check if onboarding is complete
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
      return Scaffold(
        body: Center(
          child: Text(state.error?.toString() ?? 'Route error'),
        ),
      );
    },
  );
}
