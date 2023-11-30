import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  //Screens
  List<Widget> pages = [
    // HomeScreen(),
    // MemberScreen(),
    // MessageScreen(),
    // NotificationScreen(),
    // MoreScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: GNav(
        onTabChange: updatePage,
        tabs: [
          GButton(
            onPressed: () {
              _page = 0;
              // setState(() {});
            },
            rippleColor: Colors.white10,
            icon: Icons.home,
            iconColor: Colors.white,
            text: ' Home',
            textColor: Colors.white,
            iconActiveColor: Colors.white,
          ),
          GButton(
            onPressed: () {
              _page = 1;
              // setState(() {});
            },
            rippleColor: Colors.white10,
            icon: Icons.home,
            iconColor: Colors.white,
            text: ' Members',
            textColor: Colors.white,
            iconActiveColor: Colors.white,
          ),
          GButton(
            onPressed: () {
              _page = 2;
              // setState(() {});
            },
            icon: Icons.chat,
            rippleColor: Colors.white10,
            iconColor: Colors.white,
            text: ' Messages',
            textColor: Colors.white,
            iconActiveColor: Colors.white,
          ),
          GButton(
            onPressed: () {
              _page = 3;
              // setState(() {});
            },
            rippleColor: Colors.white10,
            icon: Icons.history,
            iconColor: Colors.white,
            text: ' Notifications',
            textColor: Colors.white,
            iconActiveColor: Colors.white,
          ),
          GButton(
            onPressed: () {
              _page = 4;
              // setState(() {});
            },
            rippleColor: Colors.white10,
            icon: Icons.person,
            iconColor: Colors.white,
            text: ' More',
            textColor: Colors.white,
            iconActiveColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
