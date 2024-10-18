import 'package:bao_register/service_implementation/store_service.dart';
import 'package:bao_register/views/text_list_view.dart';
import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final List<Text> _businessNames = [];
  final StoreService _storeService = StoreService();

  @override
  void initState() {
    super.initState();
    fetchBusinessNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: TextListView(texts: _businessNames),
      ),
    );
  }

  void fetchBusinessNames() async {
    List<dynamic> businessData = await _storeService.fetchBusinesses();
    setState(() {
      for (Map<String, dynamic> business in businessData) {
        _businessNames.add(
          Text(
            business['business_name'],
            style: TextStyle(
              color: Colors.red,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
    });
  }
}
