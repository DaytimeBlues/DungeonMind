import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/entity_repository.dart';
import '../../data/repositories/map_repository.dart';
import '../../data/models/entity_types.dart';
import '../../providers/entity_providers.dart';
import '../../providers/map_providers.dart';

final campaignSeederProvider = Provider((ref) => CampaignSeeder(ref));

/// One-time seeder for campaign content
class CampaignSeeder {
  final Ref ref;

  CampaignSeeder(this.ref);

  Future<void> seedPhandalin(String campaignId, String mapId) async {
    final entityRepo = ref.read(entityRepositoryProvider);
    final mapRepo = ref.read(mapRepositoryProvider);

    // 1. Check if Phandalin exists
    final existing = await entityRepo.searchEntities(campaignId, 'Phandalin').first;
    if (existing.isNotEmpty) return; // Already seeded

    // 2. Create Phandalin (Location)
    final phandalin = await entityRepo.createEntity(
      campaignId: campaignId,
      type: EntityType.location,
      title: 'Phandalin',
      publicDescription: 'A rough-and-tumble frontier town built on the ruins of a much older settlement. It is home to farmers, woodcutters, fur traders, and prospectors drawn by stories of gold and platinum in the foothills of the Sword Mountains.',
      bodyContent: '''
# Points of Interest
- [[Stonehill Inn]]: The main social hub.
- [[Barthen's Provisions]]: General trading post.
- [[Lionshield Coster]]: Weapons and armor provided by the Lionshield merchants.
- [[Phandalin Miner's Exchange]]: Mining guild headquarters.
- [[Shrine of Luck]]: Shrine to Tymora.
- [[Townmaster's Hall]]: Seat of local government.
- [[Tresendar Manor]]: Rumored hideout of the [[Redbrands]].

# Key NPCs
- [[Toblen Stonehill]] (Innkeeper)
- [[Elmar Barthen]] (Shopkeep)
- [[Linene Graywind]] (Lionshield Agent)
- [[Halia Thornton]] (Guildmaster)
- [[Sister Garaele]] (Cleric of Tymora)
- [[Harbin Wester]] (Townmaster)
- [[Sildar Hallwinter]] (Lords' Alliance Agent)
''',
      tags: ['Town', 'Starter Area', 'Safe Haven'],
    );

    // 3. Create Map Pin for Phandalin
    // Assuming 2048x2048 map. Phandalin is roughly South East of Neverwinter Wood.
    // Let's place it at x=1200, y=1400.
    await mapRepo.addPin(
      mapId: mapId,
      entityId: phandalin.id,
      x: 1200,
      y: 1400,
      icon: 'town',
    );

    // 4. Create Sub-Entities
    await _createNPC(entityRepo, campaignId, 'Toblen Stonehill', 'Owner of the [[Stonehill Inn]]. Friendly human male. Came from the east of Triboar seeking a new life.', 'Friendly innkeeper.');
    await _createNPC(entityRepo, campaignId, 'Elmar Barthen', 'Proprietor of [[Barthen\'s Provisions]]. Lean and balding human male of 50 years. He employs two young clerks, Ander and Thistle.', 'Video store owner equivalent.');
    await _createNPC(entityRepo, campaignId, 'Linene Graywind', 'Runs the [[Lionshield Coster]]. Sharp-tongued human woman of 35. Does not deal with [[Redbrands]].', 'Merchant.');
    await _createNPC(entityRepo, campaignId, 'Halia Thornton', 'Runs the [[Phandalin Miner\'s Exchange]]. Ambitious human woman. Secret agent of the **Zhentarim**.', 'Calculating guildmaster.');
    await _createNPC(entityRepo, campaignId, 'Harbin Wester', 'Townmaster of Phandalin. Fat, pompous old banker. Completely intimidated by the [[Redbrands]].', 'Cowardly leader.');
    await _createNPC(entityRepo, campaignId, 'Sildar Hallwinter', 'Kindhearted human male of 50 years. Member of the **Lords\' Alliance**. Search for his lost friend [[Gundren Rockseeker]].', 'Veteran warrior.');
    await _createNPC(entityRepo, campaignId, 'Gundren Rockseeker', 'Dwarf prospector who found the map to the Lost Mine. Captured by goblins.', 'Missing patron.');
    
    // Locations
    await _createLocation(entityRepo, campaignId, 'Stonehill Inn', 'Modest inn. Six rooms for rent. The lounge is filled with locals complaining about the Redbrands.', 'Best inn in town.');
    await _createLocation(entityRepo, campaignId, 'Tresendar Manor', 'More of a castle than a manor. The cellars are the main base of the [[Redbrands]].', 'Haunted ruins.');
  }

  Future<void> _createNPC(EntityRepository repo, String campaignId, String name, String dmNotes, String publicDesc) async {
    await repo.createEntity(
      campaignId: campaignId,
      type: EntityType.npc,
      title: name,
      bodyContent: dmNotes,
      publicDescription: publicDesc,
    );
  }

  Future<void> _createLocation(EntityRepository repo, String campaignId, String name, String dmNotes, String publicDesc) async {
    await repo.createEntity(
      campaignId: campaignId,
      type: EntityType.location,
      title: name,
      bodyContent: dmNotes,
      publicDescription: publicDesc,
    );
  }
}
