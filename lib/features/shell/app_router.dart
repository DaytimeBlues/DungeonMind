import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shell/app_shell.dart';
import '../../features/campaigns/campaign_list_screen.dart';
import '../../features/campaigns/campaign_detail_screen.dart';
import '../../features/entities/entity_list_screen.dart';
import '../../features/entities/entity_detail_screen.dart';
import '../../features/maps/map_screen.dart';
import '../../features/compendium/compendium_screen.dart';

/// App router configuration using go_router
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/campaigns',
    routes: [
      // Shell route wraps main navigation destinations
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          // Campaigns tab
          GoRoute(
            path: '/campaigns',
            name: 'campaigns',
            builder: (context, state) => const CampaignListScreen(),
          ),
          // Campaign detail (still in shell)
          GoRoute(
            path: '/campaigns/:id',
            name: 'campaign-detail',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return CampaignDetailScreen(campaignId: id);
            },
            routes: [
               GoRoute(
                 path: 'compendium',
                 name: 'compendium',
                 builder: (context, state) {
                   final id = state.pathParameters['id']!;
                   return CompendiumScreen(campaignId: id);
                 },
               ),
            ],
          ),
          // Entities tab
          GoRoute(
            path: '/entities',
            name: 'entities',
            builder: (context, state) => const EntityListScreen(),
          ),
          // Entity detail
          GoRoute(
            path: '/entities/:id',
            name: 'entity-detail',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return EntityDetailScreen(entityId: id);
            },
          ),
          // Maps tab (placeholder for Phase 5)
          GoRoute(
            path: '/maps',
            name: 'maps',
            builder: (context, state) => const MapScreen(),
          ),
          // Session logs tab
          GoRoute(
            path: '/sessions',
            name: 'sessions',
            builder: (context, state) => const _PlaceholderScreen(title: 'Sessions'),
          ),
        ],
      ),
    ],
  );
});

/// Placeholder screen for features not yet implemented
class _PlaceholderScreen extends StatelessWidget {
  final String title;

  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.construction_rounded,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Coming in a future phase',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
