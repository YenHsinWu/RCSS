import 'package:bao_register/pages/chat_room_page.dart';
import 'package:flutter/material.dart';

import '../pages/chat_page.dart';
import '../widgets/business_card.dart';
import '../widgets/chat_room_card.dart';

class CardListView extends StatelessWidget {
  final List<Card> cards;
  const CardListView({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: cards.length,
        itemBuilder: (
          context,
          index,
        ) {
          return Column(
            children: [
              GestureDetector(
                  child: cards[index],
                  onTap: () {
                    if (cards[0].runtimeType == BusinessCard) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatRoomPage(),
                        ),
                      );
                    } else if (cards[0].runtimeType == ChatRoomCard) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(),
                        ),
                      );
                    }
                  })
            ],
          );
        });
  }
}
