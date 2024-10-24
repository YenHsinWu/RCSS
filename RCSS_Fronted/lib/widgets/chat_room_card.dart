import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

class ChatRoomCard extends Card {
  final String avatarPath;
  final String unreadCount;
  final String roomName;

  const ChatRoomCard(
      {super.key,
      required this.avatarPath,
      required this.unreadCount,
      required this.roomName});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
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
            roomName,
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
    );
  }
}
