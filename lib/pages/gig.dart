import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'post.dart';

class Gig extends StatefulWidget {
  // const Gig({ Key? key }) : super(key: key);
  Future<void> apply(data, id) {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      var userData = {
        'userId': currentUser.uid,
        'userName': currentUser.displayName,
        'userImageUrl': currentUser.photoURL
      };
      List<dynamic> requests = data['requests'] == null ? [] : data['requests'];
    requests.add(userData);
    FirebaseFirestore.instance
        .collection('gigs')
        .doc(id)
        .update({'requests': requests});
  }
  }

  Map<String, dynamic> gig;
  String id;
  String source;

  Gig({this.gig, this.id, this.source});

  @override
  _GigState createState() => _GigState();
}

void viewGigDetail(BuildContext context, Map<String, dynamic> data, String id) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => new Post(data: data, id: id),
    ),
  );
}

Widget actions(BuildContext context, data, id, source, widget) {
  var currentUser = FirebaseAuth.instance.currentUser;
  bool applied = false;

  if (currentUser != null) {
    List<dynamic> requests = data['requests'] == null ? [] : data['requests'];
    for (var item in requests) {
      if (item['userId'] == currentUser.uid) {
        applied = true;
      }
    }
  }

  var disableActions = (source == "explore" && applied) || (source == "notification" && data['helper'] != null);

  return Row(
    children: [
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor:
              disableActions ? Colors.grey[400] : Theme.of(context).accentColor,
        ),
        onPressed: disableActions ? null : () async => {await widget.apply(data, id)},
        child: Text(
          source == "explore"
              ? applied
                  ? 'Applied'
                  : 'Apply'
              : 'Accept',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Lato',
              fontSize: 16),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      OutlinedButton(
        onPressed: () => disableActions &&   source != "explore" ? null : viewGigDetail(context, data, id),
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: 2, color: Theme.of(context).accentColor),
        ),
        child: Text(
          source == 'explore' ? 'View Details' : 'Reject',
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato',
              fontSize: 16),
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
        width: 1,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      budget,
      style: TextStyle(
          color: Theme.of(context).accentColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          fontFamily: 'Lato'),
    ),
  );
}

class _GigState extends State<Gig> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.8;
    if (widget.gig['title'] == null)
      return SizedBox(
        height: 0,
      );
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CircleAvatar(
              backgroundImage: NetworkImage(widget.gig['userImageUrl']),
              radius: 30),
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
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Lato'),
                      ),
                      Text(
                        widget.gig['postedOn'],
                        style: TextStyle(fontFamily: 'Lato'),
                      ),
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
                        color: Colors.blueGrey[900],
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Lato'),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                widget.source == "explore"
                    ? budget('₹ ' + widget.gig['budget'], context)
                    : SizedBox(
                        height: 0,
                      ),
                SizedBox(
                  height: 4,
                ),
                actions(context, widget.gig, widget.id, widget.source, widget),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
