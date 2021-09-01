import 'package:flutter/material.dart';
import 'package:fiverr_clone/pages/profile/profile_about.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiverr_clone/pages/gig.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
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
          children: <Widget>[AboutPage(),  Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('gigs').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    padding: EdgeInsets.all(100),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  );
                }
                return Column(
                  children: [
                    for (DocumentSnapshot doc in snapshot.data.docs)
                      Gig(gig: doc.data() as Map<String, dynamic>, id: doc.reference.id, source: 'explore',)
                  ],
                );
              },
            ),
          )],
        ),
      ),
    );
  }
}
