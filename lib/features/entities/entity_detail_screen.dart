import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../providers/database_provider.dart';
import '../../providers/entity_providers.dart';
import '../../data/models/entity_types.dart';
import '../../core/utils/wikilink_utils.dart';
import '../../core/services/ai_service.dart';
import 'widgets/metadata_editor.dart';
import '../../core/theme/catppuccin_colors.dart';
// ... imports
import 'widgets/metadata_editor.dart';

// ... inside _EntityDetailScreenState
  // State for form
  bool _isEditing = false;
  bool _hasChanges = false;
  late TextEditingController _bodyController;
  late TextEditingController _publicDescController;
  late TabController _tabController;
  
  // Track current entity to reset form when navigating
  String? _currentEntityId;
  bool _isRevealed = false;
  Map<String, dynamic> _metadata = {}; // Local metadata state

// ... inside build method, data: (entity) block
        final entityType = EntityType.fromString(entity.type);
        // Parse metadata once per entity load
        final dbMetadata = ref.read(entityRepositoryProvider).parseMetadata(entity);

        if (_currentEntityId != entity.id) {
          _currentEntityId = entity.id;
          _bodyController.text = entity.bodyContent ?? '';
          _publicDescController.text = entity.publicDescription ?? '';
          _isRevealed = entity.isRevealed;
          _metadata = Map.from(dbMetadata); // Init local copy
        }

// ... inside _saveChanges
  Future<void> _saveChanges(String entityId) async {
    final repo = ref.read(entityRepositoryProvider);
    await repo.updateEntity(
      id: entityId,
      bodyContent: _bodyController.text,
      publicDescription: _publicDescController.text,
      isRevealed: _isRevealed,
      metadata: _metadata, // Save metadata
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

// ... inside TabBarView children
              _StatsTab(
                entityType: entityType, 
                metadata: _metadata, 
                isEditing: _isEditing,
                onMetadataChanged: (val) {
                  setState(() {
                    _metadata = val;
                    _hasChanges = true;
                  });
                },
              ),

// ... _StatsTab definition
class _StatsTab extends StatelessWidget {
  final EntityType entityType;
  final Map<String, dynamic> metadata;
  final bool isEditing;
  final ValueChanged<Map<String, dynamic>> onMetadataChanged;

  const _StatsTab({
    required this.entityType, 
    required this.metadata,
    required this.isEditing,
    required this.onMetadataChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (isEditing) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: MetadataEditor(
          metadata: metadata,
          onChanged: onMetadataChanged,
        ),
      );
    }

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
              'Tap edit to add stats (HP, AC, etc.)',
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
  final String entityId;

  const EntityDetailScreen({super.key, required this.entityId});

  @override
  ConsumerState<EntityDetailScreen> createState() => _EntityDetailScreenState();
}

class _EntityDetailScreenState extends ConsumerState<EntityDetailScreen>
    with SingleTickerProviderStateMixin {
  // State for form
  bool _isEditing = false;
  bool _hasChanges = false;
  late TextEditingController _bodyController;
  late TextEditingController _publicDescController;
  late TabController _tabController;
  
  // Track current entity to reset form when navigating
  String? _currentEntityId;
  bool _isRevealed = false;

  @override
  void initState() {
    super.initState();
    // Controllers initialized empty, populated in build
    _bodyController = TextEditingController();
    _publicDescController = TextEditingController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _bodyController.dispose();
    _publicDescController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch selected entity
    final id = ref.watch(selectedEntityIdProvider);
    // If no ID selected, show placeholder or redirect?
    // Handled by parent usually, but safe to check.
    
    // Watch entity stream
    final entityAsync = id != null 
        ? ref.watch(entityProvider(id)) 
        : const AsyncValue.loading();
        
    return entityAsync.when(
      data: (entity) {
        if (entity == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Entity Not Found')),
            body: const Center(child: Text('Entity not found')),
          );
        }

        // If entity changed, update controllers
        // Parse metadata once per entity load
        final dbMetadata = ref.read(entityRepositoryProvider).parseMetadata(entity);

        if (_currentEntityId != entity.id) {
          _currentEntityId = entity.id;
          _bodyController.text = entity.bodyContent ?? '';
          _publicDescController.text = entity.publicDescription ?? '';
          _isRevealed = entity.isRevealed;
          _metadata = Map.from(dbMetadata);
        }
        
        final entityType = EntityType.fromString(entity.type);
        // dbMetadata is unused here as we use _metadata now


        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (Navigator.canPop(context)) {
                   Navigator.pop(context);
                } else {
                   context.go('/entities'); 
                }
              },
            ),
            title: Text(entity.title),
            actions: [
               // Analyze Logic Button
               IconButton(
                 icon: const Icon(Icons.auto_awesome, color: CatppuccinColors.mauve),
                 tooltip: 'Analyze Logic',
                 onPressed: () => _analyzeEntity(entity),
               ),
               // Edit/Save Button
              _isEditing
                  ? IconButton(
                      icon: const Icon(Icons.save),
                      onPressed: () => _saveChanges(entity.id),
                    )
                  : IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => setState(() => _isEditing = true),
                    ),
              PopupMenuButton<String>(
                itemBuilder: (context) => [
                   PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: const [
                        Icon(Icons.delete, color: Colors.red),
                         SizedBox(width: 8),
                        Text('Delete Entity', style: TextStyle(color: Colors.red)),
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
                campaignId: entity.campaignId,
                isRevealed: _isRevealed,
                onChanged: () => setState(() => _hasChanges = true),
                onRevealChanged: (val) => _saveRevealState(entity.id, val),
                onLinkTap: (href) => _handleLinkTap(href, entity.campaignId),
              ),
              // Stats tab
              _StatsTab(
                entityType: entityType, 
                metadata: _metadata,
                isEditing: _isEditing,
                onMetadataChanged: (val) {
                   setState(() {
                     _metadata = val;
                     _hasChanges = true;
                   });
                },
              ),
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

  Future<void> _saveRevealState(String entityId, bool value) async {
     setState(() => _isRevealed = value);
     final repo = ref.read(entityRepositoryProvider);
     await repo.updateEntity(id: entityId, isRevealed: value);
     if (mounted) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(value ? 'Entity Marked as Known' : 'Entity Marked as Unknown')),
       );
     }
  }

  Future<void> _saveChanges(String entityId) async {
    final repo = ref.read(entityRepositoryProvider);
    await repo.updateEntity(
      id: entityId,
      bodyContent: _bodyController.text,
      publicDescription: _publicDescController.text,
      isRevealed: _isRevealed,
      metadata: _metadata,
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

  void _showApiKeyDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Gemini API Key'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter your API key'),
          obscureText: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              ref.read(aiServiceProvider).saveApiKey(controller.text.trim());
              Navigator.pop(context);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Key Saved')));
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _analyzeEntity(Entity entity) async {
    final aiService = ref.read(aiServiceProvider);
    final key = await aiService.getApiKey();
    if (key == null || key.isEmpty) {
      if (mounted) _showApiKeyDialog();
      return;
    }

    if (!mounted) return;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
          color: Theme.of(context).canvasColor,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(children: [
                 const Icon(Icons.auto_awesome, color: CatppuccinColors.mauve),
                 const SizedBox(width: 8),
                 Text('AI Analysis', style: Theme.of(context).textTheme.titleLarge),
                 const Spacer(),
                 IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
               ]),
               const Divider(),
               Expanded(
                 child: FutureBuilder<String>(
                  future: aiService.checkEntityLogic(jsonEncode(entity.toJson())),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Consulting the weave...'),
                        ],
                      ));
                    }
                    if (snapshot.hasError) {
                      return Center(child: SelectableText('Error: ${snapshot.error}'));
                    }
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: MarkdownBody(
                        data: snapshot.data ?? 'No insight provided.',
                        styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
                      ),
                    );
                  },
                ),
               ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLinkTap(String? href, String campaignId) async {
    if (href == null) return;
    
    if (href.startsWith('wikilink:')) {
      final targetName = href.substring(9);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Looking for "$targetName"...'), duration: const Duration(seconds: 1)),
      );

      final repo = ref.read(entityRepositoryProvider);
      try {
        final results = await repo.searchEntities(campaignId, targetName).first;
        Entity? target;
        try {
          target = results.firstWhere((e) => e.title.toLowerCase() == targetName.toLowerCase());
        } catch (_) {
          if (results.isNotEmpty) target = results.first;
        }

        if (mounted) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          if (target != null) {
            ref.read(selectedEntityIdProvider.notifier).state = target.id;
            context.pushNamed('entity-detail', pathParameters: {'id': target.id});
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Entity "$targetName" not found.'), behavior: SnackBarBehavior.floating),
            );
          }
        }
      } catch (e) {
        if (mounted) {
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      }
    } else {
      debugPrint('Tapped link: $href');
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
                Navigator.pop(context); // Dialog
                Navigator.pop(context); // Screen
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
  final String campaignId;
  final bool isRevealed;
  final VoidCallback onChanged;
  final ValueChanged<bool> onRevealChanged;
  final Function(String?) onLinkTap;

  const _ContentTab({
    required this.isEditing,
    required this.bodyController,
    required this.publicDescController,
    required this.bodyContent,
    required this.publicDescription,
    required this.campaignId,
    required this.isRevealed,
    required this.onChanged,
    required this.onRevealChanged,
    required this.onLinkTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Known/Unknown Toggle
          Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: SwitchListTile(
              title: Text(
                isRevealed ? 'Known to Party' : 'Unknown to Party',
                style: TextStyle(
                  color: isRevealed ? CatppuccinColors.green : CatppuccinColors.overlay1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(isRevealed 
                  ? 'Showing full details' 
                  : 'Showing limited information'),
              value: isRevealed,
              onChanged: onRevealChanged,
              secondary: Icon(
                isRevealed ? Icons.visibility : Icons.visibility_off,
                color: isRevealed ? CatppuccinColors.green : CatppuccinColors.overlay0,
              ),
            ),
          ),

          // DM Content (Body)
          Row(
            children: [
              const Icon(Icons.security, size: 16, color: CatppuccinColors.red),
              const SizedBox(width: 8),
              Text(
                'DM Notes',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: CatppuccinColors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (!isRevealed) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: CatppuccinColors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('HIDDEN FROM PLAYERS', style: TextStyle(fontSize: 10, color: CatppuccinColors.red)),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          if (isEditing)
            TextField(
              controller: bodyController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Enter secret DM notes here... Use [[Entity Name]] for links.',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => onChanged(),
            )
          else
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: CatppuccinColors.surface1),
              ),
              child: MarkdownBody(
                data: bodyContent?.isNotEmpty == true 
                    ? WikilinkUtils.processWikilinks(bodyContent!) 
                    : '*No private content*',
                onTapLink: (text, href, title) => onLinkTap(href),
                styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                  p: const TextStyle(height: 1.5),
                ),
              ),
            ),
          
          const SizedBox(height: 24),
          
          // Public Description
          Row(
            children: [
              const Icon(Icons.public, size: 16, color: CatppuccinColors.blue),
              const SizedBox(width: 8),
              Text(
                'Player Description',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: CatppuccinColors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
               Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: CatppuccinColors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('VISIBLE', style: TextStyle(fontSize: 10, color: CatppuccinColors.green)),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (isEditing)
            TextField(
              controller: publicDescController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Enter public description here...',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => onChanged(),
            )
          else
             Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: CatppuccinColors.surface1),
              ),
              child: MarkdownBody(
                data: publicDescription?.isNotEmpty == true 
                    ? WikilinkUtils.processWikilinks(publicDescription!) 
                    : '*No public description*',
                onTapLink: (text, href, title) => onLinkTap(href),
                styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                  p: const TextStyle(height: 1.5),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Stats tab for entity metadata (HP, AC, etc.)
class _StatsTab extends StatelessWidget {
  final EntityType entityType;
  final Map<String, dynamic> metadata;
  final bool isEditing;
  final ValueChanged<Map<String, dynamic>> onMetadataChanged;

  const _StatsTab({
    required this.entityType,
    required this.metadata,
    required this.isEditing,
    required this.onMetadataChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (isEditing) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: MetadataEditor(
          metadata: metadata,
          onChanged: onMetadataChanged,
        ),
      );
    }

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
              'Tap edit to add stats',
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
