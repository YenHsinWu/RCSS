import 'package:bao_register/components/count_down_timer.dart';
import 'package:flutter/material.dart';

class CountDownPage extends StatefulWidget {
  const CountDownPage({super.key});

  @override
  State<CountDownPage> createState() => _CountDownPageState();
}

class _CountDownPageState extends State<CountDownPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('回傳認證'),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: CountDownTimer(),
      ),
    );
  }
}
