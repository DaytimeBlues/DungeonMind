import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final aiServiceProvider = Provider((ref) => AiService());

class AiService {
  static const String _kApiKey = 'gemini_api_key';
  
  Future<void> saveApiKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kApiKey, key);
  }

  Future<String?> getApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kApiKey);
  }

  Future<String> generateContent(String prompt, {String modelName = 'gemini-pro'}) async {
    final apiKey = await getApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('API Key not set. Please configure it in settings.');
    }

    final model = GenerativeModel(model: modelName, apiKey: apiKey);
    final content = [Content.text(prompt)];
    
    try {
      final response = await model.generateContent(content);
      return response.text ?? 'No response generated.';
    } catch (e) {
      throw Exception('Failed to generate content: $e');
    }
  }
  
  /// Helper to check logic consistency of an entity
  Future<String> checkEntityLogic(String entityJson) async {
    final prompt = '''
    You are a Dungeon Master assistant. Analyze the following D&D entity for logical consistency, 
    plot holes, or missing details. format your response in Markdown.
    
    Entity Data:
    $entityJson
    ''';
    return generateContent(prompt);
  }
}
