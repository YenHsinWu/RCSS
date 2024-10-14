import "dart:convert";

import "package:http/http.dart" as http;
import "package:url_launcher/url_launcher.dart";

class AuthService {
  Map<String, String> get headers {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  Future getVerificationCode({required String email}) async {
    final uri = Uri.parse(
        'http://10.10.10.207:3000/api/verification/send-verification-code');

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

  Future getVerificationCodeByPhone({required String phone}) async {
    final uri = Uri.parse('http://10.10.10.207:3000/api/sms/send-sms');

    final Map<String, String> requestBody = {'phone': phone};

    final response = await http.post(
      uri,
      headers: headers,
      body: json.encode(requestBody),
    );

    Map<String, dynamic> responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      print(responseBody['message']);
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
    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception('${response.statusCode}');
    }
  }

  Future verifyRegistrationByPhone(
      {required String email,
      required String code,
      required String password,
      required String userName,
      required String phone,
      required String phoneCountry}) async {
    final uri =
        Uri.parse('http://10.10.10.207:3000/api/verify-phone-registration');

    final Map<String, String> requestBody = {
      'phone': phone,
      'code': code,
      'user_name': userName,
      'email': email,
      'phone_country': phoneCountry,
      'password': password,
    };

    final response = await http.post(
      uri,
      headers: headers,
      body: json.encode(requestBody),
    );

    Map<String, dynamic> responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      print(responseBody['message']);
      return responseBody;
    } else {
      print(responseBody['message']);
      throw Exception('${response.statusCode}');
    }
  }

  Future thirdPartyRegistration() async {
    final uri = Uri.parse('http://10.10.10.207:3000/api/auth/google');

    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  Future loginWithEmailAndPassword(
      {required String email, required String password}) async {
    final uri = Uri.parse('http://10.10.10.207:3000/api/login');

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

  Future resetPassword(
      {required String email,
      required String code,
      required String password}) async {
    final uri =
        Uri.parse('http://10.10.10.207:3000/api/password-reset/password-reset');

    final Map<String, String> requestBody = {
      'email': email,
      'code': code,
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
