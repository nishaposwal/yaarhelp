import 'package:yaarhelp/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'gig.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

Widget noNotifications(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.notifications_none_outlined,
            color: Theme.of(context).accentColor,
            size: 28,
          ),
        ),
        Text(
          'No Notifications',
          style: TextStyle(
              fontFamily: 'Roboto',
              color: Theme.of(context).accentColor,
              fontSize: 16),
        ),
      ],
    ),
  );
}

class _NotificationsState extends State<Notifications> {
  var requests = [];
  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: currentUser == null
          ? noNotifications(context)
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('gigs')
                      .where('userId', isEqualTo: currentUser.uid)
                      .where('helper', isNull: true)
                      .orderBy('timeStamp', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Something went wrong'));
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
                    if (snapshot.data.docs.length == 0) {
                      return SizedBox(
                          height: height * 0.7,
                          child: noNotifications(context));
                    }
                    requests = [];
                    for (DocumentSnapshot doc in snapshot.data.docs) {
                      Map<String, dynamic> data =
                          doc.data() as Map<String, dynamic>;
                      var id = doc.reference.id;
                      var reqs = data['requests'];
                      if (reqs == null) {
                        reqs = [];
                      }
                      for (var item in reqs) {
                        item['gigId'] = id;
                        item['title'] = data['title'];
                        requests.add(item);
                      }
                    }

                    if (requests.length == 0) {
                      return SizedBox(
                          height: height * 0.7,
                          child: noNotifications(context));
                    }

                    return Column(
                      children: [
                        for (var item in requests)
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(uid: item['userId'],)
                              )
                              );
                            },
                            child: Gig(
                                gig: item,
                                id: item['gigId'],
                                source: 'notification'),
                          )
                      ],
                    );
                  },
                ),
              ),
            ),
    );
  }
}
