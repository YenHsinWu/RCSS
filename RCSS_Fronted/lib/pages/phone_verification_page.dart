import 'package:bao_register/auth_implemetation/auth_service.dart';
import 'package:bao_register/pages/home_page.dart';
import 'package:bao_register/pages/return_verify_page.dart';
import 'package:flutter/material.dart';

import '../widgets/text_field_widget.dart';

class PhoneVerificationPage extends StatelessWidget {
  final String email;
  final String password;
  final String phone;

  PhoneVerificationPage(
      {super.key,
      required String this.email,
      required String this.password,
      required String this.phone});

  final AuthService authService = AuthService();

  final TextEditingController verificationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('手機驗證'),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "驗證碼",
              style: TextStyle(
                  color: Colors.red, fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            TextFieldWidget(
                controller: verificationController,
                hintText: "驗證碼",
                obscureText: false),
            SizedBox(height: 32),
            GestureDetector(
              onTap: () => _verify(context),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    "驗證",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),
            GestureDetector(
              onTap: () => _returnVerify(context),
              child: Container(
                width: double.infinity,
                height: 50,
                child: Center(
                  child: Text(
                    "點我使用回傳信箱驗證",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _verify(BuildContext context) async {
    String code = verificationController.text;
    Map<String, dynamic> response = await authService.verifyRegistrationByPhone(
        email: email,
        code: code,
        password: password,
        userName: email.split('@')[0],
        phone: phone,
        phoneCountry: 'TW');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  void _returnVerify(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReturnVerifyPage(),
      ),
    );
  }
}
