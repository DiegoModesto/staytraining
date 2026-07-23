import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'responsive.dart';

/// Responsive chrome around the main tabs: a bottom [NavigationBar] on phones and a side
/// [NavigationRail] on tablets/large screens (extended with labels on the widest layouts).
/// Wraps the [StatefulNavigationShell] so each tab keeps its own navigation stack.
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const List<({IconData icon, IconData selected, String label})> _destinations = [
    (icon: Icons.home_outlined, selected: Icons.home, label: 'Início'),
    (icon: Icons.fitness_center_outlined, selected: Icons.fitness_center, label: 'Treinos'),
    (icon: Icons.sticky_note_2_outlined, selected: Icons.sticky_note_2, label: 'Notas'),
    (icon: Icons.insights_outlined, selected: Icons.insights, label: 'Relatório'),
    (icon: Icons.person_outline, selected: Icons.person, label: 'Perfil'),
  ];

  void _goBranch(int index) => navigationShell.goBranch(
        index,
        // Tapping the active tab again resets it to its initial route.
        initialLocation: index == navigationShell.currentIndex,
      );

  @override
  Widget build(BuildContext context) {
    if (context.isTablet) {
      final extended = context.screenSize == ScreenSize.large;
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _goBranch,
              extended: extended,
              labelType: extended ? NavigationRailLabelType.none : NavigationRailLabelType.all,
              destinations: [
                for (final d in _destinations)
                  NavigationRailDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.selected),
                    label: Text(d.label),
                  ),
              ],
            ),
            const VerticalDivider(width: 1, thickness: 1),
            Expanded(child: navigationShell),
          ],
        ),
      );
    }

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
        destinations: [
          for (final d in _destinations)
            NavigationDestination(
              icon: Icon(d.icon),
              selectedIcon: Icon(d.selected),
              label: d.label,
            ),
        ],
      ),
    );
  }
}
