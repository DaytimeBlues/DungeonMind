import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/map_repository.dart';
import '../data/database/database.dart';
import 'database_provider.dart';

final mapRepositoryProvider = Provider<MapRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return MapRepository(db);
});

final mapPinsProvider = StreamProvider.family<List<MapPin>, String>((ref, mapId) {
  final repo = ref.watch(mapRepositoryProvider);
  return repo.watchPins(mapId);
});

final mapsProvider = StreamProvider.family<List<GameMap>, String>((ref, campaignId) {
  final repo = ref.watch(mapRepositoryProvider);
  return repo.watchMaps(campaignId);
});
