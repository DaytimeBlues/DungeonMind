import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/entity_types.dart';

final srdServiceProvider = Provider((ref) => SrdService());

class SrdService {
  Map<String, dynamic>? _srdData;
  Map<String, dynamic>? _spellDescriptions;
  Map<String, dynamic>? _monsters;

  Future<void> _ensureLoaded() async {
    if (_srdData != null) return;

    try {
      final jsonString = await rootBundle.loadString('assets/data/5esrd.json');
      _srdData = json.decode(jsonString);

      // Index Spells
      if (_srdData?['Spellcasting']?['Spell Descriptions'] != null) {
        _spellDescriptions = _srdData!['Spellcasting']!['Spell Descriptions'];
      }
      
      // Index Monsters
      if (_srdData?['Monsters'] != null) {
         final monsterSection = _srdData!['Monsters'] as Map<String, dynamic>;
         // Heuristic to find the container of monster entries
         if (monsterSection.containsKey('Monster List')) {
             _monsters = monsterSection['Monster List'];
         } else if (monsterSection.containsKey('Monsters')) {
             _monsters = monsterSection['Monsters'];
         } else if (monsterSection.containsKey('Monster Statistics')) {
             _monsters = monsterSection['Monster Statistics'];
         } else {
             // Fallback: assume keys are monsters directly (excluding 'content')
             _monsters = Map.from(monsterSection)..remove('content');
         }
      }
      
      print('SRD Service Loaded: ${_spellDescriptions?.length ?? 0} spells, ${_monsters?.length ?? 0} monsters.');

    } catch (e) {
      print('Error loading local SRD: $e');
    }
  }

  Future<List<Map<String, String>>> search(String query, {EntityType? type}) async {
    await _ensureLoaded();
    final results = <Map<String, String>>[];
    final q = query.toLowerCase();

    // 1. Search Spells
    if ((type == null || type == EntityType.spell) && _spellDescriptions != null) {
      for (final name in _spellDescriptions!.keys) {
        if (name.toLowerCase().contains(q)) {
          results.add({
             // Using name as index
            'index': name,
            'name': name,
            'url': 'local_spell',
            'type': 'Spell',
          });
        }
      }
    }

    // 2. Search Monsters
     if ((type == null || type == EntityType.monster) && _monsters != null) {
      for (final name in _monsters!.keys) {
        if (name.toLowerCase().contains(q)) {
          results.add({
            'index': name,
            'name': name,
            'url': 'local_monster',
            'type': 'Monster',
          });
        }
      }
    }

    return results;
  }

  Future<Map<String, dynamic>> getDetail(String index, String type) async {
    await _ensureLoaded();

    if (type == 'Spell' && _spellDescriptions != null) {
      final data = _spellDescriptions![index];
      if (data != null) {
        return _parseSpellData(index, data);
      }
    } else if (type == 'Monster' && _monsters != null) {
      final data = _monsters![index];
      if (data != null) {
         return _parseMonsterData(index, data);
      }
    }
    
    return {'name': index, 'error': 'Not found'};
  }
  
  Map<String, dynamic> _parseSpellData(String name, dynamic rawData) {
    return _parseGenericData(name, rawData, 'Spell');
  }

  Map<String, dynamic> _parseMonsterData(String name, dynamic rawData) {
     return _parseGenericData(name, rawData, 'Monster');
  }
  
  Map<String, dynamic> _parseGenericData(String name, dynamic rawData, String type) {
    // "content" is usually a List
    final contentList = (rawData['content'] as List?) ?? [];
    
    final metadata = <String, dynamic>{
      'name': name,
      'type': type,
    };
    
    final descriptionBuffer = StringBuffer();

    for (var item in contentList) {
      if (item is String) {
        // Spell Detectors
        if (type == 'Spell') {
           if (item.trim().startsWith('*') && item.trim().endsWith('*') && item.length < 80) {
             metadata['level_school'] = item.replaceAll('*', '');
             // Extract level
             if (item.contains('cantrip')) metadata['level'] = 0;
             else if (item.contains('1st')) metadata['level'] = 1;
             else if (item.contains('2nd')) metadata['level'] = 2;
             else if (item.contains('3rd')) metadata['level'] = 3;
             else if (item.contains('4th')) metadata['level'] = 4;
             else if (item.contains('5th')) metadata['level'] = 5;
             else if (item.contains('6th')) metadata['level'] = 6;
             else if (item.contains('7th')) metadata['level'] = 7;
             else if (item.contains('8th')) metadata['level'] = 8;
             else if (item.contains('9th')) metadata['level'] = 9;
           } else if (item.contains('**Casting Time:**')) {
             metadata['casting_time'] = item.replaceAll('**Casting Time:**', '').trim();
           } else if (item.contains('**Range:**')) {
             metadata['range'] = item.replaceAll('**Range:**', '').trim();
           } else if (item.contains('**Components:**')) {
             metadata['components'] = item.replaceAll('**Components:**', '').trim();
           } else if (item.contains('**Duration:**')) {
             metadata['duration'] = item.replaceAll('**Duration:**', '').trim();
           } else {
             descriptionBuffer.writeln(item);
             descriptionBuffer.writeln();
           }
        } 
        // Monster Detectors
        else if (type == 'Monster') {
            if (item.contains('**Armor Class**')) {
               metadata['ac'] = item.replaceAll('**Armor Class**', '').trim();
            } else if (item.contains('**Hit Points**')) {
               metadata['hp'] = item.replaceAll('**Hit Points**', '').trim();
            } else if (item.contains('**Speed**')) {
               metadata['speed'] = item.replaceAll('**Speed**', '').trim();
            } else if (item.contains('**Challenge**')) {
               metadata['cr'] = item.replaceAll('**Challenge**', '').trim();
            } else {
               descriptionBuffer.writeln(item);
               descriptionBuffer.writeln();
            }
        }
      } else if (item is List) {
         for (var subItem in item) {
            descriptionBuffer.writeln('- $subItem');
         }
         descriptionBuffer.writeln();
      }
    }
    
    metadata['description'] = descriptionBuffer.toString().trim();
    return metadata;
  }

  Map<String, dynamic> convertToMetadata(Map<String, dynamic> localData) {
    return localData; 
  }
}
