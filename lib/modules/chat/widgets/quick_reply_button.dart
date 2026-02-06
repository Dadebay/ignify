import 'package:flutter/material.dart';
import '../models/chat_model.dart';

class QuickReplyButton extends StatelessWidget {
  final QuickReply reply;
  final VoidCallback onTap;

  const QuickReplyButton({
    super.key,
    required this.reply,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFF2196F3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Color(0xFF2196F3),
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              reply.text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF2196F3),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
