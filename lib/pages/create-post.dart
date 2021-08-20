import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  // const CreatePost({ Key? key }) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

Widget top() {
  return Material(
    elevation: 5,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Text(
                      'Post a help',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xffB5EAEA),
                          fontSize: 24),
                    ),
                  ),
                  Text(
                    'Ask for anykind of help',
                    style: TextStyle(
                        color: Color(0xff000000).withOpacity(0.7),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Image(
                image: AssetImage('assets/images/people.jpeg'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Tell us what do you need done we’ll help you find some-one who can help you in your work',
              style: TextStyle(
                color: Color(0xffC4C4C4),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _CreatePostState extends State<CreatePost> {
  DateTime selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Widget dateContainer() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Service delivery time !',
              style: TextStyle(
                color: Color(0xff000000).withOpacity(0.45),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey, // red as border color
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  selectedDate != null
                      ? Text("${selectedDate.toLocal()}".split(' ')[0])
                      : Text('Select Date'),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Select'),
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            top(),
            dateContainer(),
          ],
        ),
      ),
    );
  }
}
