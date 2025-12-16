import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final srdServiceProvider = Provider((ref) => SrdService());

class SrdService {
  static const String baseUrl = 'https://www.dnd5eapi.co/api';

  // Categories to search
  static const List<String> categories = [
    'spells',
    'monsters',
    'magic-items',
    'equipment',
  ];

  /// Search for an item in a specific index (category)
  /// Returns a list of results {index, name, url}
  Future<List<Map<String, dynamic>>> search(String category, String query) async {
    try {
      final url = Uri.parse('$baseUrl/$category?name=$query');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['results']);
      } else {
        throw Exception('Failed to load $category: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  /// Get detailed data for a specific item
  Future<Map<String, dynamic>> getDetail(String urlSuffix) async {
    try {
      final url = Uri.parse('https://www.dnd5eapi.co$urlSuffix');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load details');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  /// Helper to convert API data to Entity-friendly Metadata
  Map<String, dynamic> convertToMetadata(String category, Map<String, dynamic> data) {
    final metadata = <String, dynamic>{};

    if (category == 'spells') {
      metadata['Level'] = data['level'] ?? 0;
      metadata['School'] = data['school']?['name'] ?? 'Unknown';
      metadata['Casting Time'] = data['casting_time'];
      metadata['Range'] = data['range'];
      metadata['Components'] = (data['components'] as List?)?.join(', ') ?? '';
      metadata['Duration'] = data['duration'];
      metadata['Concentration'] = data['concentration'] == true ? 'Yes' : 'No';
      metadata['Ritual'] = data['ritual'] == true ? 'Yes' : 'No';
      // Classes
      metadata['Classes'] = (data['classes'] as List?)?.map((c) => c['name']).join(', ');
    } else if (category == 'monsters') {
      metadata['AC'] = (data['armor_class'] as List?)?.firstOrNull?['value'] ?? 10;
      metadata['HP'] = data['hit_points'];
      metadata['CR'] = data['challenge_rating'];
      metadata['Speed'] = data['speed'].toString(); // Map to string
      metadata['STR'] = data['strength'];
      metadata['DEX'] = data['dexterity'];
      metadata['CON'] = data['constitution'];
      metadata['INT'] = data['intelligence'];
      metadata['WIS'] = data['wisdom'];
      metadata['CHA'] = data['charisma'];
      metadata['Type'] = data['type'];
      metadata['Alignment'] = data['alignment'];
    } else {
      // Generic items
      metadata['Type'] = data['equipment_category']?['name'] ?? 'Item';
      if (data['cost'] != null) {
        metadata['Cost'] = '${data['cost']['quantity']} ${data['cost']['unit']}';
      }
      metadata['Weight'] = data['weight'];
    }

    return metadata;
  }
}
