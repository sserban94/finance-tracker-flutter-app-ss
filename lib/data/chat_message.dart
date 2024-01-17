class ChatMessage {
  final String message;
  final bool isSentByUser;
  final DateTime timestamp;

  ChatMessage({
    required this.message,
    required this.isSentByUser,
    required this.timestamp,
  });
}