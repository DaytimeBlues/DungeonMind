import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database/database.dart';
import '../data/models/entity_types.dart';
import 'database_provider.dart';
import 'campaign_providers.dart';

/// Currently selected entity type filter (null = show all)
final entityTypeFilterProvider = StateProvider<EntityType?>((ref) => null);

/// Current search query for entities
final entitySearchQueryProvider = StateProvider<String>((ref) => '');

/// Currently selected entity ID for detail view
final selectedEntityIdProvider = StateProvider<String?>((ref) => null);

/// Watch entities for the current campaign with optional type filter
final entitiesProvider = StreamProvider<List<Entity>>((ref) {
  final campaignId = ref.watch(selectedCampaignIdProvider);
  if (campaignId == null) return Stream.value([]);

  final typeFilter = ref.watch(entityTypeFilterProvider);
  final searchQuery = ref.watch(entitySearchQueryProvider);

  final repo = ref.watch(entityRepositoryProvider);

  if (searchQuery.isNotEmpty) {
    return repo.searchEntities(campaignId, searchQuery);
  } else if (typeFilter != null) {
    return repo.watchEntitiesByType(campaignId, typeFilter);
  } else {
    return repo.watchEntitiesByCampaign(campaignId);
  }
});

/// Get the currently selected entity
final selectedEntityProvider = FutureProvider<Entity?>((ref) async {
  final id = ref.watch(selectedEntityIdProvider);
  if (id == null) return null;
  return ref.watch(entityRepositoryProvider).getEntityById(id);
});

/// Watch a specific entity by ID
final entityProvider = StreamProvider.family<Entity?, String>((ref, id) {
  return ref.watch(entityRepositoryProvider).watchEntity(id);
});

/// Watch edges for the currently selected entity
final selectedEntityEdgesProvider = StreamProvider<List<Edge>>((ref) {
  final id = ref.watch(selectedEntityIdProvider);
  if (id == null) return Stream.value([]);
  return ref.watch(edgeRepositoryProvider).watchEdgesFromSource(id);
});

/// Watch incoming edges (entities that link TO the selected entity)
final incomingEdgesProvider = StreamProvider<List<Edge>>((ref) {
  final id = ref.watch(selectedEntityIdProvider);
  if (id == null) return Stream.value([]);
  return ref.watch(edgeRepositoryProvider).watchEdgesToTarget(id);
});
