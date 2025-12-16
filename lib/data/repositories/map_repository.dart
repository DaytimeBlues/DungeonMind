import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../database/database.dart';

class MapRepository {
  final AppDatabase _db;
  static const _uuid = Uuid();

  MapRepository(this._db);

  Stream<List<GameMap>> watchMaps(String campaignId) {
    return _db.mapsByCampaign(campaignId).watch();
  }
  
  Future<GameMap?> getMapById(String id) {
    return _db.mapById(id).getSingleOrNull();
  }

  Future<GameMap> createMap({
    required String campaignId,
    required String title,
    required String imagePath,
    required int width,
    required int height,
  }) async {
    final map = GameMapsCompanion.insert(
      id: _uuid.v4(),
      campaignId: campaignId,
      title: title,
      imagePath: imagePath,
      width: width,
      height: height,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    await _db.into(_db.gameMaps).insert(map);
    return (await getMapById(map.id.value))!;
  }

  Stream<List<MapPin>> watchPins(String mapId) {
    return _db.pinsByMap(mapId).watch();
  }

  Future<MapPin> addPin({
    required String mapId,
    required double x,
    required double y,
    String? entityId,
    String icon = 'default',
  }) async {
    final pin = MapPinsCompanion.insert(
      id: _uuid.v4(),
      mapId: mapId,
      x: x,
      y: y,
      entityId: Value(entityId),
      icon: Value(icon),
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    await _db.into(_db.mapPins).insert(pin);
    return (await _db.pinsByMap(mapId).get()).firstWhere((p) => p.id == pin.id.value);
  }

  Future<void> deletePin(String pinId) async {
    await (_db.delete(_db.mapPins)..where((p) => p.id.equals(pinId))).go();
  }
}
