import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../database/database.dart';
import '../models/entity_types.dart';

/// Repository for Campaign CRUD operations
class CampaignRepository {
  final AppDatabase _db;
  static const _uuid = Uuid();

  CampaignRepository(this._db);

  /// Get all campaigns ordered by last updated
  Stream<List<Campaign>> watchAllCampaigns() {
    return _db.allCampaigns().watch();
  }

  /// Get all campaigns (one-time fetch)
  Future<List<Campaign>> getAllCampaigns() {
    return _db.allCampaigns().get();
  }

  /// Get a single campaign by ID
  Future<Campaign?> getCampaignById(String id) async {
    return _db.campaignById(id).getSingleOrNull();
  }

  /// Create a new campaign
  Future<Campaign> createCampaign({
    required String title,
    String? description,
    CalendarSystem calendarSystem = CalendarSystem.gregorian,
    String? currentInGameDate,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final campaign = CampaignsCompanion.insert(
      id: _uuid.v4(),
      title: title,
      description: Value(description),
      calendarSystem: Value(calendarSystem.name),
      currentInGameDate: Value(currentInGameDate),
      createdAt: now,
      updatedAt: now,
    );

    await _db.into(_db.campaigns).insert(campaign);
    return (await getCampaignById(campaign.id.value))!;
  }

  /// Update an existing campaign
  Future<void> updateCampaign({
    required String id,
    String? title,
    String? description,
    CalendarSystem? calendarSystem,
    String? currentInGameDate,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (_db.update(_db.campaigns)..where((c) => c.id.equals(id))).write(
      CampaignsCompanion(
        title: title != null ? Value(title) : const Value.absent(),
        description: description != null ? Value(description) : const Value.absent(),
        calendarSystem: calendarSystem != null ? Value(calendarSystem.name) : const Value.absent(),
        currentInGameDate: currentInGameDate != null ? Value(currentInGameDate) : const Value.absent(),
        updatedAt: Value(now),
      ),
    );
  }

  /// Delete a campaign (cascades to all related data)
  Future<void> deleteCampaign(String id) async {
    await (_db.delete(_db.campaigns)..where((c) => c.id.equals(id))).go();
  }
}
