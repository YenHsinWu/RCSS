import "dart:convert";

import "package:http/http.dart" as http;

class FriendService {
  Map<String, String> get headers {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  Future createFriendRequest(
      String uuid, String userName, String createdDate) async {
    final uri =
        Uri.parse('http://10.10.10.207:3000/api/user_add_friends/create');

    final Map<String, dynamic> requestBody = {
      'uuid': uuid,
      'user_name': userName,
      'created_date': createdDate,
    };

    final response = await http.post(
      uri,
      headers: headers,
      body: json.encode(requestBody),
    );

    Map<String, dynamic> responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception(
          '錯誤：Error code: ${responseBody['code']}, Message: ${responseBody['message']}');
    }
  }

  Future getFriendInvitationList(String userUuid) async {
    final uri =
        Uri.parse('http://10.10.10.207:3000/api/user_add_friends/${userUuid}');
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
