import "dart:convert";

import "package:http/http.dart" as http;

class AuthService {
  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse("http://10.0.2.2:3000/api/users/4"),
    );

    if (response.statusCode == 200) {
      final _data = json.decode(response.body);
    }
  }

  Future loginWithEmailAndPassword(
      {required String email, required String password}) async {
    final uri = Uri.parse('http://10.0.2.2:3000/api/login');

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final Map<String, String> requestBody = {
      'identifier': email,
      'password': password,
    };

    print(json.encode(requestBody));

    final response = await http.post(
      uri,
      headers: headers,
      body: json.encode(requestBody),
    );

    Map<String, dynamic> responseBody = json.decode(response.body);
    print(responseBody);
    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception('${response.statusCode}');
    }
  }
}
