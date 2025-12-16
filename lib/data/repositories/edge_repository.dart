import 'package:uuid/uuid.dart';

import '../database/database.dart';
import '../models/entity_types.dart';

/// Repository for managing entity relationships (the graph edges)
class EdgeRepository {
  final AppDatabase _db;
  static const _uuid = Uuid();

  EdgeRepository(this._db);

  /// Watch all edges FROM a source entity
  Stream<List<Edge>> watchEdgesFromSource(String sourceId) {
    return _db.edgesBySource(sourceId).watch();
  }

  /// Watch all edges TO a target entity
  Stream<List<Edge>> watchEdgesToTarget(String targetId) {
    return _db.edgesByTarget(targetId).watch();
  }

  /// Get all edges connected to an entity (both directions)
  Future<List<Edge>> getEdgesForEntity(String entityId) async {
    final fromSource = await _db.edgesBySource(entityId).get();
    final toTarget = await _db.edgesByTarget(entityId).get();
    return {...fromSource, ...toTarget}.toList();
  }

  /// Check if an edge exists between two entities
  Future<bool> edgeExists(String sourceId, String targetId) async {
    final edges = await _db.edgesBetween(sourceId, targetId).get();
    return edges.isNotEmpty;
  }

  /// Create a new edge between entities
  Future<Edge> createEdge({
    required String sourceId,
    required String targetId,
    required EdgeType edgeType,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final id = _uuid.v4();
    
    final edge = EdgesCompanion.insert(
      id: id,
      sourceId: sourceId,
      targetId: targetId,
      edgeType: edgeType.value,
      createdAt: now,
    );

    await _db.into(_db.edges).insert(edge);
    return Edge(
      id: id,
      sourceId: sourceId,
      targetId: targetId,
      edgeType: edgeType.value,
      createdAt: now,
    );
  }

  /// Create edge only if it doesn't already exist
  Future<Edge?> createEdgeIfNotExists({
    required String sourceId,
    required String targetId,
    required EdgeType edgeType,
  }) async {
    if (await edgeExists(sourceId, targetId)) {
      return null;
    }
    return createEdge(
      sourceId: sourceId,
      targetId: targetId,
      edgeType: edgeType,
    );
  }

  /// Delete an edge by ID
  Future<void> deleteEdge(String id) async {
    await (_db.delete(_db.edges)..where((e) => e.id.equals(id))).go();
  }

  /// Delete all edges from a source entity
  Future<void> deleteEdgesFromSource(String sourceId) async {
    await (_db.delete(_db.edges)..where((e) => e.sourceId.equals(sourceId))).go();
  }

  /// Sync edges based on wiki links parsed from content
  /// This removes stale edges and creates new ones
  Future<void> syncEdgesFromLinks({
    required String sourceEntityId,
    required List<String> linkedEntityIds,
  }) async {
    final existingEdges = await _db.edgesBySource(sourceEntityId).get();
    final existingTargets = existingEdges
        .where((e) => e.edgeType == EdgeType.mentionedIn.value)
        .map((e) => e.targetId)
        .toSet();

    final newTargets = linkedEntityIds.toSet();

    // Delete edges that are no longer in the content
    final toDelete = existingTargets.difference(newTargets);
    for (final targetId in toDelete) {
      final edgeToDelete = existingEdges.firstWhere(
        (e) => e.targetId == targetId && e.edgeType == EdgeType.mentionedIn.value,
      );
      await deleteEdge(edgeToDelete.id);
    }

    // Create new edges for newly mentioned entities
    final toCreate = newTargets.difference(existingTargets);
    for (final targetId in toCreate) {
      await createEdge(
        sourceId: sourceEntityId,
        targetId: targetId,
        edgeType: EdgeType.mentionedIn,
      );
    }
  }
}
