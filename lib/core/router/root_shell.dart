import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salat_tracker/core/localization/gen/generated/l10n.dart';

class RootShell extends StatelessWidget {
  const RootShell({required this.child, super.key});

  final Widget child;

  int _locationToIndex(String location) {
    if (location.startsWith('/calendar')) {
      return 1;
    }
    if (location.startsWith('/settings')) {
      return 2;
    }
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/today');
        return;
      case 1:
        context.go('/calendar');
        return;
      case 2:
        context.go('/settings');
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _locationToIndex(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.today),
            label: S.of(context).navToday,
          ),
          NavigationDestination(
            icon: const Icon(Icons.calendar_month),
            label: S.of(context).navCalendar,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings),
            label: S.of(context).navSettings,
          ),
        ],
        onDestinationSelected: (index) => _onTap(context, index),
      ),
    );
  }
}
