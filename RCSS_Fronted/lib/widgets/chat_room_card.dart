import 'package:badges/badges.dart' as badges;
import 'package:bao_register/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRoomCard extends Card {
  final String avatarPath;
  final String unreadCount;
  final String groupName;
  final String uuid;
  final String serviceName;

  const ChatRoomCard({
    super.key,
    required this.avatarPath,
    required this.unreadCount,
    required this.groupName,
    required this.uuid,
    required this.serviceName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          ChatPage(
            groupName: this.groupName,
            uuid: this.uuid,
            serviceName: this.serviceName,
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
              groupName,
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
