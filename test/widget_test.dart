// DungeonMind Widget Tests
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dungeonmind/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: DungeonMindApp()));
    // Just verify app loads without error
    expect(find.text('Campaigns'), findsOneWidget);
  });
}
