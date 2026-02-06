import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../models/chat_model.dart';
import '../widgets/chat_item.dart';
import 'chat_detail_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  // Sample data
  List<Chat> _getSampleChats() {
    return [
      Chat(
        id: '1',
        name: 'Harmony House',
        lastMessage: 'See you there!',
        time: '10:45 AM',
        unreadCount: 1,
        isOnline: false,
        avatarUrl: 'assets/images/logo_5.png',
      ),
      Chat(
        id: '2',
        name: 'Culinary creators',
        lastMessage: 'Great! The invoice is attached',
        time: '10:20 AM',
        unreadCount: 0,
        isOnline: true,
        avatarUrl: 'assets/images/logo_2.png',
      ),
      Chat(
        id: '3',
        name: 'Music Academy',
        lastMessage: 'Thank you!',
        time: 'Yesterday',
        unreadCount: 0,
        isOnline: false,
        avatarUrl: 'assets/images/logo_3.png',
      ),
      Chat(
        id: '4',
        name: 'Al\'s Boxing',
        lastMessage: 'Let me know your goals for this week!',
        time: 'Mon',
        unreadCount: 0,
        isOnline: false,
        avatarUrl: 'assets/images/logo_1.png',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final chats = _getSampleChats();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: 10, top: 8, bottom: 8, right: 8),
          padding: const EdgeInsets.only(left: 14, right: 8, top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 16),
        ),
        title: const Text(
          'Messages',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextField(
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(IconlyLight.search, color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ChatItem(
                  chat: chat,
                  onTap: () => Get.to(() => ChatDetailPage(chat: chat)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
