import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

var data = [
  {
    "address": "Noida, india",
    "budget": "3600",
    "category": "Online Help",
    "title":
        "Want help in home made scrunchies. Want help in home made scrunchiesWant help in home made",
    "description":
        "Want help in home made scrunchies. Want help in home made scrunchies. Want help in home made scrunchies. Want help in home made scrunchies. Want help in home made scrunchies. Want help in home made scrunchies. Want help in home made scrunchies. Want help in home made scrunchies. Want help in home made scrunchies. Want help in home made scrunchies. Want help in home made scrunchies. Want help in home made scrunchies. ",
    "subCategory": "Art & Design Help",
    "timeRequired": "23",
    "timestamp": 1629959516109,
    "userId": "uWeCin037XWpA3PPRcYiUZum2so2",
    "userImageUrl":
        "https://firebasestorage.googleapis.com/v0/b/yaarhelp-479bd.appspot.com/o/Profile_Pics%2FuWeCin037XWpA3PPRcYiUZum2so2%2Fimage_picker117262331307007787.png?alt=media&token=100885ee-802c-466a-b092-801647f1d0fd",
    "userName": "Simran 23",
    "requestsToWork": ["123", "234"],
    "requests": 0
  }
];
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

Widget button (String text, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: ElevatedButton(
      onPressed: () {

      },
      child: Text(text, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),),
      style: ElevatedButton.styleFrom(
        primary: Color(0xff49BABA),
      ),
    ),
  );
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    for( var i in data[0]["requestsToWork"]) {
      if (i == uid) {
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
              title(data[0]['title']),
              userProfile(data[0]['userImageUrl'], data[0]['userName']),
              rowInfo('Budget', 'INR ' + data[0]['budget']),
              rowInfo(
                  'Time Required', data[0]['timeRequired'].toString() + ' Hours'),
              rowInfo('Address', data[0]['address']),
              rowInfo(
                  'Category',
                  data[0]['category'].toString() +
                      ' (' +
                      data[0]['subCategory'].toString() +
                      ')'),
              Row(
                children: [
                  button('Request To Work', context),
                  button('View User Profile', context),
                ],
              ),
              description(data[0]['description']),
               hasRequested ? button('Requested To Work', context) : button('Request To Work', context),
            ],
          ),
        ),
      ),
    );
  }
}
