import 'package:flutter/material.dart';
import 'package:fiverr_clone/pages/profile/profile_about.dart';
import 'package:fiverr_clone/pages/profile/profile_gigs.dart';
import 'package:fiverr_clone/pages/profile/profile_reviews.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Madan Mohan"),
          bottom: TabBar(
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: Colors.grey,
            tabs: <Widget>[
              Tab(
                text: "ABOUT",
              ),
              Tab(
                text: "ORDERS",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[AboutPage(), GigsPage()],
        ),
      ),
    );
  }
}
