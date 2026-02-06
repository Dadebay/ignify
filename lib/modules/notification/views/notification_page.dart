import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Mark all read',
              style: TextStyle(
                color: Color(0xFF7B68EE),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          _buildNotificationItem(
            icon: Icons.event,
            iconColor: const Color(0xFF7B68EE),
            title: 'Drawing Class Reminder',
            message: 'Your "Buffalo\'s Drawing" class starts in 1 hour',
            time: '10 min ago',
            isUnread: true,
          ),
          _buildNotificationItem(
            icon: Icons.check_circle,
            iconColor: const Color(0xFF4CAF50),
            title: 'Booking Confirmed',
            message: 'The life Trees Ballet class has been confirmed for tomorrow at 4:15 PM',
            time: '2h ago',
            isUnread: true,
          ),
          _buildNotificationItem(
            icon: Icons.stars,
            iconColor: const Color(0xFFFFA500),
            title: 'New Activity Available',
            message: 'Check out our new LEGO Robotics program for ages 7-10!',
            time: '5h ago',
            isUnread: true,
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Earlier',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _buildNotificationItem(
            icon: Icons.schedule,
            iconColor: const Color(0xFF9C27B0),
            title: 'Schedule Update',
            message: 'Your July schedule is now available to view',
            time: 'Yesterday',
            isUnread: false,
          ),
          _buildNotificationItem(
            icon: Icons.celebration,
            iconColor: const Color(0xFFFF5722),
            title: 'Activity Completed',
            message: 'Great job! Nathan completed "My living with Mars" activity',
            time: 'Yesterday',
            isUnread: false,
          ),
          _buildNotificationItem(
            icon: Icons.card_membership,
            iconColor: const Color(0xFF2196F3),
            title: 'Membership Reminder',
            message: 'Your membership expires in 15 days. Renew now to continue enjoying activities',
            time: '2 days ago',
            isUnread: false,
          ),
          _buildNotificationItem(
            icon: Icons.notifications_active,
            iconColor: const Color(0xFFFF9800),
            title: 'Activity Suggestion',
            message: 'Based on your interests, we recommend "Fame Explorers" for Nathan',
            time: '3 days ago',
            isUnread: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String message,
    required String time,
    required bool isUnread,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isUnread ? const Color(0xFFF5F7FF) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUnread ? const Color(0xFF7B68EE).withOpacity(0.2) : Colors.grey.withOpacity(0.1),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            if (isUnread)
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF7B68EE),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              message,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
