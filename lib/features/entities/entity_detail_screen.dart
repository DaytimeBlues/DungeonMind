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
import '../../core/theme/grimoire_scaffold.dart';

class EntityDetailScreen extends ConsumerStatefulWidget {
  final String entityId;

  const EntityDetailScreen({super.key, required this.entityId});

  @override
  ConsumerState<EntityDetailScreen> createState() => _EntityDetailScreenState();
}

class _EntityDetailScreenState extends ConsumerState<EntityDetailScreen> with SingleTickerProviderStateMixin {
  bool _isEditing = false;
  bool _hasChanges = false;
  late TextEditingController _bodyController;
  late TextEditingController _publicDescController;
  late TabController _tabController;
  
  String? _currentEntityId;
  bool _isRevealed = false;
  Map<String, dynamic> _metadata = {};

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    final entityAsync = ref.watch(entityProvider(widget.entityId));

    return entityAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, st) => Scaffold(body: Center(child: Text('Error: $err'))),
      data: (entity) {
        if (entity == null) return const Scaffold(body: Center(child: Text('Entity not found')));

        final entityType = EntityType.fromString(entity.type);
        
        // Init state from entity if changed
        if (_currentEntityId != entity.id) {
          _currentEntityId = entity.id;
          _bodyController.text = entity.bodyContent ?? '';
          _publicDescController.text = entity.publicDescription ?? '';
          _PublicDescControllerListener(); // Re-attach listener if needed? No, just set text.
           _isRevealed = entity.isRevealed;
          final dbMetadata = ref.read(entityRepositoryProvider).parseMetadata(entity);
          _isRevealed = entity.isRevealed;
          _metadata = dbMetadata != null ? Map<String, dynamic>.from(dbMetadata) : {};
        }

        return GrimoireScaffold(
          appBar: AppBar(
            title: Text(entity.title),
            actions: [
              IconButton(
                icon: Icon(_isEditing ? Icons.save : Icons.edit),
                onPressed: () {
                  if (_isEditing) {
                    _saveChanges(entity.id);
                  } else {
                    setState(() {
                      _isEditing = true;
                    });
                  }
                },
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Details'),
                Tab(text: 'Stats'),
                Tab(text: 'Conversation'),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              // Details Tab
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildSectionHeader('Public Description'),
                     if (_isEditing)
                      TextField(
                        controller: _publicDescController,
                        maxLines: 5,
                        decoration: const InputDecoration(border: OutlineInputBorder()),
                        onChanged: (_) => setState(() => _hasChanges = true),
                      )
                    else
                      MarkdownBody(data: entity.publicDescription ?? 'No description.'),
                    
                    const SizedBox(height: 20),
                    _buildSectionHeader('Private Notes'),
                     if (_isEditing)
                      TextField(
                        controller: _bodyController,
                        maxLines: 10,
                        decoration: const InputDecoration(border: OutlineInputBorder()),
                         onChanged: (_) => setState(() => _hasChanges = true),
                      )
                    else
                      MarkdownBody(data: entity.bodyContent ?? 'No notes.'),
                      
                    const SizedBox(height: 20),
                    SwitchListTile(
                      title: const Text('Revealed to Players'),
                      value: _isRevealed,
                      onChanged: _isEditing ? (val) => setState(() {
                        _isRevealed = val;
                        _hasChanges = true;
                      }) : null,
                    ),
                  ],
                ),
              ),
              
              // Stats Tab
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
              
              // Conversation (AI) Tab - Placeholder logic
              const  Center(child: Text('Conversation History Implementation Needed')),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(title, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }

  void _PublicDescControllerListener() {}
}

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
    
    // View Mode
    if (metadata.isEmpty) {
      return const Center(child: Text('No stats defined.'));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: metadata.entries.map((e) {
        return Card(
           margin: const EdgeInsets.only(bottom: 8),
           child: ListTile(
             title: Text(e.key, style: const TextStyle(fontWeight: FontWeight.bold)),
             subtitle: Text(e.value.toString()),
           ),
        );
      }).toList(),
    );
  }
}
