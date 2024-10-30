import 'package:flutter/material.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class ChatPage extends StatefulWidget {
  final String groupName;
  final String uuid;
  final String serviceName;

  const ChatPage({
    super.key,
    required this.groupName,
    required this.uuid,
    required this.serviceName,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late HubConnection hubConnection;
  final TextEditingController messageController = TextEditingController();
  List<String> messages = [];

  @override
  void initState() {
    super.initState();
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
      // setState(() {
      //   messages.add(
      //       "[${widget.groupName}] --- ${widget.uuid}: ${messageController.text}");
      //   messageController.clear();
      // });
    } else {
      print('Connection is not established yet');
    }
  }
}
