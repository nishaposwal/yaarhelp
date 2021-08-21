import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String currencyDropdownValue = "\$ USD";
  bool isOut = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Container(
                alignment: Alignment.centerLeft,
                height: 60.0,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Terms of Service",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Container(
                alignment: Alignment.centerLeft,
                height: 60.0,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Privacy policy",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.centerLeft,
              height: 60.0,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
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
        ],
      ),
    );
  }
}
