import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Gig extends StatefulWidget {
  // const Gig({ Key? key }) : super(key: key);

  Map<String, dynamic> gig;
  String id;

  Gig({this.gig, this.id});

  @override
  _GigState createState() => _GigState();
}

void viewGigDetail() {

}

void apply(data, id) {
  var currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    var userData = {
      'userId': currentUser.uid,
      'userName': currentUser.displayName,
      'userImageUrl': currentUser.photoURL
    };
    var requests = data['requests'] == null ? [] : data['requests'];
    FirebaseFirestore.instance.collection('gigs').doc(id).update({
      'requests': FieldValue.arrayUnion([userData])
    });
  }
}

Widget actions(BuildContext context, data, id) {
  return Row(
    children: [
      FlatButton(
        color: Theme.of(context).accentColor,
        onPressed: () => apply(data, id),
        child: Text(
          'Apply',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      OutlineButton(
        onPressed: () => viewGigDetail(),
        color: Theme.of(context).accentColor,
        // textTheme: OutlinedButtonTheme.of(context).style
        child: Text(
          'View Details',
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold),
        ),
      )
    ],
  );
}

Widget budget(String budget, BuildContext context) {
  return Container(
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      border: Border.all(
        color: Theme.of(context).accentColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      budget,
      style: TextStyle(color: Theme.of(context).accentColor),
    ),
  );
}

class _GigState extends State<Gig> {
  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width*0.8;
    if (widget.gig['title'] == null)
      return SizedBox(height: 0,);
    return Card(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.gig['userImageUrl']),
              radius: 35
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: c_width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.gig['userName'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(widget.gig['postedOn']),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    width: c_width,
                    child: Text(
                      widget.gig['title'],
                      style: TextStyle(
                        color: Colors.blueGrey[800],
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  budget('₹ ' + widget.gig['budget'], context),
                  SizedBox(
                    height: 4,
                  ),
                  actions(context, widget.gig, widget.id),
                ],
              ),
            ),
          ]),
        ),
      );
  }
}
