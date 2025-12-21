import 'package:flutter/material.dart';

void main() {
  print('DungeonMind: Minimal Test Starting...');
  WidgetsFlutterBinding.ensureInitialized();
  print('DungeonMind: Widgets Initialized');
  runApp(const MinimalApp());
  print('DungeonMind: runApp called');
}

class MinimalApp extends StatelessWidget {
  const MinimalApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('DungeonMind: Building MinimalApp');
    return MaterialApp(
      title: 'DungeonMind Test',
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: Center(
          child: Text(
            'DungeonMind is WORKING!',
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
