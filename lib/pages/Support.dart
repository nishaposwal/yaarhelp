import 'package:flutter/material.dart';

class Support extends StatefulWidget {
  // const Support({ Key? key }) : super(key: key);

  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                child: Text(
                  'Support',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Rowdies'),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.mail,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  "infoyaarhelp@gmail.com",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.phone_android,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  "7232844917",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.phone_android,
                    color: Theme.of(context).accentColor),
                title: Text(
                  " 8824227914",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
