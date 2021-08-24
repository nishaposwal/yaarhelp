import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiverr_clone/pages/user_details.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

final uid = FirebaseAuth.instance.currentUser.uid;

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
        print(imageUrl);
        var name = snapshot.data.docs.first.get('displayName');
        var address = snapshot.data.docs.first.get('address');
        var description = snapshot.data.docs.first.get('description');
        var languages = snapshot.data.docs.first.get('languages');
        var phoneNumber = snapshot.data.docs.first.get('phoneNumber');
        var skills = snapshot.data.docs.first.get('skills');
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
              leading: Icon(Icons.call),
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
                "Jul 2018",
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
              // subtitle: Flex(
              //   direction: Axis.horizontal,
              //   children: <Widget>[
              //     Padding(
              //       padding: const EdgeInsets.only(right: 8.0),
              //       child: InkWell(
              //         onTap: () {},
              //         child: Container(
              //           height: 35.0,
              //           decoration: BoxDecoration(
              //             color: Colors.black12,
              //             borderRadius: BorderRadius.all(
              //               Radius.circular(20.0),
              //             ),
              //           ),
              //           child: Padding(
              //             padding:
              //                 const EdgeInsets.only(left: 10.0, right: 10.0),
              //             child: Center(
              //               child: Text(
              //                 "Interior Designing",
              //                 style: TextStyle(color: Colors.black),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(right: 8.0),
              //       child: InkWell(
              //         onTap: () {},
              //         child: Container(
              //           height: 35.0,
              //           decoration: BoxDecoration(
              //             color: Colors.black12,
              //             borderRadius: BorderRadius.all(
              //               Radius.circular(20.0),
              //             ),
              //           ),
              //           child: Padding(
              //             padding:
              //                 const EdgeInsets.only(left: 10.0, right: 10.0),
              //             child: Center(
              //               child: Text(
              //                 "Modular Kitchen",
              //                 style: TextStyle(color: Colors.black),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ),
            Divider(),
            Container(
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
            )
          ],
        );
      },
    );
  }
}
