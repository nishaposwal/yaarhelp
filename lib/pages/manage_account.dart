import 'package:flutter/material.dart';

import 'package:fiverr_clone/pages/earnings.dart';
import 'package:fiverr_clone/pages/settings.dart';
import 'package:fiverr_clone/pages/profile/profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ManageAccount extends StatefulWidget {
  @override
  _ManageAccountState createState() => _ManageAccountState();
}

class _ManageAccountState extends State<ManageAccount> {
  bool isSeller = true;
  bool isOnline = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.cog,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    color: Color(0xFF313131),
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
                                  backgroundImage: AssetImage(
                                      "assets/images/nouser.jpeg"),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Madan Mohan",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "My personal balance: ₹3336.90",
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
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20.0, bottom: 5.0),
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
                        builder: (context) => EarningsPage(),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Text(' \u{20B9}', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28, color: Colors.blue[500]),),
                    title: Text(
                      "Earnings",
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
                    leading: Icon(Icons.list_alt_rounded, size: 28, color: Colors.orange[700],),
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
                  onTap: () {},
                  child: ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.green, size: 28),
                    title: Text(
                      "Completed Orders",
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
                    leading: Icon(Icons.pending_actions, size: 25, color: Colors.yellow[800],),
                    title: Text(
                      "Pending Orders",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20.0, bottom: 5.0),
                  child: Text(
                    "General",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.user),
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
                    leading: Icon(FontAwesomeIcons.circleNotch),
                    title: Text(
                      "Online status",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Switch(
                      value: isOnline,
                      onChanged: (value) {
                        setState(() {
                          isOnline = value;
                        });
                      },
                      activeTrackColor: Color(0xFF8bd9ad),
                      activeColor: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.paperPlane),
                    title: Text(
                      "Invite friends",
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
                    leading: Icon(FontAwesomeIcons.lifeRing),
                    title: Text(
                      "Support",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
