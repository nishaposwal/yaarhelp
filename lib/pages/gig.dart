import 'dart:ffi';

import 'package:flutter/material.dart';

class Gig extends StatefulWidget {
  // const Gig({ Key? key }) : super(key: key);
  String name;
  String description;
  String imageUrl;
  String budget;
  String date;
  String title;

  Gig(
      {this.budget,
      this.date,
      this.description,
      this.imageUrl,
      this.name,
      this.title});

  @override
  _GigState createState() => _GigState();
}

void viewGigDetail() {
  // navigate to details page , add required parameters
}

void apply() {
  // do apply flow here
}

Widget actions(context) {
  return Row(
    children: [
      FlatButton(
        color: Theme.of(context).accentColor,
        onPressed: () => apply(),
        child: Text(
          'Apply',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      OutlineButton(
        onPressed: () => viewGigDetail(),
        color: Theme.of(context).accentColor,
        // textTheme: OutlinedButtonTheme.of(context).style
        child: Text(
          'View Details',
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold),
        ),
      )
    ],
  );
}

Widget budget(String budget, BuildContext context) {
  return Container(
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      border: Border.all(
        color: Theme.of(context).accentColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      'Rs' + budget,
      style: TextStyle(color: Theme.of(context).accentColor),
    ),
  );
}

class _GigState extends State<Gig> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          child: Row(children: [
            Image(
              image: AssetImage('assets/images/nouser.jpeg'),
              width: 50,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(widget.date),
                    ],
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  budget('23', context),
                  actions(context),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
