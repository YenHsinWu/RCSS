import 'package:bao_register/widgets/chat_room_card.dart';
import 'package:flutter/material.dart';

import '../service_implementation/store_service.dart';
import '../views/chat_room_page_list_view.dart';

class ServicePage extends StatefulWidget {
  final String uuid;

  const ServicePage({super.key, required this.uuid});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final List<ChatRoomCard> _chatRoomCards = [];
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
        child: ChatRoomPageListView(
          cards: _chatRoomCards,
        ),
      ),
    );
  }

  void getBusinessServicesListByUuid(String uuid) async {
    Map<String, dynamic> businessServicesList =
        await _storeService.getBusinessServicesListByUuid(uuid);

    setState(() {
      for (Map<String, dynamic> businessService in businessServicesList['data'])
        _chatRoomCards.add(
          ChatRoomCard(
            avatarPath: '',
            unreadCount:
                businessService['business_service_talks_is_not_read_count'],
            serviceName: "${businessService['business_service_name']}",
            uuid: uuid,
            businessId: businessService['business_id'].toString(),
            userName: (businessService['user_name'] == null
                ? 'Unknown User'
                : businessService['user_name']),
          ),
        );
    });
  }
}
