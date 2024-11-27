import 'package:flutter/material.dart';
import 'package:rcss_frontend/service_implementation/friend_service.dart';
import 'package:signalr_netcore/hub_connection.dart';

class FriendChatPage extends StatefulWidget {
  final String groupName;
  final String uuid;
  final String friendUuid;
  final String userName;
  final String friendUserName;

  FriendChatPage({
    super.key,
    required this.groupName,
    required this.uuid,
    required this.friendUuid,
    required this.userName,
    required this.friendUserName,
  });

  @override
  State<FriendChatPage> createState() => _FriendChatPageState();
}

class _FriendChatPageState extends State<FriendChatPage> {
  late HubConnection _hubConnection;
  final TextEditingController _messageController = TextEditingController();
  List<String> _messages = [];
  String _seperationLine = '-------------------------';

  final FriendService _friendService = FriendService();

  @override
  void initState() {
    super.initState();
    _showFriendTalkHistory(widget.uuid, widget.friendUuid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('聊天室: ${widget.userName} - ${widget.friendUserName}'),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(_messages[index]),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(labelText: 'Enter message'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFriendTalkHistory(String uuid, String friendUuid) async {
    bool isSeperationLineAdded = false;

    Map<String, dynamic> friendTalkHistoryData =
        await _friendService.fetchFriendTalkHistory(uuid, friendUuid);

    List<String> duplicatedContents = [];
    List<dynamic> friendTalkHistory =
        friendTalkHistoryData['data'].reversed.toList();

    setState(() {
      for (int i = 0; i < friendTalkHistory.length; i++) {
        String timestamp = friendTalkHistory[i]['created_date'];
        timestamp = timestamp.split(' ')[1].substring(0, 8);

        if (duplicatedContents.isEmpty) {
          duplicatedContents.add(friendTalkHistory[i]['talk_content']);
        }

        if (duplicatedContents.length == 1) {
          // Reach the last element.
          if (i == friendTalkHistory.length - 1) {
            _messages.add(_seperationLine);
            isSeperationLineAdded = true;
          } else if (duplicatedContents[0] ==
              friendTalkHistory[i]['talk_content']) {
            duplicatedContents.add(friendTalkHistory[i]['talk_content']);
          } else if (!isSeperationLineAdded) {
            _messages.add(_seperationLine);
            isSeperationLineAdded = true;
          }
        }

        if (duplicatedContents.length == 2) {
          duplicatedContents.clear();
        }

        if (friendTalkHistory[i]['sender_uuid'] == widget.uuid &&
            friendTalkHistory[i]['reader_uuid'] == widget.uuid) {
          _messages.add(
              '${widget.userName}: ${friendTalkHistory[i]['talk_content']} --- ${timestamp}');
        } else if (friendTalkHistory[i]['sender_uuid'] == widget.friendUuid &&
            friendTalkHistory[i]['reader_uuid'] == widget.friendUuid) {
          _messages.add(
              '${widget.friendUserName}: ${friendTalkHistory[i]['talk_content']} --- ${timestamp}');
        }
      }
    });
  }
}
