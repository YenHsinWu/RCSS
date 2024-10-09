import "dart:convert";

import "package:http/http.dart" as http;

class AuthService {
  Future getVerificationCode({required String email}) async {
    final uri = Uri.parse(
        'http://10.10.10.207:3000/api/verification/send-verification-code');

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final Map<String, String> requestBody = {'email': email};

    final response = await http.post(
      uri,
      headers: headers,
      body: json.encode(requestBody),
    );

    Map<String, dynamic> responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      return responseBody['message'];
    } else {
      throw Exception('${response.statusCode}');
    }
  }

  Future verifyRegistration(
      {required String email,
      required String code,
      required String password,
      required String userName,
      required String phone,
      required String phoneCountry}) async {
    final uri = Uri.parse(
        'http://10.10.10.207:3000/api/registration/verify-registration');

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final Map<String, String> requestBody = {
      'email': email,
      'code': code,
      'password': password,
      'user_name': userName,
      'phone': phone,
      'phone_country': phoneCountry,
    };

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

  Future loginWithEmailAndPassword(
      {required String email, required String password}) async {
    final uri = Uri.parse('http://10.10.10.207:3000/api/login');

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final Map<String, String> requestBody = {
      'identifier': email,
      'password': password,
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
      throw Exception('${response.statusCode}');
    }
  }
}
