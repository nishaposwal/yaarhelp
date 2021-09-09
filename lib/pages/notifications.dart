import 'package:yaarhelp/pages/post.dart';
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

Widget showBody(BuildContext context, currentUser, height) {
  return TabBarView(
    children: [
      employerNotifications(context, currentUser, height),
      helperNotifications(context, currentUser, height)
    ],
  );
}

Widget helperNotifications(BuildContext context, currentUser, height) {
  if (currentUser == null) {
    return noNotifications(context);
  }
  double width = MediaQuery.of(context).size.width*0.7;
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('gigs')
            .where('helper', isEqualTo: currentUser.uid)
            .where('helper', isNull: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                height: height * 0.7, child: noNotifications(context));
          }
          return Column(
            children: [
              for (DocumentSnapshot doc in snapshot.data.docs)
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Post(
                              data: doc.data() as Map<String, dynamic>,
                              id: doc.reference.id),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                      child: Card(
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.08, vertical: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: width * 0.08),
                                child: Icon(Icons.star, color: Colors.yellow[700],),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Container(
                                    width: width,
                                    child: Text(
                                        'Congratulation! You are selected for a Gig.',),
                                  ),
                                ),
                                 OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Post(
                                            data: doc.data() as Map<String, dynamic>,
                                            id: doc.reference.id),
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        width: 2, color: Theme.of(context).accentColor),
                                  ),
                                  child: Text(
                                    'View',
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Lato',
                                        fontSize: 16),
                                  ),
                                ),
                              ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
            ],
          );
        },
      ),
    ),
  );
}

Widget employerNotifications(BuildContext context, currentUser, height) {
  if (currentUser == null) {
    return noNotifications(context);
  }
  var requests = [];
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('gigs')
            .where('userId', isEqualTo: currentUser.uid)
            .where('helper', isNull: true)
            .orderBy('timeStamp', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                height: height * 0.7, child: noNotifications(context));
          }
          requests = [];
          for (DocumentSnapshot doc in snapshot.data.docs) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
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
                height: height * 0.7, child: noNotifications(context));
          }

          print(requests);
          return Column(
            children: [
              for (var item in requests)
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePage(
                                  uid: item['userId'],
                                )));
                  },
                  child:
                      Gig(gig: item, id: item['gigId'], source: 'notification'),
                )
            ],
          );
        },
      ),
    ),
  );
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Notifications",
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Rowdies',
                fontSize: 24),
          ),
          bottom: TabBar(
              labelColor: Theme.of(context).accentColor,
              unselectedLabelColor: Colors.black,
              tabs: [Tab(text: 'Requests'), Tab(text: 'Good News')]),
        ),
        body: showBody(context, currentUser, height),
      ),
    );
  }
}
