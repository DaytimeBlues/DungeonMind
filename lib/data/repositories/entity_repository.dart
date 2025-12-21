import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../database/database.dart';
import '../models/entity_types.dart';

/// Repository for Entity CRUD operations (NPCs, Locations, Items, etc.)
class EntityRepository {
  final AppDatabase _db;
  static const _uuid = Uuid();

  EntityRepository(this._db);

  /// Watch all entities for a campaign
  Stream<List<Entity>> watchEntitiesByCampaign(String campaignId) {
    return _db.entitiesByCampaign(campaignId).watch();
  }

  /// Watch entities filtered by type
  Stream<List<Entity>> watchEntitiesByType(String campaignId, EntityType type) {
    return _db.entitiesByCampaignAndType(campaignId, type.name).watch();
  }

  /// Search entities by query string
  Stream<List<Entity>> searchEntities(String campaignId, String query) {
    return _db.searchEntities(campaignId, query).watch();
  }

  /// Get a single entity by ID
  Future<Entity?> getEntityById(String id) async {
    return _db.entityById(id).getSingleOrNull();
  }

  /// Watch a single entity by ID
  Stream<Entity?> watchEntity(String id) {
    return (_db.select(_db.entities)..where((e) => e.id.equals(id))).watchSingleOrNull();
  }

  /// Get entity by slug (for wiki linking)
  Future<Entity?> getEntityBySlug(String campaignId, String slug) async {
    return _db.entityBySlug(campaignId, slug.toLowerCase()).getSingleOrNull();
  }

  /// Create a new entity
  Future<Entity> createEntity({
    required String campaignId,
    required EntityType type,
    required String title,
    String? bodyContent,
    String? publicDescription,
    Map<String, dynamic>? metadata,
    List<String>? tags,
    bool isRevealed = false,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final slug = _generateSlug(title);
    
    final entity = EntitiesCompanion.insert(
      id: _uuid.v4(),
      campaignId: campaignId,
      type: type.name,
      title: title,
      slug: slug,
      bodyContent: Value(bodyContent),
      publicDescription: Value(publicDescription),
      metadata: Value(metadata != null ? jsonEncode(metadata) : null),
      tags: Value(tags?.join(',') ?? ''),
      completenessScore: Value(_calculateCompleteness(
        title: title,
        bodyContent: bodyContent,
        publicDescription: publicDescription,
        metadata: metadata,
        tags: tags,
      )),
      isRevealed: Value(isRevealed),
      createdAt: now,
      updatedAt: now,
    );

    await _db.into(_db.entities).insert(entity);
    return (await getEntityById(entity.id.value))!;
  }

  /// Update an existing entity
  Future<void> updateEntity({
    required String id,
    String? title,
    String? bodyContent,
    String? publicDescription,
    Map<String, dynamic>? metadata,
    List<String>? tags,
    bool? isRevealed,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final existing = await getEntityById(id);
    if (existing == null) return;

    final newSlug = title != null ? _generateSlug(title) : null;
    
    // Calculate new completeness score
    final newScore = _calculateCompleteness(
      title: title ?? existing.title,
      bodyContent: bodyContent ?? existing.bodyContent,
      publicDescription: publicDescription ?? existing.publicDescription,
      metadata: metadata ?? (existing.metadata != null ? jsonDecode(existing.metadata!) : null),
      tags: tags ?? existing.tags?.split(','),
    );

    await (_db.update(_db.entities)..where((e) => e.id.equals(id))).write(
      EntitiesCompanion(
        title: title != null ? Value(title) : const Value.absent(),
        slug: newSlug != null ? Value(newSlug) : const Value.absent(),
        bodyContent: bodyContent != null ? Value(bodyContent) : const Value.absent(),
        publicDescription: publicDescription != null ? Value(publicDescription) : const Value.absent(),
        metadata: metadata != null ? Value(jsonEncode(metadata)) : const Value.absent(),
        tags: tags != null ? Value(tags.join(',')) : const Value.absent(),
        completenessScore: Value(newScore),
        isRevealed: isRevealed != null ? Value(isRevealed) : const Value.absent(),
        updatedAt: Value(now),
      ),
    );
  }

  /// Delete an entity
  Future<void> deleteEntity(String id) async {
    await (_db.delete(_db.entities)..where((e) => e.id.equals(id))).go();
  }

  /// Generate a URL-safe slug from a title
  String _generateSlug(String title) {
    return title
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .trim();
  }

  /// Calculate entity completeness score (0.0 - 1.0)
  double _calculateCompleteness({
    required String title,
    String? bodyContent,
    String? publicDescription,
    Map<String, dynamic>? metadata,
    List<String>? tags,
  }) {
    final fields = [
      title.isNotEmpty,
      bodyContent?.isNotEmpty ?? false,
      publicDescription?.isNotEmpty ?? false,
      tags?.isNotEmpty ?? false,
      metadata?.isNotEmpty ?? false,
    ];
    final completed = fields.where((f) => f).length;
    return completed / fields.length;
  }

  /// Parse metadata JSON from entity
  Map<String, dynamic>? parseMetadata(Entity entity) {
    if (entity.metadata == null) return null;
    try {
      return jsonDecode(entity.metadata!) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  /// Parse tags from entity
  List<String> parseTags(Entity entity) {
    if (entity.tags == null || entity.tags!.isEmpty) return [];
    return entity.tags!.split(',').where((t) => t.isNotEmpty).toList();
  }
}
