import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/services/dice_service.dart';
import '../../../core/theme/catppuccin_colors.dart';

class DiceRollerOverlay extends ConsumerWidget {
  const DiceRollerOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(diceProvider);

    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.8),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        border: Border.all(
          color: CatppuccinColors.mauve.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(context, ref),
          const Divider(height: 1, color: Colors.white12),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildDiceGrid(ref),
                const SizedBox(height: 24),
                _buildHistoryList(history),
              ],
            ),
          ),
        ],
      ),
    ).animate().slideX(begin: 1.0, end: 0.0, curve: Curves.easeOutCubic);
  }


  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'DICE ROLLER',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: CatppuccinColors.mauve,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh, size: 20),
            onPressed: () => ref.read(diceProvider.notifier).clearHistory(),
            tooltip: 'Clear History',
            color: Colors.white54,
          ),
        ],
      ),
    );
  }

  Widget _buildDiceGrid(WidgetRef ref) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: DieType.values.map((type) {
        return InkWell(
          onTap: () => ref.read(diceProvider.notifier).roll(type),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: CatppuccinColors.mauve.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: CatppuccinColors.mauve.withValues(alpha: 0.2)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getIconForDie(type),
                  color: CatppuccinColors.mauve,
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  type.name.toUpperCase(),
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ).animate(onPlay: (c) => c.stop()).shake(duration: 200.ms);
      }).toList(),
    );
  }

  Widget _buildHistoryList(List<RollResult> history) {
    if (history.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: Text(
            'No rolls yet',
            style: TextStyle(color: Colors.white30, fontStyle: FontStyle.italic),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'HISTORY',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white54),
        ),
        const SizedBox(height: 8),
        ...history.map((roll) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: CatppuccinColors.mauve.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        roll.type.name.substring(1),
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${roll.result}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ).animate().scale(begin: const Offset(1.5, 1.5), end: const Offset(1, 1)),
                  const Spacer(),
                  Text(
                    _formatTime(roll.timestamp),
                    style: const TextStyle(fontSize: 10, color: Colors.white30),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  IconData _getIconForDie(DieType type) {
    switch (type) {
      case DieType.d4: return Icons.change_history;
      case DieType.d6: return Icons.crop_square;
      case DieType.d8: return Icons.diamond;
      case DieType.d10: return Icons.pentagon_outlined;
      case DieType.d12: return Icons.hexagon_outlined;
      case DieType.d20: return Icons.token_outlined;
      case DieType.d100: return Icons.blur_on;
    }
  }

  String _formatTime(DateTime time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}';
  }
}
