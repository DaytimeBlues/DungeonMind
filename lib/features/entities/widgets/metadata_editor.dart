import 'package:flutter/material.dart';
import '../../../core/theme/catppuccin_colors.dart';

/// Widget for editing flexible metadata (stats, info, etc.)
class MetadataEditor extends StatefulWidget {
  final Map<String, dynamic> metadata;
  final ValueChanged<Map<String, dynamic>> onChanged;

  const MetadataEditor({
    super.key,
    required this.metadata,
    required this.onChanged,
  });

  @override
  State<MetadataEditor> createState() => _MetadataEditorState();
}

class _MetadataEditorState extends State<MetadataEditor> {
  late List<_MetadataItem> _items;

  @override
  void initState() {
    super.initState();
    _items = widget.metadata.entries.map((e) {
      return _MetadataItem(
        keyController: TextEditingController(text: e.key),
        valueController: TextEditingController(text: e.value.toString()),
      );
    }).toList();
  }

  @override
  void didUpdateWidget(covariant MetadataEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Be careful not to overwrite user input if parent rebuilds.
    // Only reset if metadata completely changes (e.g. entity switch)
    // For now, assume parent manages state well or only inits once.
  }

  @override
  void dispose() {
    for (var item in _items) {
      item.dispose();
    }
    super.dispose();
  }

  void _notifyChanged() {
    final newMap = <String, dynamic>{};
    for (var item in _items) {
      if (item.keyController.text.isNotEmpty) {
        // Try to parse number
        final valueText = item.valueController.text;
        final numValue = num.tryParse(valueText);
        
        // Try to parse list (comma separated) if it looks like a list?
        // For simplicity, store as string or number.
        // If user wants list, maybe use specific UI? 
        // For simulation script "Spells": ["Fireball"], we display as "[Fireball, ...]"?
        // Editing complex types in simple KV editor is hard.
        // We'll stick to String/Num for MVP.
        
        newMap[item.keyController.text] = numValue ?? valueText;
      }
    }
    widget.onChanged(newMap);
  }

  void _addItem() {
    setState(() {
      _items.add(_MetadataItem(
        keyController: TextEditingController(),
        valueController: TextEditingController(),
      ));
    });
    _notifyChanged();
  }

  void _removeItem(int index) {
    setState(() {
      _items[index].dispose();
      _items.removeAt(index);
    });
    _notifyChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: item.keyController,
                    decoration: const InputDecoration(
                      hintText: 'Key (e.g. HP)',
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (_) => _notifyChanged(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: item.valueController,
                    decoration: const InputDecoration(
                      hintText: 'Value',
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (_) => _notifyChanged(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline, color: CatppuccinColors.red),
                  onPressed: () => _removeItem(index),
                ),
              ],
            ),
          );
        }),
        FilledButton.tonalIcon(
          onPressed: _addItem,
          icon: const Icon(Icons.add),
          label: const Text('Add Stat'),
        ),
      ],
    );
  }
}

class _MetadataItem {
  final TextEditingController keyController;
  final TextEditingController valueController;

  _MetadataItem({required this.keyController, required this.valueController});

  void dispose() {
    keyController.dispose();
    valueController.dispose();
  }
}
