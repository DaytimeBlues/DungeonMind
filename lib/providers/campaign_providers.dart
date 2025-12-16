import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database/database.dart';
import 'database_provider.dart';

/// Currently selected campaign ID
final selectedCampaignIdProvider = StateProvider<String?>((ref) => null);

/// Watch all campaigns (reactive)
final campaignsProvider = StreamProvider<List<Campaign>>((ref) {
  return ref.watch(campaignRepositoryProvider).watchAllCampaigns();
});

/// Get the currently selected campaign
final selectedCampaignProvider = FutureProvider<Campaign?>((ref) async {
  final id = ref.watch(selectedCampaignIdProvider);
  if (id == null) return null;
  return ref.watch(campaignRepositoryProvider).getCampaignById(id);
});
