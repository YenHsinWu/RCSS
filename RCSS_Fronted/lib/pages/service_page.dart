import 'package:flutter/material.dart';

import '../service_implementation/store_service.dart';
import '../views/store_page_list_view.dart';
import '../widgets/business_card.dart';

class ServicePage extends StatefulWidget {
  final String uuid;

  const ServicePage({super.key, required this.uuid});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final List<BusinessCard> _businessCards = [];
  final StoreService _storeService = StoreService();

  @override
  void initState() {
    super.initState();
    getBusinessServicesListByUuid(widget.uuid);
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

  void getBusinessServicesListByUuid(String uuid) async {
    Map<String, dynamic> businessServicesList =
        await _storeService.getBusinessServicesListByUuid(uuid);

    setState(() {
      for (Map<String, dynamic> businessService
          in businessServicesList['data']) {
        if (businessService['is_user_read'] != null) {
          _businessCards.add(
            BusinessCard(
              unreadCount:
                  businessService['business_service_talks_is_not_read_count'],
              uuid: businessService['user_uuid'],
              businessName: businessService['business_service_name'],
              businessId: businessService['business_id'].toString(),
            ),
          );
        } else {
          _businessCards.add(
            BusinessCard(
              unreadCount: '0',
              uuid: businessService['user_uuid'].toString(),
              businessName: businessService['business_service_name'],
              businessId: businessService['business_id'].toString(),
            ),
          );
        }
      }
    });
  }
}
