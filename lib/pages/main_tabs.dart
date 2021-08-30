import 'package:fiverr_clone/pages/create-post.dart';
import 'package:flutter/material.dart';

import 'package:fiverr_clone/pages/home.dart';
import 'package:fiverr_clone/pages/manage_account.dart';
import 'package:fiverr_clone/pages/explore.dart';
import 'package:fiverr_clone/pages/notifications.dart';

class MainTabs extends StatefulWidget {
  @override
  _MainTabsState createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs>
    with SingleTickerProviderStateMixin {
  TabController controller;
  int _selectedIndexForBottomNavigationBar;

  @override
  void initState() {
    super.initState();
    _selectedIndexForBottomNavigationBar = 0;
    controller = TabController(
        vsync: this,
        length: _listOfPagesForBottomNavigationBar.length,
        initialIndex: 1);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void _onItemTappedForBottomNavigationBar(int index) {
    setState(() {
      _selectedIndexForBottomNavigationBar = index;
    });
  }

  static List<Widget> _listOfPagesForBottomNavigationBar = <Widget>[
    HomePage(),
    ExplorePage(),
    CreatePost(),
    Notifications(),
    ManageAccount(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listOfPagesForBottomNavigationBar[
          _selectedIndexForBottomNavigationBar],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTappedForBottomNavigationBar,
        // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 35,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.explore,
                size: 35,
              ),
              label: 'Messages'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box_rounded,
                size: 35,
              ),
              label: 'Sales'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications_rounded,
                size: 35,
              ),
              label: 'Notifications'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 38,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndexForBottomNavigationBar,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.grey[700],
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
