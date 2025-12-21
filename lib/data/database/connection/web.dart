import 'package:drift/drift.dart';
import 'package:drift/web.dart';

LazyDatabase connect() {
  return LazyDatabase(() async {
    print('DungeonMind: Creating WebDatabase with localStorage...');
    // Use simple WebDatabase which uses simpler IndexedDB approach
    final db = WebDatabase.withStorage(
      await DriftWebStorage.indexedDbIfSupported('dungeonmind'),
    );
    print('DungeonMind: WebDatabase created successfully');
    return db;
  });
}

