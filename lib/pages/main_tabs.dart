import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yaarhelp/pages/create-post.dart';
import 'package:yaarhelp/pages/user_details.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yaarhelp/pages/home.dart';
import 'package:yaarhelp/pages/manage_account.dart';
import 'package:yaarhelp/pages/explore.dart';
import 'package:yaarhelp/pages/notifications.dart';
import 'loginPage.dart';

class MainTabs extends StatefulWidget {
  @override
  _MainTabsState createState() => _MainTabsState();

  int selectedIndex;
  MainTabs({this.selectedIndex});
}

class _MainTabsState extends State<MainTabs>
    with SingleTickerProviderStateMixin {
  TabController controller;
  int _selectedIndexForBottomNavigationBar;
  bool _profileCompleted = false;

  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((value) => {
                if (value.data() != null)
                  {
                    _profileCompleted = true,
                  }
              });
    }
    super.initState();
    _selectedIndexForBottomNavigationBar =
        widget.selectedIndex != null ? widget.selectedIndex : 0;
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
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null &&
        (_selectedIndexForBottomNavigationBar == 2 ||
            _selectedIndexForBottomNavigationBar == 4)) {
      return LoginPage();
    } else if (currentUser != null &&
        !_profileCompleted &&
        (_selectedIndexForBottomNavigationBar == 2 ||
            _selectedIndexForBottomNavigationBar == 4)) {
      return UserDetails(false);
    }
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
