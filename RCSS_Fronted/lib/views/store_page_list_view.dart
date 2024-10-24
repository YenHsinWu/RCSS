import 'package:flutter/material.dart';

import '../pages/chat_room_page.dart';
import '../widgets/business_card.dart';

class StorePageListView extends StatelessWidget {
  final String uuid;
  final String businessId;
  final List<BusinessCard> cards;
  const StorePageListView({
    super.key,
    required this.cards,
    required this.uuid,
    required this.businessId,
  });

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
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatRoomPage(
                              uuid: this.uuid,
                              businessId: cards[index].businessId,
                            ),
                          ),
                        ),
                      }),
            ],
          );
        });
  }
}
