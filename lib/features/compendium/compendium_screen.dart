import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/srd_service.dart';
import '../../core/theme/catppuccin_colors.dart';
import '../../data/models/entity_types.dart';
import '../../providers/entity_providers.dart';
import '../../providers/database_provider.dart';

class CompendiumScreen extends ConsumerStatefulWidget {
  final String campaignId;

  const CompendiumScreen({super.key, required this.campaignId});

  @override
  ConsumerState<CompendiumScreen> createState() => _CompendiumScreenState();
}

class _CompendiumScreenState extends ConsumerState<CompendiumScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  
  // State
  bool _isLoading = false;
  String? _error;
  List<Map<String, dynamic>> _results = [];
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabChange);
    // Initial load? No, wait for search.
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      // Clear results or auto-search if query exists?
      if (_searchController.text.isNotEmpty) {
        _performSearch();
      } else {
        setState(() {
          _results = [];
          _error = null;
        });
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  EntityType _getTypeForIndex(int index) {
    switch (index) {
      case 0: return EntityType.spell;
      case 1: return EntityType.monster;
      case 2: return EntityType.item;
      default: return EntityType.item;
    }
  }

  Future<void> _performSearch() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final service = ref.read(srdServiceProvider);
      final type = _getTypeForIndex(_tabController.index);
      final results = await service.search(query, type: type);
      
      setState(() {
        _results = results.cast<Map<String, dynamic>>();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _importItem(String index, String name, EntityType type) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Importing...')),
      );

      final service = ref.read(srdServiceProvider);
      final repo = ref.read(entityRepositoryProvider);
      
      // Fetch details: index and type string ('Spell', 'Monster')
      final typeStr = type == EntityType.spell ? 'Spell' : type == EntityType.monster ? 'Monster' : 'Item';
      final data = await service.getDetail(index, typeStr);
      final metadata = service.convertToMetadata(data);

      // Determine contents
      String publicDesc = '';
      String bodyContent = '';

      if (type == EntityType.spell) {
        publicDesc = (data['description'] ?? '');
        bodyContent = '## Stats\n- Level: ${data['level']}\n- School: ${data['level_school']}\n- Casting Time: ${data['casting_time']}\n- Range: ${data['range']}\n- Components: ${data['components']}\n- Duration: ${data['duration']}';
      } else if (type == EntityType.monster) {
        publicDesc = data['description'] ?? '';
        bodyContent = '## Stats\n- AC: ${data['ac']}\n- HP: ${data['hp']}\n- Speed: ${data['speed']}\n- CR: ${data['cr']}';
      } else {
        publicDesc = data['description'] ?? '';
      }

      // Create Entity
      final entity = await repo.createEntity(
        campaignId: widget.campaignId,
        type: type,
        title: name,
        publicDescription: publicDesc,
        bodyContent: bodyContent,
        metadata: metadata,
        isRevealed: true,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Imported "$name" successfully!'),
            action: SnackBarAction(
              label: 'View',
              onPressed: () {
                ref.read(selectedEntityIdProvider.notifier).state = entity.id;
                context.pushNamed('entity-detail', pathParameters: {'id': entity.id});
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Import failed: $e')));
      }
    }
  }

  void _showDetailPreview(Map<String, dynamic> result) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(result['name']),
        content: const Text('Do you want to import this into your campaign? It will be created as a new Entity.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton.icon(
            icon: const Icon(Icons.download),
            label: const Text('Import'),
            onPressed: () {
              Navigator.pop(context);
              _importItem(
                result['index'], 
                result['name'], 
                _getTypeForIndex(_tabController.index),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SRD Compendium'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Spells', icon: Icon(Icons.auto_fix_high)),
            Tab(text: 'Monsters', icon: Icon(Icons.bug_report)), // Skull icon custom? Use bug for now
            Tab(text: 'Items', icon: Icon(Icons.diamond)),
            Tab(text: 'Gear', icon: Icon(Icons.backpack)),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search (e.g. Fireball, Goblin)...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: _performSearch,
                ),
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (_) => _performSearch(),
            ),
          ),
          Expanded(
            child: _isLoading 
                ? const Center(child: CircularProgressIndicator()) 
                : _error != null
                    ? Center(child: Text('Error: $_error', style: const TextStyle(color: Colors.red)))
                    : ListView.builder(
                        itemCount: _results.length,
                        itemBuilder: (context, index) {
                          final item = _results[index];
                          return ListTile(
                            title: Text(item['name']),
                            subtitle: Text(item['index']),
                            trailing: const Icon(Icons.add_circle_outline, color: CatppuccinColors.mauve),
                            onTap: () => _showDetailPreview(item),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
