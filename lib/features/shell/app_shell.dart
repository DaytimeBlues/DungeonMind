import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/ui_providers.dart';
import '../../core/theme/catppuccin_colors.dart';
import 'widgets/dice_roller_overlay.dart';
import 'widgets/ai_assistant_overlay.dart';

/// Adaptive app shell that uses NavigationRail on desktop and NavigationBar on mobile
class AppShell extends ConsumerWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('DungeonMind: AppShell.build() called');
    final isDesktop = MediaQuery.sizeOf(context).width >= 800;
    final isDiceVisible = ref.watch(diceRollerVisibleProvider);
    final isAiVisible = ref.watch(aiAssistantVisibleProvider);

    return Material(
      child: Stack(
        children: [
          Scaffold(
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
          ),
          
          // Dice Roller Overlay
          if (isDiceVisible)
            Positioned(
              top: 0,
              bottom: isDesktop ? 0 : 80,
              right: 0,
              child: const DiceRollerOverlay(),
            ),

          // AI Assistant Overlay
          if (isAiVisible)
            Positioned(
              top: 0,
              bottom: isDesktop ? 0 : 80,
              right: 0,
              child: const AiAssistantOverlay(),
            ),
            
          // Close detector for Overlays
          if (isDiceVisible || isAiVisible)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  ref.read(diceRollerVisibleProvider.notifier).state = false;
                  ref.read(aiAssistantVisibleProvider.notifier).state = false;
                },
                behavior: HitTestBehavior.translucent,
              ),
            ),
            
          // Re-order Overlays to be on top of close detector
          if (isDiceVisible)
            Positioned(
              top: 0,
              bottom: isDesktop ? 0 : 80,
              right: 0,
              child: const DiceRollerOverlay(),
            ),
            
          if (isAiVisible)
            Positioned(
              top: 0,
              bottom: isDesktop ? 0 : 80,
              right: 0,
              child: const AiAssistantOverlay(),
            ),
        ],
      ),
    );
  }

  String _getCurrentPath(BuildContext context) {
    return GoRouterState.of(context).uri.path;
  }
}

/// Desktop navigation rail
class _DesktopNavRail extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final isDiceVisible = ref.watch(diceRollerVisibleProvider);

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
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.auto_awesome,
                color: Theme.of(context).colorScheme.primary,
                size: 28,
              ),
            ),
            const SizedBox(height: 16),
            // Dice Trigger
            _NavActionIcon(
              icon: Icons.casino_outlined,
              label: 'Dice',
              isActive: isDiceVisible,
              onPressed: () => ref.read(diceRollerVisibleProvider.notifier).state = !isDiceVisible,
            ),
            const SizedBox(height: 12),
            // AI Trigger
            _NavActionIcon(
              icon: Icons.auto_awesome_outlined,
              label: 'Gemini',
              isActive: ref.watch(aiAssistantVisibleProvider),
              onPressed: () => ref.read(aiAssistantVisibleProvider.notifier).state = !ref.read(aiAssistantVisibleProvider),
            ),
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
class _MobileNavBar extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final isDiceVisible = ref.watch(diceRollerVisibleProvider);
    final isAiVisible = ref.watch(aiAssistantVisibleProvider);

    return NavigationBar(
      selectedIndex: _selectedIndex,
      destinations: [
        const NavigationDestination(
          icon: Icon(Icons.folder_outlined),
          selectedIcon: Icon(Icons.folder),
          label: 'Campaigns',
        ),
        const NavigationDestination(
          icon: Icon(Icons.article_outlined),
          selectedIcon: Icon(Icons.article),
          label: 'Entities',
        ),
        const NavigationDestination(
          icon: Icon(Icons.map_outlined),
          selectedIcon: Icon(Icons.map),
          label: 'Maps',
        ),
        const NavigationDestination(
          icon: Icon(Icons.history_outlined),
          selectedIcon: Icon(Icons.history),
          label: 'Sessions',
        ),
        NavigationDestination(
          icon: Icon(isDiceVisible ? Icons.casino : Icons.casino_outlined),
          label: 'Dice',
        ),
        NavigationDestination(
          icon: Icon(isAiVisible ? Icons.auto_awesome : Icons.auto_awesome_outlined),
          label: 'Gemini',
        ),
      ],
      onDestinationSelected: (index) {
        if (index == 4) {
          ref.read(diceRollerVisibleProvider.notifier).state = !isDiceVisible;
        } else if (index == 5) {
          ref.read(aiAssistantVisibleProvider.notifier).state = !isAiVisible;
        } else {
          _onDestinationSelected(context, index);
        }
      },
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

class _NavActionIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onPressed;

  const _NavActionIcon({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? CatppuccinColors.mauve : Colors.white54;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, color: color),
          onPressed: onPressed,
          tooltip: label,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: color,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
