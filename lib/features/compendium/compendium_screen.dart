import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/srd_service.dart';
import '../../core/theme/catppuccin_colors.dart';
import '../../data/models/entity_types.dart';
import '../../providers/entity_providers.dart';

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

  Future<void> _performSearch() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final service = ref.read(srdServiceProvider);
      // Map tab index to category
      final category = SrdService.categories[_tabController.index];
      final results = await service.search(category, query);
      
      setState(() {
        _results = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _importItem(String url, String name, String category) async {
    try {
      // Show loading
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Importing...')),
      );

      final service = ref.read(srdServiceProvider);
      final repo = ref.read(entityRepositoryProvider);
      
      // Fetch details
      final data = await service.getDetail(url);
      final metadata = service.convertToMetadata(category, data);

      // Determine contents based on category
      String publicDesc = '';
      String bodyContent = '';
      EntityType type = EntityType.item;

      if (category == 'spells') {
        type = EntityType.spell;
        publicDesc = (data['desc'] as List?)?.join('\n\n') ?? '';
        bodyContent = 'Imported from SRD. Higher Level: ${(data['higher_level'] as List?)?.join('\n') ?? 'None'}';
      } else if (category == 'monsters') {
        type = EntityType.monster; // Using new type
        publicDesc = 'Size: ${data['size']} ${data['type']}, ${data['alignment']}';
        // Construct body from actions
        final actions = (data['actions'] as List?)?.map((a) => '### ${a['name']}\n${a['desc']}').join('\n\n') ?? '';
        final special = (data['special_abilities'] as List?)?.map((a) => '**${a['name']}**: ${a['desc']}').join('\n\n') ?? '';
        bodyContent = '## Abilities\n$special\n\n## Actions\n$actions';
      } else {
        type = EntityType.item; // Magic Items / Equipment
        publicDesc = (data['desc'] as List?)?.join('\n\n') ?? '';
        bodyContent = 'Rarity: ${data['rarity']?['name'] ?? 'Unknown'}';
      }

      // Create Entity
      final entity = await repo.createEntity(
        campaignId: widget.campaignId,
        type: type,
        title: name,
        publicDescription: publicDesc,
        bodyContent: bodyContent,
        metadata: metadata,
        isRevealed: true, // Compendium imports usually known? Or assume revealed.
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
    // Basic confirmation dialog before import
    // Ideally we fetch details to show PREVIEW, but for MVP we just confirm.
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
                result['url'], 
                result['name'], 
                SrdService.categories[_tabController.index],
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
