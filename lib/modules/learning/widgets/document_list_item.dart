import 'package:flutter/material.dart';
import '../models/course_content_model.dart';

class DocumentListItem extends StatelessWidget {
  final DocumentItem document;
  final ValueChanged<bool?>? onCompletedChanged;

  const DocumentListItem({
    super.key,
    required this.document,
    this.onCompletedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD), // Light blue background
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.description, // Solid description icon
              color: Color(0xFF2196F3),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  document.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  document.sizeFormat,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          document.isCompleted
              ? Checkbox(
                  value: true,
                  onChanged: onCompletedChanged,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  activeColor: const Color(0xFF2196F3),
                )
              : Container(
                  width: 24,
                  alignment: Alignment.center,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2196F3),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
