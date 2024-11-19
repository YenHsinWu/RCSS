import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rcss_frontend/pages/home_page.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(
        uuid: '04518934-a0a3-4b29-a373-c971a850c410',
        userName: 'test1002',
      ),
      // home: LoginPage(),
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
