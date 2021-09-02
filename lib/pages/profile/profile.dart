import 'package:flutter/material.dart';
import 'package:fiverr_clone/pages/profile/profile_about.dart';
import 'profile_orders.dart';

class ProfilePage extends StatefulWidget {
  final uid;
  final index;
  ProfilePage({this.uid, this.index});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.index,
      child: Scaffold(
        appBar: AppBar(
          title: Text("User Details"),
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
          children: <Widget>[
            AboutPage(uid: widget.uid.toString(),),
            Orders(uid: widget.uid.toString(),)
          ],
        ),
      ),
    );
  }
}
