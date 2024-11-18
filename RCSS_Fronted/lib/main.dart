import 'dart:io';

import 'package:bao_register/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'components/chat_message_provider.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatMessageProvider(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(
          uuid: '1a49ba31-15dd-4ee6-bda3-883ce2d65a24',
          userName: 'test1002',
        ),
        // home: LoginPage(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
