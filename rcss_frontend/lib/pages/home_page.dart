import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/material.dart";
import "package:rcss_frontend/pages/group_page.dart";
import "package:rcss_frontend/pages/service_page.dart";
import "package:rcss_frontend/pages/store_page.dart";
import "package:rcss_frontend/pages/web_page.dart";
import "package:rcss_frontend/service_implementation/index_service.dart";

import "friend_page.dart";
import "index_page.dart";

class HomePage extends StatefulWidget {
  final String uuid;
  final String userName;

  const HomePage({super.key, required this.uuid, required this.userName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final IndexService _indexService = IndexService();
  final List<String> _bottomMenuUnreadCount = [];

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final List<Widget> _pagesName = [
    Text("商家"),
    Text("客服"),
    Text("好友"),
    Text("群組"),
    Text("網頁"),
    Text("捷徑"),
    Text("設定"),
  ];

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _getBottomMenuUnreadCount();

    _firebaseMessaging.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('收到訊息：${message.notification?.title}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('從通知啟動APP：${message.notification?.title}');
    });

    _firebaseMessaging.getToken().then((token) {
      print('FCM token: ${token}');
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      print(widget.uuid);
    });
    _pageController.jumpToPage(_currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _pagesName[_currentIndex],
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: badges.Badge(
              badgeContent: Text(
                _bottomMenuUnreadCount[0],
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              badgeStyle: BadgeStyle(badgeColor: Colors.white),
              showBadge: _bottomMenuUnreadCount[0] != '0',
              child: Icon(Icons.shop),
            ),
            label: "商家",
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: badges.Badge(
              badgeContent: Text(
                _bottomMenuUnreadCount[1],
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              badgeStyle: BadgeStyle(badgeColor: Colors.white),
              showBadge: _bottomMenuUnreadCount[1] != '0',
              child: Icon(Icons.electrical_services),
            ),
            label: "客服",
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: badges.Badge(
              badgeContent: Text(
                _bottomMenuUnreadCount[2],
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              badgeStyle: BadgeStyle(badgeColor: Colors.white),
              showBadge: _bottomMenuUnreadCount[2] != '0',
              child: Icon(Icons.person),
            ),
            label: "好友",
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: badges.Badge(
              badgeContent: Text(
                _bottomMenuUnreadCount[3],
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              badgeStyle: BadgeStyle(badgeColor: Colors.white),
              showBadge: _bottomMenuUnreadCount[3] != '0',
              child: Icon(Icons.people),
            ),
            label: "群組",
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: badges.Badge(
              badgeContent: Text(
                _bottomMenuUnreadCount[4],
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              badgeStyle: BadgeStyle(badgeColor: Colors.white),
              showBadge: _bottomMenuUnreadCount[4] != '0',
              child: Icon(Icons.web),
            ),
            label: "網頁",
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "捷徑",
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "設定",
            backgroundColor: Colors.red,
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          StorePage(
            uuid: widget.uuid,
            userName: widget.userName,
          ),
          ServicePage(
            uuid: widget.uuid,
            userName: widget.userName,
          ),
          FriendPage(),
          GroupPage(),
          WebPage(),
          IndexPage(
            uuid: widget.uuid,
            userName: widget.userName,
          ),
          Center(
            child: Text("設定"),
          ),
        ],
      ),
    );
  }

  void _getBottomMenuUnreadCount() async {
    List<dynamic> iconTypeAndUnreadCount =
        await _indexService.getBottomMenuTypeAndCount(widget.uuid);

    setState(() {
      for (Map<String, dynamic> data in iconTypeAndUnreadCount) {
        _bottomMenuUnreadCount.add(data['data_count'].toString());
      }
    });
  }
}
