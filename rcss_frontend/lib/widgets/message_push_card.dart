import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcss_frontend/pages/chat_room_page.dart';

import '../service_implementation/index_service.dart';

class MessagePushCard extends Card {
  final int business_id;
  final String uuid;
  final int business_message_push_id;
  final String message_title;
  final String message_content;
  final String message_image;
  final String message_url;

  MessagePushCard({
    super.key,
    required this.business_id,
    required this.uuid,
    required this.business_message_push_id,
    required this.message_title,
    required this.message_content,
    required this.message_image,
    required this.message_url
  });

  final IndexService _indexService = IndexService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCreateNewShortcutDialog(context),
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 16),
            Text(
              this.message_title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateNewShortcutDialog(BuildContext context) {
    final TextEditingController _titleController = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('請輸入捷徑名稱'),
            content: TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: '捷徑名稱'),
            ),
            actions: [
              TextButton(
                onPressed: () => {Navigator.pop(context)},
                child: Text('取消'),
              ),
              TextButton(
                onPressed: () => {
                  _indexService.createIndexPageShortcut(
                      uuid,
                      1,
                      _titleController.text,
                      {'business_id': this.business_id},
                      DateTime.now().toUtc().toString()),
                  Navigator.pop(context)
                },
                child: Text('確認'),
              ),
            ],
          );
        });
  }
}
