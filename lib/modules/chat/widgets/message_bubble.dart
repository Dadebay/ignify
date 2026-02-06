import 'package:flutter/material.dart';
import '../models/chat_model.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 50, top: 4, bottom: 4),
      child: Row(
        mainAxisAlignment: message.isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isSent) ...[
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey[300],
              backgroundImage:
                  message.senderAvatar != null ? (message.senderAvatar!.startsWith('http') ? NetworkImage(message.senderAvatar!) : AssetImage(message.senderAvatar!) as ImageProvider) : null,
              child: message.senderAvatar == null
                  ? Text(
                      message.senderName[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: message.isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!message.isSent)
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 4),
                    child: Text(
                      message.senderName,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: message.isSent ? const Color(0xFFE3F2FD) : Colors.grey.withOpacity(.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    message.text,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                  child: Text(
                    message.time,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (message.isSent) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey[300],
              backgroundImage:
                  message.senderAvatar != null ? (message.senderAvatar!.startsWith('http') ? NetworkImage(message.senderAvatar!) : AssetImage(message.senderAvatar!) as ImageProvider) : null,
              child: message.senderAvatar == null
                  ? Text(
                      message.senderName[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  : null,
            ),
          ],
        ],
      ),
    );
  }
}
