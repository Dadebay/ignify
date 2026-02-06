class Chat {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final String? avatarUrl;

  Chat({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.isOnline = false,
    this.avatarUrl,
  });
}

class Message {
  final String id;
  final String text;
  final String time;
  final bool isSent;
  final String senderName;
  final String? senderAvatar;

  Message({
    required this.id,
    required this.text,
    required this.time,
    required this.isSent,
    required this.senderName,
    this.senderAvatar,
  });
}

class QuickReply {
  final String id;
  final String text;

  QuickReply({
    required this.id,
    required this.text,
  });
}
