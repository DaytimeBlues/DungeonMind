import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/entity_repository.dart';
import '../../data/repositories/campaign_repository.dart';
import '../../data/repositories/map_repository.dart';
import '../../data/models/entity_types.dart';
import '../../providers/entity_providers.dart';
import '../../providers/campaign_providers.dart';
import '../../providers/map_providers.dart';

final simulationScriptProvider = Provider((ref) => SimulationScript(ref));

class SimulationScript {
  final Ref ref;
  SimulationScript(this.ref);

  Future<void> runFullSimulation() async {
    final campaignRepo = ref.read(campaignRepositoryProvider);
    final entityRepo = ref.read(entityRepositoryProvider);
    final mapRepo = ref.read(mapRepositoryProvider);

    // 1. Create Campaign
    final campaign = await campaignRepo.createCampaign(
      title: 'Curse of Strahd (Simulated)',
      description: 'A gothic horror campaign in Barovia.',
    );
    final cid = campaign.id;

    // 2. Create Map
    final map = await mapRepo.createMap(
      campaignId: cid,
      title: 'Barovia Valley',
      imagePath: 'assets/images/neverwinter.png', // Placeholder
      width: 2048,
      height: 2048,
    );

    // 3. Create Locations
    final castle = await entityRepo.createEntity(
      campaignId: cid,
      type: EntityType.location,
      title: 'Castle Ravenloft',
      publicDescription: 'The looming fortress of the vampire lord.',
      bodyContent: 'Standard layout. Trap on entry.',
      metadata: {'Danger': 'Extreme', 'Floors': 4},
    );
    await mapRepo.addPin(mapId: map.id, entityId: castle.id, x: 1000, y: 500, icon: 'castle');

    // 4. Create Villain (Strahd) - Testing Stat Block Metadata
    final strahd = await entityRepo.createEntity(
      campaignId: cid,
      type: EntityType.npc,
      title: 'Strahd von Zarovich',
      publicDescription: 'The ruler of Barovia.',
      bodyContent: 'Secretly wants Tatyana back. Weak to sun.',
      isRevealed: true, // Known villain
      metadata: {
        'AC': 16,
        'HP': 144,
        'Speed': '30ft',
        'STR': 18,
        'DEX': 18,
        'CON': 18,
        'INT': 20,
        'WIS': 15,
        'CHA': 18,
        'CR': 15,
        'Spells': ['Fireball', 'Misty Step', 'Charm Person'],
      },
    );
    await mapRepo.addPin(mapId: map.id, entityId: strahd.id, x: 1050, y: 550, icon: 'skull');

    // 5. Create Player Character (Simulated Profile)
    await entityRepo.createEntity(
      campaignId: cid,
      type: EntityType.npc, // Using NPC type for PC for now
      title: 'Ismark Kolyanovich',
      publicDescription: 'The Lesser.',
      bodyContent: 'Ally of the party.',
      metadata: {
        'Class': 'Fighter',
        'Level': 3,
        'HP': 28,
        'AC': 17,
        'Inventory': ['Longsword', 'Chain Mail', 'Backpack'],
      },
    );

    // 6. Test Linking (Wikilinks)
    // Update Strahd to link to Castle
    await entityRepo.updateEntity(
      id: strahd.id,
      bodyContent: 'Lord of [[Castle Ravenloft]].',
    );
  }
}
