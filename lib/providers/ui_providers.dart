import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Controls the visibility of the dice roller overlay
final diceRollerVisibleProvider = StateProvider<bool>((ref) => false);

/// Controls the visibility of the AI assistant overlay
final aiAssistantVisibleProvider = StateProvider<bool>((ref) => false);
