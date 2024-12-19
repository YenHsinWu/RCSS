import "dart:convert";

import "package:http/http.dart" as http;

class MessagePushService {
  Map<String, String> get headers {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  Future getBusinessMessagePushIsNotRead(String uuid) async {
    final uri = Uri.parse(
        'http://10.10.10.207:3000/api/businessmessagepushisnotread/${uuid}');
    final response = await http.get(uri);

    Map<String, dynamic> responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception(
          '錯誤：Error code: ${responseBody['code']}, Message: ${responseBody['message']}');
    }
  }
}
