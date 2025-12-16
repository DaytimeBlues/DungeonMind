import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/database_provider.dart';
import '../../providers/campaign_providers.dart';

/// Detail screen for a single campaign (settings, export, etc.)
class CampaignDetailScreen extends ConsumerWidget {
  final String campaignId;

  const CampaignDetailScreen({super.key, required this.campaignId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campaignAsync = ref.watch(selectedCampaignProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Campaign Settings'),
      ),
      body: campaignAsync.when(
        data: (campaign) {
          if (campaign == null) {
            return const Center(child: Text('Campaign not found'));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        campaign.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      if (campaign.description != null) ...[
                        const SizedBox(height: 8),
                        Text(campaign.description!),
                      ],
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 16),
                          const SizedBox(width: 8),
                          Text('Calendar: ${campaign.calendarSystem}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.edit),
                      title: const Text('Edit Campaign'),
                      onTap: () {
                        // TODO: Implement edit
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.download),
                      title: const Text('Export Data'),
                      onTap: () {
                        // TODO: Implement export
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                      title: Text(
                        'Delete Campaign',
                        style: TextStyle(color: Theme.of(context).colorScheme.error),
                      ),
                      onTap: () => _confirmDelete(context, ref, campaign.id),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Campaign?'),
        content: const Text(
          'This will permanently delete all entities, maps, and session logs in this campaign. This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () async {
              final repo = ref.read(campaignRepositoryProvider);
              await repo.deleteCampaign(id);
              ref.read(selectedCampaignIdProvider.notifier).state = null;
              if (context.mounted) {
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
