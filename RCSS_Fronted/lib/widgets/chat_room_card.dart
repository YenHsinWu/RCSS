import 'package:flutter/material.dart';

class ChatRoomCard extends StatelessWidget {
  final String avatarPath;
  final String roomName;

  const ChatRoomCard(
      {super.key, required this.avatarPath, required this.roomName});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 96,
            height: 96,
            child: Image.asset(avatarPath),
          ),
          SizedBox(width: 20),
          Text(
            roomName,
            style: TextStyle(fontSize: 36, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
