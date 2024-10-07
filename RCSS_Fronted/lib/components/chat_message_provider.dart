import 'package:bao_register/components/chat_message.dart';
import 'package:flutter/material.dart';

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
