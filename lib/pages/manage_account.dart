import 'package:fiverr_clone/pages/main_tabs.dart';
import 'package:fiverr_clone/pages/privacy.dart';
import 'package:fiverr_clone/pages/user_details.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiverr_clone/pages/profile/profile.dart';

class ManageAccount extends StatefulWidget {
  @override
  _ManageAccountState createState() => _ManageAccountState();
}

final uid = FirebaseAuth.instance.currentUser.uid;
var data;

class _ManageAccountState extends State<ManageAccount> {
  Widget title(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, left: 20.0, bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget logout() {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: TextButton(
                onPressed: _signOut,
                child: Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget top(name, address, imageUrl) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              color: Colors.blueGrey[600],
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 40.0,
                            backgroundImage: NetworkImage(imageUrl),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      address,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget user(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          logout(),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('userId', isEqualTo: uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var imageUrl = snapshot.data.docs.first.get('imageUrl');
          var name = snapshot.data.docs.first.get('displayName');
          var address = snapshot.data.docs.first.get('address');
          var id = snapshot.data.docs.first.reference.id;
          return Column(
            children: <Widget>[
              top(name, address, imageUrl),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    title("Yaar Help"),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                      uid: id,
                                      index: 0,
                                    )));
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          color: Colors.blue[200],
                          size: 28,
                        ),
                        title: Text(
                          "My profile",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProfilePage(uid: id, index: 1)));
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.list_alt_rounded,
                          size: 25,
                          color: Colors.orange[700],
                        ),
                        title: Text(
                          "My Orders",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserDetails(true)));
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.edit,
                          size: 25,
                          color: Colors.blueGrey[300],
                        ),
                        title: Text(
                          "Edit profile",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    title("General"),
                    InkWell(
                      onTap: () {},
                      child: ListTile(
                        leading: Icon(Icons.support, color: Colors.green[400]),
                        title: Text(
                          "Support",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrivacyPolicy()));
                      },
                      child: ListTile(
                        leading: Icon(Icons.privacy_tip_outlined,
                            color: Colors.red[400]),
                        title: Text(
                          "Privacy Policy",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 60.0,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: TextButton(
                            onPressed: _signOut,
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void showdialogBox(String title, String subTitle, bool isError, Function fn) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(
          subTitle,
          style: isError
              ? TextStyle(color: Colors.red)
              : TextStyle(color: Colors.green),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => {Navigator.pop(context, 'OK'), fn()},
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void navigateToHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainTabs()));
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      this.showdialogBox(
          'Success', 'Signed out successfully', false, navigateToHome);
    } catch (e) {
      this.showdialogBox('Error', e.message, true, () {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return user(context);
  }
}
