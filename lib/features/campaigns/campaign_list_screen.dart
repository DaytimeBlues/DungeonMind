import '../../core/data/simulation_script.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../providers/database_provider.dart';
import '../../providers/campaign_providers.dart';
import '../../data/models/entity_types.dart';
import '../../core/theme/catppuccin_colors.dart';
import '../../core/theme/grimoire_scaffold.dart';

/// Screen showing all campaigns with ability to create new ones
class CampaignListScreen extends ConsumerWidget {
  const CampaignListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campaignsAsync = ref.watch(campaignsProvider);

    return GrimoireScaffold(
      appBar: AppBar(
        title: const Text('Campaigns'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bug_report),
            tooltip: 'Run Simulation',
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Running simulation...')),
              );
              final script = ref.read(simulationScriptProvider);
              await script.runFullSimulation();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Simulation complete! Refreshing...')),
              );
              // Trigger refresh via provider invalidation if needed, or if stream handles it.
              // Stream will auto-update.
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.pushNamed('create-campaign'),
            tooltip: 'New Campaign',
          ),
        ],
      ),
      body: campaignsAsync.when(
        data: (campaigns) {
          if (campaigns.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    size: 80,
                    color: CatppuccinColors.mauve.withOpacity(0.5),
                  )
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 2.seconds),
                  const SizedBox(height: 24),
                  Text(
                    'No campaigns yet',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create your first campaign to get started',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => _showCreateCampaignDialog(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text('Create Campaign'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: campaigns.length,
            itemBuilder: (context, index) {
              final campaign = campaigns[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: CatppuccinColors.mauve.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.auto_stories,
                      color: CatppuccinColors.mauve,
                    ),
                  ),
                  title: Text(
                    campaign.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: campaign.description != null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            campaign.description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      : null,
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Set as selected campaign and navigate
                    ref.read(selectedCampaignIdProvider.notifier).state = campaign.id;
                    context.go('/entities');
                  },
                ),
              )
                  .animate()
                  .fadeIn(delay: (index * 50).ms)
                  .slideX(begin: 0.1, end: 0, delay: (index * 50).ms);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: CatppuccinColors.red),
              const SizedBox(height: 16),
              Text('Error: $error'),
            ],
          ),
        ),
      ),
      floatingActionButton: campaignsAsync.valueOrNull?.isNotEmpty == true
          ? FloatingActionButton.extended(
              onPressed: () => _showCreateCampaignDialog(context, ref),
              icon: const Icon(Icons.add),
              label: const Text('New Campaign'),
            )
          : null,
    );
  }

  void _showCreateCampaignDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    CalendarSystem selectedCalendar = CalendarSystem.gregorian;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Create Campaign'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Campaign Name',
                    hintText: 'e.g., Lost Mine of Phandelver',
                  ),
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description (optional)',
                    hintText: 'Brief description of your campaign',
                  ),
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<CalendarSystem>(
                  value: selectedCalendar,
                  decoration: const InputDecoration(
                    labelText: 'Calendar System',
                  ),
                  items: CalendarSystem.values.map((cal) {
                    return DropdownMenuItem(
                      value: cal,
                      child: Text(cal.displayName),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => selectedCalendar = value);
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                if (titleController.text.trim().isEmpty) return;

                final repo = ref.read(campaignRepositoryProvider);
                final campaign = await repo.createCampaign(
                  title: titleController.text.trim(),
                  description: descriptionController.text.trim().isEmpty
                      ? null
                      : descriptionController.text.trim(),
                  calendarSystem: selectedCalendar,
                );

                if (context.mounted) {
                  Navigator.pop(context);
                  // Select the new campaign and go to entities
                  ref.read(selectedCampaignIdProvider.notifier).state = campaign.id;
                  context.go('/entities');
                }
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
