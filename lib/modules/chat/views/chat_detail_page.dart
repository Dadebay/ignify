import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../models/chat_model.dart';
import '../widgets/message_bubble.dart';
import '../widgets/quick_reply_button.dart';
import '../widgets/chat_input.dart';

class ChatDetailPage extends StatefulWidget {
  final Chat chat;

  const ChatDetailPage({
    super.key,
    required this.chat,
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final List<Message> _messages = [];
  final List<QuickReply> _quickReplies = [];
  bool _showQuickReplies = true;

  @override
  void initState() {
    super.initState();
    _loadSampleData();
  }

  void _loadSampleData() {
    // Sample messages
    _messages.addAll([
      Message(
        id: '1',
        text: 'Great news! A spot just opened up in our Intro to Music Techniques class this Saturday at 2 PM. Want to join?',
        time: '2:30 PM',
        isSent: false,
        senderName: widget.chat.name,
        senderAvatar: widget.chat.avatarUrl,
      ),
    ]);

    // Sample quick replies
    _quickReplies.addAll([
      QuickReply(
        id: '1',
        text: 'Yes, I\'d love to join!',
      ),
      QuickReply(
        id: '2',
        text: 'Yes, I\'m interested',
      ),
    ]);
  }

  void _handleSendMessage(String text) {
    setState(() {
      _messages.add(
        Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: text,
          time: _formatTime(DateTime.now()),
          isSent: true,
          senderName: 'You',
          senderAvatar: 'assets/images/logo_4.png',
        ),
      );
      _showQuickReplies = false;
    });
  }

  void _handleQuickReply(QuickReply reply) {
    _handleSendMessage(reply.text);
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 50,
        leading: Padding(
          padding: const EdgeInsets.all(8.0).copyWith(right: 0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
              padding: const EdgeInsets.only(left: 6),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey[300],
              backgroundImage:
                  widget.chat.avatarUrl != null ? (widget.chat.avatarUrl!.startsWith('http') ? NetworkImage(widget.chat.avatarUrl!) : AssetImage(widget.chat.avatarUrl!) as ImageProvider) : null,
              child: widget.chat.avatarUrl == null
                  ? Text(
                      widget.chat.name[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chat.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    'Active now',
                    style: TextStyle(
                      color: Color(0xFF4CAF50),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(IconlyLight.call, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(IconlyLight.video, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: _messages.length + 1, // +1 for date divider
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Date divider
                  return Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }
                return MessageBubble(message: _messages[index - 1]);
              },
            ),
          ),
          // Quick replies
          if (_showQuickReplies && _quickReplies.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD).withValues(alpha: 0.5), // Light blue background
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      color: Color(0xFF2196F3),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    ..._quickReplies.map(
                      (reply) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: QuickReplyButton(
                          reply: reply,
                          onTap: () => _handleQuickReply(reply),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          // Input
          ChatInput(onSendMessage: _handleSendMessage),
        ],
      ),
    );
  }
}
