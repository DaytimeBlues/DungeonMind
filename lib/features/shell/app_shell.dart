import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Adaptive app shell that uses NavigationRail on desktop and NavigationBar on mobile
class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Determine layout based on screen width
    final isDesktop = MediaQuery.sizeOf(context).width >= 800;

    return Scaffold(
      body: isDesktop
          ? Row(
              children: [
                _DesktopNavRail(currentPath: _getCurrentPath(context)),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: child),
              ],
            )
          : child,
      bottomNavigationBar: isDesktop ? null : _MobileNavBar(currentPath: _getCurrentPath(context)),
    );
  }

  String _getCurrentPath(BuildContext context) {
    return GoRouterState.of(context).uri.path;
  }
}

/// Desktop navigation rail
class _DesktopNavRail extends StatelessWidget {
  final String currentPath;

  const _DesktopNavRail({required this.currentPath});

  int get _selectedIndex {
    if (currentPath.startsWith('/campaigns')) return 0;
    if (currentPath.startsWith('/entities')) return 1;
    if (currentPath.startsWith('/maps')) return 2;
    if (currentPath.startsWith('/sessions')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      extended: MediaQuery.sizeOf(context).width >= 1200,
      minWidth: 72,
      minExtendedWidth: 180,
      labelType: MediaQuery.sizeOf(context).width >= 1200
          ? NavigationRailLabelType.none
          : NavigationRailLabelType.all,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.auto_awesome,
                color: Theme.of(context).colorScheme.primary,
                size: 28,
              ),
            ),
            if (MediaQuery.sizeOf(context).width >= 1200) ...[
              const SizedBox(height: 8),
              Text(
                'DungeonMind',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.folder_outlined),
          selectedIcon: Icon(Icons.folder),
          label: Text('Campaigns'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.article_outlined),
          selectedIcon: Icon(Icons.article),
          label: Text('Entities'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.map_outlined),
          selectedIcon: Icon(Icons.map),
          label: Text('Maps'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.history_outlined),
          selectedIcon: Icon(Icons.history),
          label: Text('Sessions'),
        ),
      ],
      onDestinationSelected: (index) => _onDestinationSelected(context, index),
    );
  }

  void _onDestinationSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/campaigns');
        break;
      case 1:
        context.go('/entities');
        break;
      case 2:
        context.go('/maps');
        break;
      case 3:
        context.go('/sessions');
        break;
    }
  }
}

/// Mobile bottom navigation bar
class _MobileNavBar extends StatelessWidget {
  final String currentPath;

  const _MobileNavBar({required this.currentPath});

  int get _selectedIndex {
    if (currentPath.startsWith('/campaigns')) return 0;
    if (currentPath.startsWith('/entities')) return 1;
    if (currentPath.startsWith('/maps')) return 2;
    if (currentPath.startsWith('/sessions')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: _selectedIndex,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.folder_outlined),
          selectedIcon: Icon(Icons.folder),
          label: 'Campaigns',
        ),
        NavigationDestination(
          icon: Icon(Icons.article_outlined),
          selectedIcon: Icon(Icons.article),
          label: 'Entities',
        ),
        NavigationDestination(
          icon: Icon(Icons.map_outlined),
          selectedIcon: Icon(Icons.map),
          label: 'Maps',
        ),
        NavigationDestination(
          icon: Icon(Icons.history_outlined),
          selectedIcon: Icon(Icons.history),
          label: 'Sessions',
        ),
      ],
      onDestinationSelected: (index) => _onDestinationSelected(context, index),
    );
  }

  void _onDestinationSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/campaigns');
        break;
      case 1:
        context.go('/entities');
        break;
      case 2:
        context.go('/maps');
        break;
      case 3:
        context.go('/sessions');
        break;
    }
  }
}
