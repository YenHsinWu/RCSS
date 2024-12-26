import 'package:flutter/material.dart';
import 'package:rcss_frontend/auth_implemetation/auth_service.dart';
import 'package:rcss_frontend/pages/login_page.dart';
import '../widgets/text_field_widget.dart';

class VoiceVerificationPage extends StatelessWidget {
  final String email;
  final String password;
  final String phone;
  final String phoneCountry;
  final String countryId;
  final String sendbackphone;
  final String validationcode;

  VoiceVerificationPage({
    super.key,
    required String this.email,
    required String this.password,
    required String this.phone,
    required String this.phoneCountry,
    required String this.countryId,
    required String this.sendbackphone,
    required String this.validationcode,
  });

  final AuthService authService = AuthService();

  final TextEditingController verificationController = TextEditingController();
  final TextEditingController waitingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('語音接收驗證碼驗證'),
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
            )
          ],
        ),
      ),
    );
  }

  void _verify(BuildContext context) async {
    String code1="驗證失敗，請重新註冊";
    Map<String, dynamic> response=new Map<String, dynamic>();
    waitingController.text="等候簡訊驗證中...";
    for(var i=90;i>=0;i--)
    {
      verificationController.text=i.toString();
      await Future.delayed(Duration(seconds: 1));
      if(i<90 && i%10==0) {
        response = await authService
            .verifyRegistrationByMessage(
            email: email,
            code: validationcode,
            password: password,
            userName: email.split('@')[0],
            phone: phone,
            phoneCountry: phoneCountry,
            countryId: countryId);
        if (response['code'] == 0) {
          code1 = "驗證成功，將轉向到登入頁面...";
          break;
        }
      }
    }
    waitingController.text=code1;
    if(response['code'] == 0) {
      await Future.delayed(Duration(seconds: 3));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
    /*Map<String, dynamic> response = await authService.verifyRegistrationByPhone(
        email: email,
        code: code,
        password: password,
        userName: email.split('@')[0],
        phone: phone,
        phoneCountry: phoneCountry,
        countryId: countryId);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );*/
  }
}
