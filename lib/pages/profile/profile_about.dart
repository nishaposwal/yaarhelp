import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiverr_clone/pages/user_details.dart';

class AboutPage extends StatefulWidget {
  final uid;
  AboutPage({this.uid});
  @override
  _AboutPageState createState() => _AboutPageState();
}

var userId = "";

class _AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      userId = currentUser.uid;
    }
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('userId', isEqualTo: widget.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data.docs.length == 0) {
          return Center(
            child: Text('Profile unavailable',style: TextStyle(color: Theme.of(context).accentColor, fontSize: 16),),
          );
        }
        var imageUrl = snapshot.data.docs.first.get('imageUrl');
        var name = snapshot.data.docs.first.get('displayName');
        var address = snapshot.data.docs.first.get('address');
        var description = snapshot.data.docs.first.get('description');
        var languages = snapshot.data.docs.first.get('languages');
        var phoneNumber = snapshot.data.docs.first.get('phoneNumber');
        var skills = snapshot.data.docs.first.get('skills');
        var joiningDate = snapshot.data.docs.first.get('joiningDate');
        return ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                title: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 10),
              child: Text(
                "User information",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.call_rounded),
              title: Text(
                "Phone Number",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              subtitle: Text(
                phoneNumber,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text(
                "From",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              subtitle: Text(
                address,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                "Member since",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              subtitle: Text(
                joiningDate,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 15.0),
              child: Text(
                "Languages",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.globeAsia),
              title: Text(
                languages,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(),
            ListTile(
              title: Text(
                "Description\n",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                description,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Divider(),
            ListTile(
              title: Text(
                "Skills\n",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                skills,
                style: TextStyle(color: Colors.grey[900]),
              ),
            ),
            Divider(),
            widget.uid == userId ? Container(
              width: 50,
              margin: EdgeInsets.only(bottom: 0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => UserDetails()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).accentColor,
                  onSurface: Colors.blue,
                ),
              ),
            ) : SizedBox(height: 0,)
          ],
        );
      },
    );
  }
}
