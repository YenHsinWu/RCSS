import 'package:badges/badges.dart' as badges;
import 'package:bao_register/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRoomCard extends Card {
  final String avatarPath;
  final String unreadCount;
  final String serviceName;
  final String uuid;
  final String businessId;

  const ChatRoomCard({
    super.key,
    required this.avatarPath,
    required this.unreadCount,
    required this.serviceName,
    required this.uuid,
    required this.businessId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          ChatPage(
            groupName: '${this.serviceName}-${this.uuid}',
            uuid: this.uuid,
            businessId: this.businessId,
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
            SizedBox(
              width: 48,
              height: 48,
              child: Image.asset(avatarPath),
            ),
            SizedBox(width: 20),
            Text(
              serviceName,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red),
            ),
            SizedBox(width: 28),
            badges.Badge(
              badgeContent: Text(
                this.unreadCount,
                style: TextStyle(color: Colors.white),
              ),
              showBadge: this.unreadCount != '0',
              child: Icon(Icons.notifications),
            ),
          ],
        ),
      ),
    );
  }
}
