import 'dart:convert';
import 'dart:io';

void main() async {
  final file = File('assets/data/5esrd.json');
  final jsonString = await file.readAsString();
  final data = jsonDecode(jsonString) as Map<String, dynamic>;

  print('Top Level Keys: ${data.keys.take(10).join(', ')}');

  // Check Monsters
  if (data.containsKey('Monsters')) {
    final monsters = data['Monsters'];
    print('\n--- Monster Section Analysis ---');
    if (monsters is Map<String, dynamic>) {
       print('Monsters Keys: ${monsters.keys.toList()}');
       
       // Traverse keys
       monsters.forEach((k, v) {
         if (k == 'content') return; // Skip description
         
         print('\nSub-Key: "$k"');
         if (v is Map) {
            print('Type: Map with ${v.length} entries.');
            if (v.isNotEmpty) {
               final sampleKey = v.keys.first;
               print('Sample Entry Key: "$sampleKey"');
               print('Sample Entry Data: ${v[sampleKey]}');
            }
         } else if (v is List) {
            print('Type: List with ${v.length} entries.');
            if (v.isNotEmpty) print('Sample Item: ${v.first}');
         } else {
            print('Type: ${v.runtimeType}');
         }
       });
    }
  }
}
