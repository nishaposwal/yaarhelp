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
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class MainTabs extends StatefulWidget {
  @override
  _MainTabsState createState() => _MainTabsState();
  int catInExplore;
  int selectedIndex;
  MainTabs({this.selectedIndex, this.catInExplore});
}

class _MainTabsState extends State<MainTabs>
    with SingleTickerProviderStateMixin {
  int _selectedIndexForBottomNavigationBar;
  bool _profileCompleted = false;
  int catInExplore;

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
                    setState(() {
                      _profileCompleted = true;
                    })
                  }
              });
    }
    super.initState();
    _selectedIndexForBottomNavigationBar =
        widget.selectedIndex != null ? widget.selectedIndex : 0;
    catInExplore = widget.catInExplore != null ? widget.catInExplore : 0;
    _listOfPagesForBottomNavigationBar[1] = ExplorePage(
      currentMode: catInExplore,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onItemTappedForBottomNavigationBar(int index) {
    setState(() {
      _selectedIndexForBottomNavigationBar = index;
    });
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((value) => {
                if (value.data() != null)
                  {
                    setState(() {
                      _profileCompleted = true;
                    })
                  }
              });
    }
  }

  List<Widget> _listOfPagesForBottomNavigationBar = <Widget>[
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
      bottomNavigationBar: TitledBottomNavigationBar(
          // type: BottomNavigationBarType.fixed,
          onTap: _onItemTappedForBottomNavigationBar,
          // this will be set when a new tab is tapped
          items: [
            TitledNavigationBarItem(
              icon: Icons.home,
              title: Icon(
                Icons.home,
                color: Theme.of(context).accentColor,
              ),
            ),
            TitledNavigationBarItem(
              icon: Icons.explore,
              title: Icon(
                Icons.explore,
                color: Theme.of(context).accentColor,
              ),
            ),
            TitledNavigationBarItem(
              icon: Icons.add_box_rounded,
              title: Icon(
                Icons.add_box_rounded,
                color: Theme.of(context).accentColor,
              ),
            ),
            TitledNavigationBarItem(
              icon: Icons.notifications_active_rounded,
              title: Icon(
                Icons.notifications_active_rounded,
                color: Theme.of(context).accentColor,
              ),
            ),
            TitledNavigationBarItem(
              icon: Icons.person,
              title: Icon(
                Icons.person,
                color: Theme.of(context).accentColor,
              ),
            ),
          ],
          currentIndex: _selectedIndexForBottomNavigationBar,
          inactiveColor: Colors.grey[700],
          reverse: true),
    );
  }
}
