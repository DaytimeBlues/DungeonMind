import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database/database.dart';
import '../data/repositories/campaign_repository.dart';
import '../data/repositories/entity_repository.dart';
import '../data/repositories/edge_repository.dart';

/// Single source of truth for the database instance
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

/// Campaign repository provider
final campaignRepositoryProvider = Provider<CampaignRepository>((ref) {
  return CampaignRepository(ref.watch(databaseProvider));
});

/// Entity repository provider
final entityRepositoryProvider = Provider<EntityRepository>((ref) {
  return EntityRepository(ref.watch(databaseProvider));
});

/// Edge repository provider
final edgeRepositoryProvider = Provider<EdgeRepository>((ref) {
  return EdgeRepository(ref.watch(databaseProvider));
});
