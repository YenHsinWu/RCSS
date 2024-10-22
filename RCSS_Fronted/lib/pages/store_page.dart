import 'package:bao_register/service_implementation/store_service.dart';
import 'package:bao_register/widgets/business_card.dart';
import 'package:flutter/material.dart';

import '../views/card_list_view.dart';

class StorePage extends StatefulWidget {
  final String uuid;
  StorePage({super.key, required this.uuid});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final List<Card> _businessCards = [];
  final StoreService _storeService = StoreService();

  @override
  void initState() {
    super.initState();
    getBusinessNamesAndUnreadCountsByUuid(widget.uuid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CardListView(cards: _businessCards),
      ),
    );
  }

  void getBusinessNamesAndUnreadCountsByUuid(String uuid) async {
    Map<String, dynamic> businessNamesAndUnreadCountsByUuid =
        await _storeService.getBusinessListByUuid(uuid);

    setState(() {
      for (Map<String, dynamic> business
          in businessNamesAndUnreadCountsByUuid['data']) {
        if (business['is_user_read'] != null) {
          _businessCards.add(
            BusinessCard(
              unreadCount: business['business_service_talks_is_not_read_count'],
              businessName: business['business_name'],
            ),
          );
        }
      }

      for (Map<String, dynamic> business
          in businessNamesAndUnreadCountsByUuid['data']) {
        if (business['is_user_read'] == null) {
          _businessCards.add(
            BusinessCard(
              unreadCount: '0',
              businessName: business['business_name'],
            ),
          );
        }
      }
    });
  }
}
