import 'package:flutter/material.dart';

import '../pages/chat_page.dart';

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(),
                      ),
                    );
                  })
            ],
          );
        });
  }
}
