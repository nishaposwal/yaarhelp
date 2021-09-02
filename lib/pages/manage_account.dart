import 'package:fiverr_clone/pages/main_tabs.dart';
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
  Widget user(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          InkWell(
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
          ),
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
              Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        color: Colors.blueGrey[800],
                        height: 200.0,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, bottom: 40.0),
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
                                      child: CircleAvatar(
                                        child: Image(
                                            image: NetworkImage(imageUrl),
                                            fit: BoxFit.scaleDown),
                                      ),
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
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 20.0, bottom: 5.0),
                      child: Text(
                        "Yaar Help",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage(uid: id,)));
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
                      onTap: () {},
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
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 20.0, bottom: 5.0),
                      child: Text(
                        "General",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
                      onTap: () {},
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
          'Success', 'Sign out successFully', false, navigateToHome);
    } catch (e) {
      this.showdialogBox('Error', e.message, true, () {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return user(context);
  }
}
