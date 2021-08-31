import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

bool hasRequested = false;

class Post extends StatefulWidget {
  final data;
  const Post(this.data);
  @override
  _PostState createState() => _PostState();
}

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
                  color: Color(0xff49BABA)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black),
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
              color: Colors.grey[900]),
        )
      ],
    ),
  );
}

Widget title(String title) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Text(
      title,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
    ),
  );
}

Widget description(String description) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Text(
      description,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
    ),
  );
}

Widget button (String text, BuildContext context, bool disable) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: ElevatedButton(
      onPressed: disable ? null : () {

      },
      child: Text(text, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),),
      style: ElevatedButton.styleFrom(
        primary: disable ? Colors.grey[300] : Color(0xff49BABA),
      ),
    ),
  );
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    for( var item in widget.data["requests"]) {
      if (item['userId'] == uid) {
        hasRequested = true;
        break;
      }
    }
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title(widget.data['title']),
              userProfile(widget.data['userImageUrl'], widget.data['userName']),
              rowInfo('Budget', 'INR ' + widget.data['budget']),
              rowInfo(
                  'Time Required', widget.data['timeRequired'].toString() + ' Hours'),
              rowInfo('Address', widget.data['address']),
              rowInfo(
                  'Category',
                  widget.data['category'].toString() +
                      ' (' +
                      widget.data['subCategory'].toString() +
                      ')'),
              Row(
                children: [
                  hasRequested ? button('Applied', context, true) : button('Apply', context, false),
                  button('View User Profile', context, false),
                ],
              ),
              description(widget.data['description']),
               hasRequested ? button('Applied', context, true) : button('Apply', context, false),
            ],
          ),
        ),
      ),
    );
  }
}
