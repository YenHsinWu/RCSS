import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rcss_frontend/pages/friend_chat_page.dart';
import 'package:rcss_frontend/service_implementation/index_service.dart';

class FriendCard extends Card {
  final String uuid;
  final String friendUuid;
  final String userName;
  final String friendUserName;
  final String countUuid;
  final String count;

  FriendCard({
    super.key,
    required this.uuid,
    required this.friendUuid,
    required this.userName,
    required this.friendUserName,
    required this.countUuid,
    required this.count,
  });

  final IndexService _indexService = IndexService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        String uname = this.countUuid == this.uuid ? userName : friendUserName;
        String fname = this.countUuid == this.uuid ? friendUserName : userName;
        Get.to(
          FriendChatPage(
            groupName: '${this.uuid}^${this.friendUuid}',
            uuid: this.uuid,
            friendUuid: this.friendUuid,
            userName: uname,
            friendUserName: fname,
          ),
        );
      },
      onLongPress: () {},
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 16),
            Text(
              this.friendUserName,
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 28),
            badges.Badge(
              badgeContent: Text(
                this.count,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              showBadge: this.count != '0',
              child: Icon(Icons.notifications),
            ),
          ],
        ),
      ),
    );
  }
}
