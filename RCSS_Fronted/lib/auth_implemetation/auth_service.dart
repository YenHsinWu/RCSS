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
}
