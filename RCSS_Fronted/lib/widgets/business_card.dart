import 'package:badges/badges.dart' as badges;
import 'package:bao_register/pages/chat_room_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessCard extends Card {
  final String unreadCount;
  final String uuid;
  final String businessName;
  final String businessId;

  const BusinessCard(
      {super.key,
      required this.unreadCount,
      required this.uuid,
      required this.businessName,
      required this.businessId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          ChatRoomPage(
            uuid: uuid,
            businessId: businessId,
          ),
        );
      },
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 16),
            Text(
              this.businessName,
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            ),
            SizedBox(width: 28),
            badges.Badge(
              badgeContent: Text(
                this.unreadCount,
                style: TextStyle(color: Colors.white),
              ),
              showBadge: this.unreadCount != '0',
              child: Icon(Icons.notifications),
            )
          ],
        ),
      ),
    );
  }
}
