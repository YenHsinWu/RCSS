import 'package:flutter/material.dart';

class ServicePage extends StatefulWidget {
  final int serviceIndex;

  const ServicePage({super.key, required this.serviceIndex});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    return Text("服務");
  }
}
