import 'package:flutter/material.dart';
import 'package:rcss_frontend/service_implementation/friend_service.dart';
import 'package:rcss_frontend/widgets/friend_card.dart';

class InvitationPage extends StatefulWidget {
  final String uuid;

  InvitationPage({
    super.key,
    required this.uuid,
  });

  @override
  State<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  final FriendService _friendService = FriendService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('好友邀請'),
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
    );
  }
}
