import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiverr_clone/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'post.dart';
import 'package:intl/intl.dart';

class Gig extends StatefulWidget {
  Future<void> apply(data, id) {
    final now = new DateTime.now();
    String formattedDate = DateFormat.yMMMMd('en_US').format(now);

    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      var userData = {
        'userId': currentUser.uid,
        'userName': currentUser.displayName,
        'userImageUrl': currentUser.photoURL,
        'postedOn': formattedDate,
        'timeStamp': new DateTime.now().microsecondsSinceEpoch,
      };
      List<dynamic> requests = data['requests'];
      if (requests == null) {
        requests = [];
      }
      requests.add(userData);

      return FirebaseFirestore.instance
          .collection('gigs')
          .doc(id)
          .update({'requests': requests});
    }
    return null;
  }

  final Map<String, dynamic> gig;
  final String id;
  final String source;
  final String subsource;

  Gig({this.gig, this.id, this.source, this.subsource});

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

void reject(data, id) {
  FirebaseFirestore.instance
      .collection('gigs')
      .doc(id)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      Map<String, dynamic> gig = documentSnapshot.data();
      List<dynamic> requests = gig['requests'];
      if (requests == null) {
        requests = [];
      }
      if (requests.length == 0) {
        return null;
      }
      List<dynamic> reqs = [];
      for (var item in requests) {
        if (data['userId'] != item['userId']) {
          reqs.add(item);
        }
      }
      FirebaseFirestore.instance
          .collection('gigs')
          .doc(id)
          .update({'requests': reqs});
    }
  });
}

Future<void> accept(data, id) {
  return FirebaseFirestore.instance
      .collection('gigs')
      .doc(id)
      .update({'helper': data['userId']});
}

void viewHelper(BuildContext context, helperUid) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProfilePage(
        uid: helperUid,
        index: 0,
      ),
    ),
  );
}

Widget actions(BuildContext context, data, id, source, widget) {
  var currentUser = FirebaseAuth.instance.currentUser;
  bool applied = false;

  if (currentUser != null && source == "explore") {
    List<dynamic> requests = data['requests'];
    if (requests == null) {
      requests = [];
    }
    for (var item in requests) {
      if (item['userId'] == currentUser.uid) {
        applied = true;
      }
    }
  }

  var disableApply = (source == "explore" && applied);

  var helperAssigned = (source == "explore" && data['helper'] != null);

  return Row(
    children: [
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: disableApply && !helperAssigned
              ? Colors.grey[400]
              : Theme.of(context).accentColor,
        ),
        onPressed: disableApply && !helperAssigned
            ? null
            : () async => {
                  (source == 'explore')
                      ? (helperAssigned
                          ? viewHelper(context, data['helper'])
                          : await widget.apply(data, id))
                      : await accept(data, id)
                },
        child: Text(
          (source == "explore")
              ? helperAssigned
                  ? ('Helper')
                  : (applied ? 'Applied' : 'Apply')
              : ('Accept'),
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
        onPressed: () => (source == 'explore')
            ? viewGigDetail(context, data, id)
            : reject(data, id),
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: 2, color: Theme.of(context).accentColor),
        ),
        child: Text(
          (source == 'explore') ? 'Gig' : 'Reject',
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
    double cWidth = MediaQuery.of(context).size.width * 0.8;
    if (widget.subsource == "home" && widget.gig['title'].length >= 30) {
      widget.gig['title'] = widget.gig['title'].substring(0, 30) + '...';
    }
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
                  width: cWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.gig['userName'],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
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
                  width: cWidth,
                  child: Text(
                    widget.gig['title'],
                    style: TextStyle(
                        color: Colors.blueGrey[900],
                        fontSize: 12,
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
