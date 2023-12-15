import 'package:ds304/pages/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:ds304/messages/GDs/GD.dart';
import 'package:ds304/pages/message.dart';
import 'package:ds304/user/more.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
    _pageController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _motionTabBarController?.index = index;
          });
        },
        children: const [
          HomeScreen(),
          Members(),
          Message(),
          MoreScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(100, 0, 0, 0), // Shadow color
              spreadRadius: 1.0,
              blurRadius: 5.0,
              offset: Offset(0, 3), // Changes the shadow position
            ),
          ],
        ),
        child: MotionTabBar(
          controller: _motionTabBarController,
          initialSelectedTab: "Home",
          labels: const ["Home", "Group Chat", "Messages", "More"],
          icons: const [
            Icons.home,
            Icons.chat,
            Icons.people_alt,
            Icons.dashboard,
          ],
          tabSize: 50,
          tabBarHeight: 55,
          textStyle: const TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          tabIconColor: const Color.fromARGB(255, 18, 85, 255),
          tabIconSize: 28.0,
          tabIconSelectedSize: 26.0,
          tabSelectedColor: Colors.blue[900],
          tabIconSelectedColor: Colors.white,
          tabBarColor: Colors.white,
          onTabItemSelected: (int value) {
            setState(() {
              _motionTabBarController?.index = value;
              _pageController?.jumpToPage(value);
            });
          },
        ),
      ),
    );
  }
}
