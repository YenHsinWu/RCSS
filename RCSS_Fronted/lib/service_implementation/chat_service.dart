import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatService {
  void establishWebSocketChannel() {
    final channel = WebSocketChannel.connect(
      Uri.parse('ws://localhost:7071/chat'),
    );

    channel.stream.listen((message) {
      print('Received: ${message}');
    });

    channel.sink.add('Hello from flutter');

    channel.sink.close(status.normalClosure);
  }
}
