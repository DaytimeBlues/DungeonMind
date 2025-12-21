import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DieType {
  d4(4),
  d6(6),
  d8(8),
  d10(10),
  d12(12),
  d20(20),
  d100(100);

  final int sides;
  const DieType(this.sides);
}

class RollResult {
  final DieType type;
  final int result;
  final DateTime timestamp;

  RollResult({
    required this.type,
    required this.result,
    required this.timestamp,
  });
}

class DiceNotifier extends StateNotifier<List<RollResult>> {
  DiceNotifier() : super([]);

  final _random = Random();

  void roll(DieType type) {
    final result = _random.nextInt(type.sides) + 1;
    final roll = RollResult(
      type: type,
      result: result,
      timestamp: DateTime.now(),
    );
    
    state = [roll, ...state].take(20).toList(); // Keep last 20 rolls
  }

  void clearHistory() {
    state = [];
  }
}

final diceProvider = StateNotifierProvider<DiceNotifier, List<RollResult>>((ref) {
  return DiceNotifier();
});
