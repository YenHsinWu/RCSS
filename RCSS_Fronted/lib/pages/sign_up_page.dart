import "package:bao_register/auth_implemetation/auth_service.dart";
import "package:bao_register/pages/phone_sign_up_page.dart";
import "package:bao_register/pages/verification_page.dart";
import "package:bao_register/widgets/text_field_widget.dart";
import "package:flutter/material.dart";
import "package:intl_phone_field/intl_phone_field.dart";

import "login_page.dart";

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService authService = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("歡迎加入註冊寶"),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "信箱註冊",
              style: TextStyle(
                  color: Colors.red, fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            TextFieldWidget(
                controller: emailController,
                hintText: "Email",
                obscureText: false),
            SizedBox(height: 12),
            TextFieldWidget(
                controller: passwordController,
                hintText: "Password",
                obscureText: true),
            SizedBox(height: 12),
            IntlPhoneField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: "Phone Number",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.red, width: 3),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.red, width: 3),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 3),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            SizedBox(height: 32),
            GestureDetector(
              onTap: _signUp,
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
                        builder: (context) => PhoneSignUpPage(),
                      ),
                    );
                  },
                  child: Text("改用手機註冊",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _signUp() async {
    String email = emailController.text;
    String password = passwordController.text;
    String phone = phoneController.text;

    String message = await authService.getVerificationCode(email: email);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            VerificationPage(email: email, password: password, phone: phone),
      ),
    );
  }
}
