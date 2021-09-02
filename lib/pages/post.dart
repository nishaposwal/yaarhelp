import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiverr_clone/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'gig.dart';

class Post extends StatefulWidget {
  final Map<String, dynamic> data;
  final String id;

  Post({this.data, this.id});
  @override
  _PostState createState() => _PostState();
}

bool hasRequested = false;
bool hasApplied = false;

Widget rowInfo(String title, String value) {
  return Table(
    children: [
      TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xff49BABA),
                  fontFamily: 'Lato'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black,
                  fontFamily: 'Lato'),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget userProfile(String imageUrl, String userName) {
  return Container(
    margin: EdgeInsets.all(12.0),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
        Text(
          userName,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[900],
              fontFamily: 'Lato'),
        )
      ],
    ),
  );
}

Widget title(String title, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          child: Icon(Icons.arrow_back_outlined),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}

Widget description(String description) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Text(
      description,
      textAlign: TextAlign.start,
      style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Roboto'),
    ),
  );
}

Widget button(String text, BuildContext context, bool disable, widget) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: OutlinedButton(
      onPressed: disable ? null : () async {
        if (text == "Apply") {
          try {
            await new Gig().apply(widget.data, widget.id);
            print(widget);
            widget.setState(() {
              hasRequested = true;
              hasApplied = true;
            });
          } catch (e) {
            print('Error in applying for gig :: ' + widget.id + e);
          }
        } else if (text == "View User Profile") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(uid: widget.data['userId'],),
            ),
          );
        }
      },
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 15, fontFamily: 'Lato', color: Colors.white),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: disable ? Colors.grey[400] : Color(0xff49BABA),
      ),
    ),
  );
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      hasRequested = false;
    });
    var uid = FirebaseAuth.instance.currentUser?.uid;
    if (widget.data["requests"] != null && !hasApplied) {
      for (var item in widget.data["requests"]) {
        if (item['userId'] == uid) {
          setState(() {
            hasRequested = true;
          });
          break;
        }
      }
    }
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title(widget.data['title'], context),
              userProfile(widget.data['userImageUrl'], widget.data['userName']),
              rowInfo('Budget', 'INR ' + widget.data['budget']),
              rowInfo('Time Required',
                  widget.data['timeRequired'].toString() + ' Hours'),
              rowInfo('Address', widget.data['address']),
              rowInfo(
                  'Category',
                  widget.data['category'].toString() +
                      ' (' +
                      widget.data['subCategory'].toString() +
                      ')'),
              Row(
                children: [
                  hasRequested
                      ? button('Applied', context, true, widget)
                      : button('Apply', context, false, widget),
                  button('View User Profile', context, false, widget),
                ],
              ),
              description(widget.data['description']),
              hasRequested
                  ? button('Applied', context, true, widget)
                  : button('Apply', context, false, widget),
            ],
          ),
        ),
      ),
    );
  }
}
