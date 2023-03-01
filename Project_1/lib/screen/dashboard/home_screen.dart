import 'package:career360/screen/dashboard/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'favorite_screen.dart';
import 'notification_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;
  List WidgetOption = [
    DashboardScreen(),
    FavoriteScreen(),
    NotificationScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WidgetOption.elementAt(currentTab),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              label: 'home',
              icon: currentTab == 0
                  ? Icon(Icons.home,
                      color: currentTab == 0 ? Colors.blue : Colors.black)
                  : Icon(CupertinoIcons.home,
                      color: currentTab == 0 ? Colors.blue : Colors.black)),
          BottomNavigationBarItem(
              label: 'favorite',
              icon: currentTab == 1
                  ? Icon(Icons.bookmark,
                      color: currentTab == 1 ? Colors.blue : Colors.black)
                  : Icon(Icons.bookmark_border,
                      color: currentTab == 1 ? Colors.blue : Colors.black)),
          BottomNavigationBarItem(
              label: 'notification',
              icon: currentTab == 2
                  ? Icon(Icons.notifications,
                      color: currentTab == 2 ? Colors.blue : Colors.black)
                  : Icon(Icons.notifications_none_outlined,
                      color: currentTab == 2 ? Colors.blue : Colors.black)),
          BottomNavigationBarItem(
              label: 'profile',
              icon: currentTab == 3
                  ? Icon(Icons.person,
                      color: currentTab == 3 ? Colors.blue : Colors.black)
                  : Icon(Icons.person_outline_outlined,
                      color: currentTab == 3 ? Colors.blue : Colors.black)),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: currentTab,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      currentTab = value;
    });
  }
}
