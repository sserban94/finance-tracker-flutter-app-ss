import 'package:finances_tracker_app_ss_flutter/data/transaction.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

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

class _ChatbotScreenState extends State<ChatbotScreen> {
  final box = Hive.box<Transaction>('transaction');
  final List<ChatMessage> _chatHistory = [];
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Powered Chatbot - WIP - Stay Tooned!',
        style: TextStyle(
          color: Color.fromRGBO(96, 63, 211, 1),
          fontSize: 18,
          fontWeight: FontWeight.w600
        ),),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _chatHistory.length,
              itemBuilder: (context, index) {
                final chatMessage = _chatHistory[index];
                final alignment = chatMessage.isSentByUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
                return Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: alignment,
                    children: [
                      Text(chatMessage.message),
                      Text(
                        '${chatMessage.timestamp.hour}:${chatMessage.timestamp.minute}',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(hintText: 'Type a message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        _chatHistory.add(ChatMessage(
          message: message,
          isSentByUser: true,
          timestamp: DateTime.now(),
        ));
      });
      _messageController.clear();
      _simulateAIResponse();
    }
  }

  void _simulateAIResponse() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _chatHistory.add(ChatMessage(
          message: 'I am not ready to reply to "${_chatHistory.last.message}"yet, but I will be soon enough so don\'t hold your breath',
          isSentByUser: false,
          timestamp: DateTime.now(),
        ));
      });
    });
  }
}
