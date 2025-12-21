import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'features/shell/app_router.dart';

void main() {
  print('DungeonMind: Starting App...');
  WidgetsFlutterBinding.ensureInitialized();
  print('DungeonMind: Widgets Initialized');
  
  FlutterError.onError = (details) {
    print('DungeonMind FlutterError: ${details.exception}');
    print('Stack: ${details.stack}');
  };
  
  runApp(const ProviderScope(child: DungeonMindApp()));
  print('DungeonMind: runApp called');
}

/// Root application widget
class DungeonMindApp extends ConsumerWidget {
  const DungeonMindApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('DungeonMind: DungeonMindApp.build() called');
    final router = ref.watch(routerProvider);
    print('DungeonMind: Router obtained');

    return MaterialApp.router(
      title: 'DungeonMind',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}


