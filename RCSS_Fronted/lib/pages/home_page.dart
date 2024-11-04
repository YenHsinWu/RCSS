import "package:bao_register/pages/chat_room_page.dart";
import "package:bao_register/pages/service_page.dart";
import "package:bao_register/pages/store_page.dart";
import "package:bao_register/pages/web_page.dart";
import "package:flutter/material.dart";

class HomePage extends StatefulWidget {
  final String uuid;
  const HomePage({super.key, required this.uuid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pagesName = [
    Text("聊天"),
    Text("客服"),
    Text("網頁"),
    Text("商家"),
    Text("設定"),
  ];

  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
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
            icon: Icon(Icons.chat),
            label: "聊天",
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
            icon: Icon(Icons.person),
            label: "商家",
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
          ChatRoomPage(
            uuid: widget.uuid,
            businessId: '0',
          ),
          ServicePage(
            uuid: widget.uuid,
          ),
          WebPage(),
          StorePage(uuid: widget.uuid),
          Center(
            child: Text("設定"),
          ),
        ],
      ),
    );
  }
}
