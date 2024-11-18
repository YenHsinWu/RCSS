import "package:bao_register/pages/service_page.dart";
import "package:bao_register/pages/store_page.dart";
import "package:bao_register/pages/web_page.dart";
import "package:flutter/material.dart";

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

  final List<Widget> _pagesName = [
    Text("首頁"),
    Text("客服"),
    Text("網頁"),
    Text("商家"),
    Text("好友"),
    Text("設定"),
  ];

  final PageController _pageController = PageController();

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
            icon: Icon(Icons.home),
            label: "首頁",
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.electrical_services),
            label: "客服",
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.web),
            label: "網頁",
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: "商家",
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "好友",
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
          IndexPage(
            uuid: widget.uuid,
            userName: widget.userName,
          ),
          ServicePage(
            uuid: widget.uuid,
            userName: widget.userName,
          ),
          WebPage(),
          StorePage(
            uuid: widget.uuid,
            userName: widget.userName,
          ),
          FriendPage(),
          Center(
            child: Text("設定"),
          ),
        ],
      ),
    );
  }
}
