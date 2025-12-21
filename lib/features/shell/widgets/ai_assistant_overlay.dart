import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/services/ai_service.dart';
import '../../../core/theme/catppuccin_colors.dart';

class AiAssistantOverlay extends ConsumerStatefulWidget {
  const AiAssistantOverlay({super.key});

  @override
  ConsumerState<AiAssistantOverlay> createState() => _AiAssistantOverlayState();
}

class _AiAssistantOverlayState extends ConsumerState<AiAssistantOverlay> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;

    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.9),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        border: Border.all(
          color: CatppuccinColors.sky.withValues(alpha: 0.3),
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
          _buildHeader(),
          const Divider(height: 1, color: Colors.white12),
          Expanded(
            child: _messages.isEmpty 
              ? _buildWelcome(currentPath)
              : _buildChatList(),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(color: CatppuccinColors.sky),
            ),
          _buildInput(),
        ],
      ),
    ).animate().slideX(begin: 1.0, end: 0.0, curve: Curves.easeOutCubic);
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, color: CatppuccinColors.sky, size: 20),
          const SizedBox(width: 12),
          const Text(
            'GEMINI ASSISTANT',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: CatppuccinColors.sky,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 20, color: Colors.white30),
            onPressed: () => setState(() => _messages.clear()),
          ),
        ],
      ),
    );
  }


  Widget _buildWelcome(String path) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text(
          "How can I help you, Dungeon Master?",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        const Text(
          "I can generate NPC dialogue, suggest plot twists, or help you describe locations.",
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 32),
        const Text(
          "QUICK ACTIONS",
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white54),
        ),
        const SizedBox(height: 12),
        if (path.startsWith('/campaigns')) ...[
          _buildActionButton("Generate a campaign hook", "Create a compelling starting hook for a new D&D campaign in a high fantasy setting."),
          _buildActionButton("Describe a mysterious tavern", "Provide a sensory-rich description of a mysterious fantasy tavern named 'The Sleeping Dragon'."),
        ],
        if (path.startsWith('/entities')) ...[
          _buildActionButton("Create an NPC name", "Give me 5 unique fantasy NPC names with a brief one-sentence personality trait for each."),
          _buildActionButton("Generate a combat bark", "Write 3 aggressive combat lines for a chaotic evil orc chieftain."),
        ],
        if (path.startsWith('/maps')) ...[
          _buildActionButton("Describe a forest location", "Describe a dense, ancient forest clearing with a crumbling druidic altar."),
          _buildActionButton("Hidden trap idea", "Suggest a creative and magical trap for a wizard's tower that isn't instantly lethal but very inconvenient."),
        ],
        _buildActionButton("Roll for initiative!", "Write a short, exciting narration for the start of a combat encounter."),
      ],
    );
  }

  Widget _buildActionButton(String label, String prompt) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: OutlinedButton(
        onPressed: () => _sendMessage(prompt),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white10),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: Text(label, style: const TextStyle(color: CatppuccinColors.sky)),
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final msg = _messages[index];
        final isUser = msg['role'] == 'user';
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                isUser ? "YOU" : "GEMINI",
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white30),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isUser ? CatppuccinColors.sky.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(msg['text']!),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInput() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _controller,
        onSubmitted: _sendMessage,
        decoration: InputDecoration(
          hintText: "Ask Gemini...",
          suffixIcon: IconButton(
            icon: const Icon(Icons.send, color: CatppuccinColors.sky),
            onPressed: () => _sendMessage(_controller.text),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.05),
        ),
      ),
    );
  }


  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty || _isLoading) return;

    setState(() {
      _messages.add({'role': 'user', 'text': text});
      _isLoading = true;
      _controller.clear();
    });

    try {
      final response = await ref.read(aiServiceProvider).generateContent(text);
      setState(() {
        _messages.add({'role': 'assistant', 'text': response});
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _messages.add({'role': 'assistant', 'text': "Error: $e"});
        _isLoading = false;
      });
    }
  }
}
