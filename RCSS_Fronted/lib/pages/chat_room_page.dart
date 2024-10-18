import 'package:bao_register/views/card_list_view.dart';
import 'package:flutter/material.dart';

import '../widgets/chat_room_card.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({super.key});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  List<Card> cards = [];

  List<Card>? generateDummyCards() {
    for (int i = 0; i < 20; i++) {
      cards.add(ChatRoomCard(
          avatarPath: 'assets/images/avatar.png', roomName: 'test'));
    }

    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return CardListView(cards: generateDummyCards()!);
  }
}
