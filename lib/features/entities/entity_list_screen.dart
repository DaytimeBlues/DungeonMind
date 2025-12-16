import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../providers/database_provider.dart';
import '../../providers/campaign_providers.dart';
import '../../providers/entity_providers.dart';
import '../../data/models/entity_types.dart';
import '../../core/theme/catppuccin_colors.dart';

/// Screen showing all entities for the current campaign with filtering
class EntityListScreen extends ConsumerWidget {
  const EntityListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campaignId = ref.watch(selectedCampaignIdProvider);
    final entitiesAsync = ref.watch(entitiesProvider);
    final typeFilter = ref.watch(entityTypeFilterProvider);
    final searchQuery = ref.watch(entitySearchQueryProvider);

    if (campaignId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Entities')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.folder_off, size: 64, color: CatppuccinColors.overlay0),
              const SizedBox(height: 16),
              Text(
                'No campaign selected',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Select a campaign from the Campaigns tab',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => context.go('/campaigns'),
                child: const Text('Go to Campaigns'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Entities'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search entities...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              ref.read(entitySearchQueryProvider.notifier).state = '';
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onChanged: (value) {
                    ref.read(entitySearchQueryProvider.notifier).state = value;
                  },
                ),
              ),
              // Type filter chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    FilterChip(
                      label: const Text('All'),
                      selected: typeFilter == null,
                      onSelected: (_) {
                        ref.read(entityTypeFilterProvider.notifier).state = null;
                      },
                    ),
                    const SizedBox(width: 8),
                    ...EntityType.values.map((type) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(type.displayName),
                        selected: typeFilter == type,
                        onSelected: (_) {
                          ref.read(entityTypeFilterProvider.notifier).state =
                              typeFilter == type ? null : type;
                        },
                      ),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      body: entitiesAsync.when(
        data: (entities) {
          if (entities.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.note_add_outlined,
                    size: 64,
                    color: CatppuccinColors.teal.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    searchQuery.isNotEmpty
                        ? 'No results for "$searchQuery"'
                        : 'No entities yet',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create NPCs, locations, items, and more',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: entities.length,
            itemBuilder: (context, index) {
              final entity = entities[index];
              final entityType = EntityType.fromString(entity.type);

              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: _EntityIcon(type: entityType),
                  title: Text(entity.title),
                  subtitle: Row(
                    children: [
                      _TypeBadge(type: entityType),
                      if (entity.completenessScore < 1.0) ...[
                        const SizedBox(width: 8),
                        _CompletenessIndicator(score: entity.completenessScore),
                      ],
                    ],
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ref.read(selectedEntityIdProvider.notifier).state = entity.id;
                    context.go('/entities/${entity.id}');
                  },
                ),
              )
                  .animate()
                  .fadeIn(delay: (index * 30).ms)
                  .slideX(begin: 0.05, end: 0, delay: (index * 30).ms);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateEntityDialog(context, ref, campaignId),
        icon: const Icon(Icons.add),
        label: const Text('New Entity'),
      ),
    );
  }

  void _showCreateEntityDialog(BuildContext context, WidgetRef ref, String campaignId) {
    final titleController = TextEditingController();
    EntityType selectedType = EntityType.npc;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Create Entity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'e.g., Gandalf, Rivendell, Excalibur',
                ),
                autofocus: true,
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<EntityType>(
                value: selectedType,
                decoration: const InputDecoration(labelText: 'Type'),
                items: EntityType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.displayName),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => selectedType = value);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                if (titleController.text.trim().isEmpty) return;

                final repo = ref.read(entityRepositoryProvider);
                final entity = await repo.createEntity(
                  campaignId: campaignId,
                  type: selectedType,
                  title: titleController.text.trim(),
                );

                if (context.mounted) {
                  Navigator.pop(context);
                  ref.read(selectedEntityIdProvider.notifier).state = entity.id;
                  context.go('/entities/${entity.id}');
                }
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Icon for entity type
class _EntityIcon extends StatelessWidget {
  final EntityType type;

  const _EntityIcon({required this.type});

  @override
  Widget build(BuildContext context) {
    final color = _getColorForType(type);
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(_getIconForType(type), color: color, size: 20),
    );
  }

  Color _getColorForType(EntityType type) {
    switch (type) {
      case EntityType.npc:
        return CatppuccinColors.mauve;
      case EntityType.location:
        return CatppuccinColors.green;
      case EntityType.item:
        return CatppuccinColors.peach;
      case EntityType.lore:
        return CatppuccinColors.blue;
      case EntityType.event:
        return CatppuccinColors.yellow;
      case EntityType.faction:
        return CatppuccinColors.teal;
    }
  }

  IconData _getIconForType(EntityType type) {
    switch (type) {
      case EntityType.npc:
        return Icons.person;
      case EntityType.location:
        return Icons.place;
      case EntityType.item:
        return Icons.inventory_2;
      case EntityType.lore:
        return Icons.auto_stories;
      case EntityType.event:
        return Icons.event;
      case EntityType.faction:
        return Icons.groups;
    }
  }
}

/// Badge showing entity type
class _TypeBadge extends StatelessWidget {
  final EntityType type;

  const _TypeBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        type.displayName,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}

/// Small indicator showing entity completeness
class _CompletenessIndicator extends StatelessWidget {
  final double score;

  const _CompletenessIndicator({required this.score});

  @override
  Widget build(BuildContext context) {
    final percent = (score * 100).round();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 40,
          height: 4,
          child: LinearProgressIndicator(
            value: score,
            backgroundColor: CatppuccinColors.surface1,
            valueColor: AlwaysStoppedAnimation(
              score < 0.5 ? CatppuccinColors.peach : CatppuccinColors.green,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '$percent%',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: CatppuccinColors.overlay1,
          ),
        ),
      ],
    );
  }
}
