import 'package:flutter/material.dart';
import 'package:rcss_frontend/components/chat_message.dart';

class ChatMessageProvider with ChangeNotifier {
  List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;

  void sendMessage(String content) {
    _messages.add(ChatMessage(content: content, isSentByMe: true));
    notifyListeners();
  }

  void receiveMessage(String content) {
    _messages.add(ChatMessage(content: content, isSentByMe: false));
    notifyListeners();
  }
}
