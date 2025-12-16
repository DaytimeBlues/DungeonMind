import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../providers/database_provider.dart';
import '../../providers/entity_providers.dart';
import '../../data/models/entity_types.dart';
import '../../core/theme/catppuccin_colors.dart';

/// Detail screen for viewing and editing a single entity
class EntityDetailScreen extends ConsumerStatefulWidget {
  final String entityId;

  const EntityDetailScreen({super.key, required this.entityId});

  @override
  ConsumerState<EntityDetailScreen> createState() => _EntityDetailScreenState();
}

class _EntityDetailScreenState extends ConsumerState<EntityDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _bodyController = TextEditingController();
  final _publicDescController = TextEditingController();
  bool _isEditing = false;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _bodyController.dispose();
    _publicDescController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entityAsync = ref.watch(selectedEntityProvider);

    return entityAsync.when(
      data: (entity) {
        if (entity == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Entity Not Found')),
            body: const Center(child: Text('Entity not found')),
          );
        }

        // Initialize controllers if not editing
        if (!_isEditing) {
          _bodyController.text = entity.bodyContent ?? '';
          _publicDescController.text = entity.publicDescription ?? '';
        }

        final entityType = EntityType.fromString(entity.type);
        final metadata = entity.metadata != null
            ? jsonDecode(entity.metadata!) as Map<String, dynamic>
            : <String, dynamic>{};

        return Scaffold(
          appBar: AppBar(
            title: Text(entity.title),
            actions: [
              if (_isEditing)
                TextButton.icon(
                  onPressed: _hasChanges ? () => _saveChanges(entity.id) : null,
                  icon: const Icon(Icons.check),
                  label: const Text('Save'),
                )
              else
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => setState(() => _isEditing = true),
                  tooltip: 'Edit',
                ),
              PopupMenuButton<String>(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: CatppuccinColors.red),
                        SizedBox(width: 8),
                        Text('Delete'),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'delete') {
                    _confirmDelete(entity.id);
                  }
                },
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Content'),
                Tab(text: 'Stats'),
                Tab(text: 'Links'),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              // Content tab
              _ContentTab(
                isEditing: _isEditing,
                bodyController: _bodyController,
                publicDescController: _publicDescController,
                bodyContent: entity.bodyContent,
                publicDescription: entity.publicDescription,
                onChanged: () => setState(() => _hasChanges = true),
              ),
              // Stats tab
              _StatsTab(entityType: entityType, metadata: metadata),
              // Links tab
              _LinksTab(entityId: entity.id),
            ],
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text('Error: $error')),
      ),
    );
  }

  Future<void> _saveChanges(String entityId) async {
    final repo = ref.read(entityRepositoryProvider);
    await repo.updateEntity(
      id: entityId,
      bodyContent: _bodyController.text,
      publicDescription: _publicDescController.text,
    );
    setState(() {
      _isEditing = false;
      _hasChanges = false;
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Changes saved')),
      );
    }
  }

  void _confirmDelete(String entityId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Entity?'),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () async {
              final repo = ref.read(entityRepositoryProvider);
              await repo.deleteEntity(entityId);
              if (context.mounted) {
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

/// Content tab with markdown editing/viewing
class _ContentTab extends StatelessWidget {
  final bool isEditing;
  final TextEditingController bodyController;
  final TextEditingController publicDescController;
  final String? bodyContent;
  final String? publicDescription;
  final VoidCallback onChanged;

  const _ContentTab({
    required this.isEditing,
    required this.bodyController,
    required this.publicDescController,
    required this.bodyContent,
    required this.publicDescription,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (isEditing) {
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'DM Notes',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: bodyController,
            maxLines: null,
            minLines: 8,
            decoration: InputDecoration(
              hintText: 'Your private notes... Use [[Entity Name]] to create links',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (_) => onChanged(),
          ),
          const SizedBox(height: 24),
          Text(
            'Player Description',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: publicDescController,
            maxLines: null,
            minLines: 4,
            decoration: InputDecoration(
              hintText: 'What players can see...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (_) => onChanged(),
          ),
        ],
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (bodyContent?.isNotEmpty == true) ...[
          Row(
            children: [
              const Icon(Icons.visibility_off, size: 16, color: CatppuccinColors.overlay1),
              const SizedBox(width: 8),
              Text(
                'DM Notes',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: MarkdownBody(
                data: bodyContent!,
                styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
        if (publicDescription?.isNotEmpty == true) ...[
          Row(
            children: [
              const Icon(Icons.visibility, size: 16, color: CatppuccinColors.green),
              const SizedBox(width: 8),
              Text(
                'Player Description',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: MarkdownBody(
                data: publicDescription!,
                styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
              ),
            ),
          ),
        ],
        if ((bodyContent?.isEmpty ?? true) && (publicDescription?.isEmpty ?? true))
          Center(
            child: Column(
              children: [
                const SizedBox(height: 64),
                Icon(
                  Icons.edit_note,
                  size: 48,
                  color: CatppuccinColors.overlay0,
                ),
                const SizedBox(height: 16),
                Text(
                  'No content yet',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap the edit button to add notes',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Stats tab for entity metadata (HP, AC, etc.)
class _StatsTab extends StatelessWidget {
  final EntityType entityType;
  final Map<String, dynamic> metadata;

  const _StatsTab({required this.entityType, required this.metadata});

  @override
  Widget build(BuildContext context) {
    if (metadata.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.analytics_outlined,
              size: 48,
              color: CatppuccinColors.overlay0,
            ),
            const SizedBox(height: 16),
            Text(
              'No stats defined',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Stats will appear here for combat-ready entities',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: metadata.entries.map((entry) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            title: Text(entry.key),
            trailing: Text(
              entry.value.toString(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: CatppuccinColors.mauve,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// Links tab showing relationships
class _LinksTab extends ConsumerWidget {
  final String entityId;

  const _LinksTab({required this.entityId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final outgoingEdgesAsync = ref.watch(selectedEntityEdgesProvider);
    final incomingEdgesAsync = ref.watch(incomingEdgesProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Links From This Entity',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        outgoingEdgesAsync.when(
          data: (edges) {
            if (edges.isEmpty) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'No outgoing links. Use [[Entity Name]] in content to create links.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              );
            }
            return Column(
              children: edges.map((edge) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: const Icon(Icons.arrow_forward),
                  title: Text(edge.targetId),
                  subtitle: Text(edge.edgeType),
                ),
              )).toList(),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (e, s) => Text('Error: $e'),
        ),
        const SizedBox(height: 24),
        Text(
          'Links To This Entity',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        incomingEdgesAsync.when(
          data: (edges) {
            if (edges.isEmpty) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'No incoming links. Other entities can link here using [[${entityId.substring(0, 8)}...]]',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              );
            }
            return Column(
              children: edges.map((edge) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: const Icon(Icons.arrow_back),
                  title: Text(edge.sourceId),
                  subtitle: Text(edge.edgeType),
                ),
              )).toList(),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (e, s) => Text('Error: $e'),
        ),
      ],
    );
  }
}
