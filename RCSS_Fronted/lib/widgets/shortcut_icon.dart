import 'package:badges/badges.dart' as badges;
import 'package:bao_register/pages/chat_room_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/chat_page.dart';
import '../pages/index_page.dart';
import '../service_implementation/index_service.dart';

class ShortcutIcon extends StatefulWidget {
  final String uuid;
  final String userName;
  final int type;
  final String imagePath;
  final String title;
  final Map<String, dynamic> shortcutUrl;
  final String unreadCount;

  const ShortcutIcon({
    super.key,
    required this.uuid,
    required this.userName,
    required this.type,
    required this.imagePath,
    required this.title,
    required this.shortcutUrl,
    required this.unreadCount,
  });

  @override
  State<ShortcutIcon> createState() => _ShortcutIconState();
}

class _ShortcutIconState extends State<ShortcutIcon> {
  final IndexService _indexService = IndexService();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            SizedBox(width: 65),
            badges.Badge(
              badgeContent: Text(
                widget.unreadCount,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              showBadge: widget.unreadCount != '0',
            ),
          ],
        ),
        GestureDetector(
          onTap: () => _clickNavigate(context),
          onLongPress: () => _showDeleteShortcutDialog(context),
          child: Image.network(
            'http://10.10.10.207:8082/${widget.imagePath}',
            width: 50,
            height: 50,
          ),
        ),
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.red,
          ),
        )
      ],
    );
  }

  void _deleteShortcut(
      String uuid, int shortcutTypeId, String shortcutTitle) async {
    try {
      for (ShortcutIcon shortcut in shortcuts) {
        if (shortcut.title == shortcutTitle) {
          shortcuts.remove(shortcut);

          await _indexService.deleteShortcut(
            uuid,
            shortcutTypeId,
            shortcutTitle,
          );
        }
      }
    } catch (ex) {
      print('Shortcut not found.');
    }
  }

  void _showDeleteShortcutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('確認刪除捷徑'),
            content: Text('刪除捷徑：${widget.title}？'),
            actions: [
              TextButton(
                onPressed: () => {Navigator.pop(context)},
                child: Text('取消'),
              ),
              TextButton(
                  onPressed: () => {
                        setState(() {
                          _deleteShortcut(
                              widget.uuid, widget.type, widget.title);
                          Navigator.pop(context);
                        }),
                      },
                  child: Text('確認')),
            ],
          );
        });
  }

  void _clickNavigate(BuildContext context) {
    switch (widget.type) {
      case 1:
        int businessId = widget.shortcutUrl['business_id'];
        Get.to(
          ChatRoomPage(
            uuid: widget.uuid,
            businessId: businessId.toString(),
            userName: widget.userName,
          ),
        );
        break;
      case 2:
        int businessId = widget.shortcutUrl['business_id'];
        String serviceName = widget.shortcutUrl['business_service_name'];
        Get.to(
          ChatPage(
            groupName: '${serviceName}^${widget.uuid}',
            uuid: widget.uuid,
            businessId: businessId.toString(),
            serviceName: serviceName,
            userName: widget.userName,
          ),
        );
    }
  }
}
