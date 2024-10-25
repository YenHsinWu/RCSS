import 'package:flutter/material.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late HubConnection _hubConnection;
  final TextEditingController messageController = TextEditingController();
  List<String> messages = [];

  @override
  void initState() {
    super.initState();
    _setupSignalR();
  }

  @override
  void dispose() {
    _hubConnection.stop();
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
    _hubConnection =
        HubConnectionBuilder().withUrl('https://10.0.2.2:7134/chathub').build();

    _hubConnection.on('ReceiveMessage', (arguments) {
      setState(() {
        messages.add('${arguments![0]}: ${arguments![1]}');
      });
    });

    try {
      await _hubConnection.start()!.timeout(Duration(seconds: 30));
      print("Connect to SignalR");
    } catch (e) {
      print("Connection failed ${e}");
    }
  }

  Future<void> _sendMessage() async {
    if (_hubConnection.state == HubConnectionState.Connected) {
      await _hubConnection.invoke(
        'SendMessage',
        args: ['User', messageController.text],
      );
      messageController.clear();
    } else {
      print('Connection is not established yet');
    }
  }
}
