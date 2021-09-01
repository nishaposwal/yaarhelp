import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'gig.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('gigs').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    Gig(
                      gig: doc.data() as Map<String, dynamic>,
                      id: doc.reference.id,
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
