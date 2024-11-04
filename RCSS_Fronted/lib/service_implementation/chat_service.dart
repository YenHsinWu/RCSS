import "dart:convert";

import "package:http/http.dart" as http;

class ChatService {
  Map<String, String> get headers {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  Future getRecentTalkHistory(
      String uuid, String business_id, String business_service_name) async {
    final uri = Uri.parse(
        "http://10.10.10.207:3000/api/businessServiceTalks/${uuid}/${business_id}/${business_service_name}");
    final response = await http.get(uri);

    Map<String, dynamic> responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception('${response.statusCode}');
    }
  }
}
