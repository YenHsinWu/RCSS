import 'package:bao_register/widgets/chat_room_card.dart';
import 'package:flutter/material.dart';

import '../service_implementation/store_service.dart';
import '../views/chat_room_page_list_view.dart';

class ChatRoomPage extends StatefulWidget {
  final String uuid;
  final String businessId;

  const ChatRoomPage({
    super.key,
    required this.uuid,
    required this.businessId,
  });

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final List<ChatRoomCard> _chatRoomCards = [];
  final StoreService _storeService = StoreService();

  @override
  void initState() {
    super.initState();
    getBusinessServiceNamesAndUnreadCountsByUuidAndBusinessId(
        widget.uuid, widget.businessId);
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

  void getBusinessServiceNamesAndUnreadCountsByUuidAndBusinessId(
      String uuid, String businessId) async {
    Map<String, dynamic> businessServiceNamesAndUnreadCounts =
        await _storeService.getBusinessServicesListByUuidAndBusinessId(
            uuid, businessId);
    print(businessServiceNamesAndUnreadCounts);

    setState(() {
      for (Map<String, dynamic> businessService
          in businessServiceNamesAndUnreadCounts['data']) {
        if (businessService['is_user_read'] != null) {
          _chatRoomCards.add(
            ChatRoomCard(
                avatarPath: '',
                unreadCount:
                    businessService['business_service_talks_is_not_read_count'],
                groupName: '${businessService['business_service_name']}',
                uuid: uuid,
                serviceName: businessService['business_service_name']),
          );
        }
      }

      for (Map<String, dynamic> businessService
          in businessServiceNamesAndUnreadCounts['data']) {
        if (businessService['is_user_read'] == null) {
          _chatRoomCards.add(
            ChatRoomCard(
              avatarPath: '',
              unreadCount: '0',
              groupName:
                  '${businessService['business_name']} ${businessService['business_service_name']}',
              uuid: uuid,
              serviceName: businessService['business_service_name'],
            ),
          );
        }
      }
    });
  }
}
