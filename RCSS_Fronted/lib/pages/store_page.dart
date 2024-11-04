import 'package:bao_register/service_implementation/store_service.dart';
import 'package:bao_register/widgets/business_card.dart';
import 'package:flutter/material.dart';

import '../views/store_page_list_view.dart';

class StorePage extends StatefulWidget {
  final String uuid;
  const StorePage({super.key, required this.uuid});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final List<BusinessCard> _businessCards = [];
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
        child: StorePageListView(
          cards: _businessCards,
          uuid: widget.uuid,
        ),
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
              uuid: uuid,
              businessName: business['business_name'],
              businessId: business['business_id'].toString(),
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
              uuid: uuid,
              businessName: business['business_name'],
              businessId: business['business_id'].toString(),
            ),
          );
        }
      }
    });
  }
}
