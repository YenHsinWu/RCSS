import 'package:flutter/material.dart';
import 'package:rcss_frontend/service_implementation/friend_service.dart';

class FriendPage extends StatefulWidget {
  final String uuid;

  const FriendPage({
    super.key,
    required this.uuid,
  });

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  final FriendService _friendService = FriendService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('好友'),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: FloatingActionButton(
              onPressed: () => _showCreateFriendRequestDialog(context),
              child: Icon(Icons.add),
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 100.0,
            child: FloatingActionButton(
              onPressed: () => {},
              child: Icon(Icons.mail),
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _showCreateFriendRequestDialog(BuildContext context) {
    final TextEditingController _userNameController = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('請輸入用戶名稱'),
            content: TextField(
              controller: _userNameController,
              decoration: InputDecoration(labelText: '用戶名稱'),
            ),
            actions: [
              TextButton(
                onPressed: () => {Navigator.pop(context)},
                child: Text('取消'),
              ),
              TextButton(
                onPressed: () => {
                  _friendService.createFriendRequest(
                      widget.uuid,
                      _userNameController.text,
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
