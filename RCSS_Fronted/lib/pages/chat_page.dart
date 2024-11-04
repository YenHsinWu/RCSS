import 'package:bao_register/service_implementation/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class ChatPage extends StatefulWidget {
  final String groupName;
  final String uuid;
  final String businessId;

  const ChatPage({
    super.key,
    required this.groupName,
    required this.uuid,
    required this.businessId,
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

  void _showHistoryMessages() async {
    Map<String, dynamic> recentMessagesHistoryData = await _chatService
        .getRecentTalkHistory(widget.uuid, widget.businessId, widget.groupName);
    setState(() {
      for (Map<String, dynamic> recentMessagesHistory
          in recentMessagesHistoryData['data'].reversed) {
        if (recentMessagesHistory['is_user_talk']) {
          messages.add(
              '[${recentMessagesHistory['business_service_name']}] --- ${recentMessagesHistory['user_uuid']}: ${recentMessagesHistory['talk_content']}');
        } else {
          messages.add(
              '[${recentMessagesHistory['business_service_name']}] --- ${recentMessagesHistory['backend_user_name']}: ${recentMessagesHistory['talk_content']}');
        }
      }
    });
  }

  Future<void> _setupSignalR() async {
    hubConnection =
        HubConnectionBuilder().withUrl('https://10.0.2.2:7144/chathub').build();

    hubConnection.start()?.then((_) {
      print("SignalR Connected");

      hubConnection.invoke('JoinGroup', args: [widget.groupName, widget.uuid]);

      hubConnection!.on('SendGroupMsg', (arguments) {
        setState(() {
          messages
              .add('[${arguments![0]}] --- ${arguments[1]}: ${arguments[2]}');
          scrollToBottom();
        });
      });
    });
  }

  Future<void> _sendMessage() async {
    if (hubConnection.state == HubConnectionState.Connected) {
      await hubConnection.invoke(
        'SendMessageToGroup',
        args: [widget.groupName, widget.uuid, messageController.text],
      );
    } else {
      print('Connection is not established yet');
    }
  }

  void scrollToBottom() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 3), curve: Curves.easeOut);
  }
}
