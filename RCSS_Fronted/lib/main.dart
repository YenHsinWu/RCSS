import 'package:bao_register/pages/home_page.dart';
import 'package:bao_register/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/chat_message_provider.dart';

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatMessageProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignUpPage(),
      ),
    );
  }
}
