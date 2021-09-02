import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiverr_clone/pages/gig.dart';

class Orders extends StatefulWidget {
  final uid;
  Orders({this.uid});

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('gigs')
            .where('userId', isEqualTo: widget.uid)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
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
          if (snapshot.data.docs.length == 0) {
            return Center(
              child: Text('No orders',style: TextStyle(color: Theme.of(context).accentColor, fontSize: 16),),
            );
          }
          return Column(
            children: [
              for (DocumentSnapshot doc in snapshot.data.docs)
                Gig(
                  gig: doc.data() as Map<String, dynamic>,
                  id: doc.reference.id,
                  source: 'explore',
                )
            ],
          );
        },
      ),
    );
  }
}
