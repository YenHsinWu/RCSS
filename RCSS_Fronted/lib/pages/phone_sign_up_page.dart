import 'package:bao_register/auth_implemetation/auth_service.dart';
import 'package:bao_register/pages/phone_verification_page.dart';
import 'package:bao_register/pages/sign_up_page.dart';
import 'package:bao_register/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class PhoneSignUpPage extends StatelessWidget {
  PhoneSignUpPage({super.key});

  final AuthService _authService = AuthService();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("歡迎加入註冊寶"),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "手機註冊",
            style: TextStyle(
                color: Colors.red, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 32),
          TextFieldWidget(
            controller: phoneController,
            hintText: "手機",
            obscureText: false,
          ),
          SizedBox(height: 12),
          TextFieldWidget(
            controller: emailController,
            hintText: "Email",
            obscureText: false,
          ),
          SizedBox(height: 12),
          TextFieldWidget(
            controller: passwordController,
            hintText: "Password",
            obscureText: true,
          ),
          SizedBox(height: 32),
          GestureDetector(
            onTap: () => _signUp(context),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  "註冊",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "已註冊?",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
              SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: Text("立即登入!",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpPage(),
                    ),
                  );
                },
                child: Text("改用信箱註冊",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _signUp(BuildContext context) {
    String phone = phoneController.text;
    String email = emailController.text;
    String password = passwordController.text;

    _authService.getVerificationCodeByPhone(phone: phone);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PhoneVerificationPage(
              email: email, password: password, phone: phone)),
    );
  }
}
