import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  final Function(String) onSendMessage;

  const ChatInput({
    super.key,
    required this.onSendMessage,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onSendMessage(_controller.text.trim());
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Emoji button
            IconButton(
              icon: const Icon(Icons.emoji_emotions_outlined),
              color: Colors.grey[600],
              onPressed: () {
                // Emoji picker functionality
              },
            ),
            // Text input
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'сообщение...',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            // Attachment button
            Transform.rotate(
              angle: 3.14 / 4, // 45 degrees
              child: IconButton(
                icon: const Icon(Icons.attach_file),
                color: Colors.grey[600],
                onPressed: () {
                  // File attachment functionality
                },
              ),
            ),
            // Send button
            IconButton(
              icon: const Icon(Icons.send),
              color: const Color(0xFF2196F3),
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
