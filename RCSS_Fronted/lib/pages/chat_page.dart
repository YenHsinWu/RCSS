import 'package:bao_register/service_implementation/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class ChatPage extends StatefulWidget {
  final String groupName;
  final String uuid;
  final String businessId;
  final String serviceName;

  const ChatPage({
    super.key,
    required this.groupName,
    required this.uuid,
    required this.businessId,
    required this.serviceName,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late HubConnection hubConnection;
  final TextEditingController messageController = TextEditingController();
  List<String> messages = [];

  ChatService _chatService = ChatService();

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // _setUnreadCountToZero();
    _showHistoryMessages();
    _setupSignalR();
  }

  @override
  void dispose() {
    hubConnection.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('聊天室'),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: messages.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(messages[index]),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(labelText: 'Enter message'),
                  ),
                ),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _setUnreadCountToZero() async {
    await _chatService.setUnreadMessagesCountToZero(
      widget.uuid,
      widget.businessId,
      widget.groupName,
    );
  }

  void _showHistoryMessages() async {
    Map<String, dynamic> recentMessagesHistoryData =
        await _chatService.getRecentTalkHistory(
            widget.uuid, widget.businessId, widget.serviceName);
    setState(() {
      for (Map<String, dynamic> recentMessagesHistory
          in recentMessagesHistoryData['data']) {
        String timestamp = recentMessagesHistory['created_date'];
        timestamp = timestamp.split('T')[1].substring(0, 8);

        if (recentMessagesHistory['is_user_talk']) {
          messages.add(
              '[${widget.groupName}] --- ${recentMessagesHistory['user_uuid']}: ${recentMessagesHistory['talk_content']} --- [${timestamp}]');
        } else {
          messages.add(
              '[${widget.groupName}] --- ${recentMessagesHistory['backend_user_name']}: ${recentMessagesHistory['talk_content']} --- [${timestamp}]');
        }
      }
    });
  }

  Future<void> _setupSignalR() async {
    hubConnection =
        HubConnectionBuilder().withUrl('http://10.0.2.2:5101/chathub').build();

    hubConnection.start()?.then((_) {
      print("SignalR Connected");

      hubConnection.invoke('JoinGroup', args: [widget.groupName, widget.uuid]);

      hubConnection!.on('SendGroupMsg', (arguments) {
        setState(() {
          messages.add(
              '[${arguments![0]}] --- ${arguments[1]}: ${arguments[2]} --- [${arguments[3]}]');
        });
      });
    });
  }

  Future<void> _sendMessage() async {
    if (hubConnection.state == HubConnectionState.Connected) {
      // String timestamp = formatDate(DateTime.now(), [HH, ':', mm, ':', ss]);
      await hubConnection.invoke(
        'SendMessageToGroup',
        args: [
          widget.groupName,
          widget.uuid,
          messageController.text,
        ],
      );
      messageController.clear();
    } else {
      print('Connection is not established yet');
    }
  }

  void scrollToBottom() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 3), curve: Curves.easeOut);
  }
}
