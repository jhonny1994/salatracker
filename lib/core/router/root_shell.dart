import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salat_tracker/core/localization/gen/generated/l10n.dart';

class RootShell extends StatelessWidget {
  const RootShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
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
        onDestinationSelected: _onTap,
      ),
    );
  }
}
