import 'package:go_router/go_router.dart';
import 'package:salat_tracker/core/router/root_shell.dart';
import 'package:salat_tracker/features/calendar/calendar.dart';
import 'package:salat_tracker/features/settings/settings.dart';
import 'package:salat_tracker/features/today/today.dart';

final appRouter = GoRouter(
  initialLocation: '/today',
  routes: [
    ShellRoute(
      builder: (context, state, child) => RootShell(child: child),
      routes: [
        GoRoute(
          path: '/today',
          builder: (context, state) => const TodayScreen(),
        ),
        GoRoute(
          path: '/calendar',
          builder: (context, state) => const CalendarScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);
