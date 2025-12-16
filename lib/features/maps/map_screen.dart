import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/catppuccin_colors.dart';
import '../../providers/map_providers.dart';
import '../../providers/campaign_providers.dart';
import '../../data/repositories/map_repository.dart';
import '../../data/database/database.dart'; // For MapPin type
import '../../core/data/campaign_seeder.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  bool _isRevealMode = false;
  final List<Path> _revealedPaths = [];
  Path? _currentPath;
  double _brushSize = 40.0;

  // Initialize the map in the database if it doesn't exist
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ensureMapExists();
    });
  }

  Future<void> _ensureMapExists() async {
    final campaignId = ref.read(selectedCampaignIdProvider);
    if (campaignId == null) return;

    final repo = ref.read(mapRepositoryProvider);
    // Determine if map exists. For this demo, we assume corresponding to the asset.
    // In a real app, we'd query by title or some constant ID.
    // simpler: check if ANY map exists, if not create Neverwinter.
    final mapsStream = repo.watchMaps(campaignId);
    final maps = await mapsStream.first;
    
    if (maps.isEmpty) {
      final map = await repo.createMap(
        campaignId: campaignId,
        title: 'Region of Neverwinter',
        imagePath: 'assets/images/neverwinter.png',
        width: 2048,
        height: 2048,
      );
      
      // Auto-seed campaign content for this map
      await ref.read(campaignSeederProvider).seedPhandalin(campaignId, map.id);
    } else {
       // Also try seeding if map exists but content missing (seeder handles checks)
       await ref.read(campaignSeederProvider).seedPhandalin(campaignId, maps.first.id);
    }
  }

  void _startPath(Offset point) {
    setState(() {
      _currentPath = Path();
      _currentPath!.moveTo(point.dx, point.dy);
    });
  }

  void _updatePath(Offset point) {
    setState(() {
      _currentPath!.lineTo(point.dx, point.dy);
    });
  }

  void _endPath() {
    setState(() {
      if (_currentPath != null) {
        _revealedPaths.add(_currentPath!);
        _currentPath = null;
      }
    });
  }

  void _clearFog() {
    setState(() {
      _revealedPaths.clear();
    });
  }

  Future<void> _addPin(Offset position, String mapId) async {
    final repo = ref.read(mapRepositoryProvider);
    // Add a default pin at the tapped location
    // We store X/Y as percentage (0.0-1.0) or absolute?
    // Using absolute image coordinates is safer if we know image size.
    // Here we use layout builder constraints or just absolute pixels of the child container.
    // The GestureDetector is over the image. position is local to the image.
    
    await repo.addPin(
      mapId: mapId,
      x: position.dx,
      y: position.dy,
    );
     if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pin added! Long press to details.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final campaignId = ref.watch(selectedCampaignIdProvider);
    final mapsAsync = ref.watch(mapsProvider(campaignId ?? ''));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Neverwinter Region'),
        actions: [
          IconButton(
            icon: Icon(
              _isRevealMode ? Icons.brush : Icons.move_up,
              color: _isRevealMode ? CatppuccinColors.green : CatppuccinColors.overlay1,
            ),
            tooltip: _isRevealMode ? 'Switch to Navigation' : 'Switch to Reveal Mode',
            onPressed: () => setState(() => _isRevealMode = !_isRevealMode),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _clearFog,
            tooltip: 'Reset Fog',
          ),
        ],
      ),
      body: mapsAsync.when(
        data: (maps) {
          if (maps.isEmpty) {
            return const Center(child: CircularProgressIndicator()); // Creating...
          }
          final map = maps.first;
          
          return _MapInteractiveView(
            map: map,
            isRevealMode: _isRevealMode,
            revealedPaths: _revealedPaths,
            currentPath: _currentPath,
            brushSize: _brushSize,
            onPanStart: _startPath,
            onPanUpdate: _updatePath,
            onPanEnd: _endPath,
            onLongPress: (pos) => _addPin(pos, map.id),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _MapInteractiveView extends ConsumerWidget {
  final GameMap map;
  final bool isRevealMode;
  final List<Path> revealedPaths;
  final Path? currentPath;
  final double brushSize;
  final Function(Offset) onPanStart;
  final Function(Offset) onPanUpdate;
  final VoidCallback onPanEnd;
  final Function(Offset) onLongPress;

  const _MapInteractiveView({
    required this.map,
    required this.isRevealMode,
    required this.revealedPaths,
    required this.currentPath,
    required this.brushSize,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinsAsync = ref.watch(mapPinsProvider(map.id));

    return InteractiveViewer(
      panEnabled: !isRevealMode,
      scaleEnabled: !isRevealMode,
      minScale: 0.1,
      maxScale: 4.0,
      constrained: false, // Allow infinite scroll for large map
      child: GestureDetector(
         onLongPressStart: isRevealMode ? null : (details) {
           onLongPress(details.localPosition);
         },
         child: Stack(
          children: [
            Image.asset(
              map.imagePath,
              fit: BoxFit.none,
            ),
            // Pins Layer
            pinsAsync.when(
              data: (pins) => Stack(
                children: pins.map((pin) => Positioned(
                  left: pin.x - 24, // Center icon
                  top: pin.y - 48,  // Bottom of icon at point
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text('Pin: ${pin.icon}')),
                      );
                    },
                    child: const Icon(
                      Icons.location_on,
                      size: 48,
                      color: CatppuccinColors.red,
                    ),
                  ),
                )).toList(),
              ),
              loading: () => const SizedBox(),
              error: (_,__) => const SizedBox(),
            ),
            // Fog Layer
            Positioned.fill(
              child: CustomPaint(
                painter: FogPainter(
                  revealedPaths: [
                    ...revealedPaths,
                    if (currentPath != null) currentPath!,
                  ],
                  brushSize: brushSize,
                ),
                child: isRevealMode
                    ? GestureDetector(
                        onPanStart: (details) => onPanStart(details.localPosition),
                        onPanUpdate: (details) => onPanUpdate(details.localPosition),
                        onPanEnd: (details) => onPanEnd(),
                        behavior: HitTestBehavior.translucent,
                        child: Container(color: Colors.transparent),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FogPainter extends CustomPainter {
  final List<Path> revealedPaths;

  final double brushSize;

  FogPainter({required this.revealedPaths, this.brushSize = 40.0});

  @override
  void paint(Canvas canvas, Size size) {
    // Save layer to apply composite operation
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    // 1. Draw the darkness (Fog)
    canvas.drawColor(Colors.black.withOpacity(0.9), BlendMode.srcOver);

    // 2. Erase the fog where user swiped
    final paint = Paint()
      ..blendMode = BlendMode.clear
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = brushSize;

    for (final path in revealedPaths) {
      canvas.drawPath(path, paint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant FogPainter oldDelegate) {
    return oldDelegate.revealedPaths.length != revealedPaths.length; // Simple check
  }
}
