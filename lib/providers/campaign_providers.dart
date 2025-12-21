import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database/database.dart';
import 'database_provider.dart';

/// Currently selected campaign ID
final selectedCampaignIdProvider = StateProvider<String?>((ref) => null);

/// Get all campaigns with web-safe timeout
final campaignsProvider = FutureProvider<List<Campaign>>((ref) async {
  print('DungeonMind: campaignsProvider fetching from database...');
  try {
    final repo = ref.watch(campaignRepositoryProvider);
    final campaigns = await repo.getAllCampaigns()
        .timeout(const Duration(seconds: 10), onTimeout: () {
          print('DungeonMind: Database timeout - returning empty list');
          return <Campaign>[];
        });
    print('DungeonMind: campaignsProvider loaded ${campaigns.length} campaigns');
    return campaigns;
  } catch (e, stack) {
    print('DungeonMind: campaignsProvider error: $e');
    // Return empty list on error rather than crashing
    return <Campaign>[];
  }
});

/// Get the currently selected campaign
final selectedCampaignProvider = FutureProvider<Campaign?>((ref) async {
  final id = ref.watch(selectedCampaignIdProvider);
  if (id == null) return null;
  return ref.watch(campaignRepositoryProvider).getCampaignById(id);
});
