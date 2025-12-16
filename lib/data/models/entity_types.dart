/// Entity types supported by DungeonMind
enum EntityType {
  npc('NPC', 'person'),
  location('Location', 'map-pin'),
  item('Item', 'sword'),
  lore('Lore', 'book-open'),
  event('Event', 'calendar'),
  faction('Faction', 'users');

  const EntityType(this.displayName, this.iconName);
  
  final String displayName;
  final String iconName;

  static EntityType fromString(String value) {
    return EntityType.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => EntityType.lore,
    );
  }
}

/// Calendar system presets
enum CalendarSystem {
  gregorian('Gregorian', 'Standard Earth calendar'),
  harptos('Harptos', 'Forgotten Realms calendar (365 days, 12 months)'),
  exandrian('Exandrian', 'Critical Role calendar (328 days)');

  const CalendarSystem(this.displayName, this.description);
  
  final String displayName;
  final String description;

  static CalendarSystem fromString(String value) {
    return CalendarSystem.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => CalendarSystem.gregorian,
    );
  }
}

/// Edge types for relationship graph
enum EdgeType {
  mentionedIn('mentioned_in', 'Referenced in text'),
  parentOf('parent_of', 'Contains or owns'),
  locatedAt('located_at', 'Physical location'),
  memberOf('member_of', 'Belongs to faction/group'),
  relatedTo('related_to', 'Generic relationship');

  const EdgeType(this.value, this.description);
  
  final String value;
  final String description;

  static EdgeType fromString(String value) {
    return EdgeType.values.firstWhere(
      (e) => e.value == value.toLowerCase(),
      orElse: () => EdgeType.relatedTo,
    );
  }
}
