import 'package:fiverr_clone/pages/dropDown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart'; // new

import 'package:firebase_auth/firebase_auth.dart';

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
  String category;
  String subCategory;
  final timerequiredController = new TextEditingController();
  final budgetController = new TextEditingController();
  final descriptionController = new TextEditingController();
  final addressController = new TextEditingController();
  final categoryList = ['one', 'two', 'three', 'four'];

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    timerequiredController.dispose();
    budgetController.dispose();
    descriptionController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Widget categories() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Choose a Category',
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          DropDown(
            value: category,
            hint: 'Select a category',
            itemsList: categoryList,
            onChanged: (value) {
              setState(() {
                category = value;
              });
            },
          ),
          DropDown(
            value: subCategory,
            hint: 'Select a  sub-category',
            itemsList: categoryList,
            onChanged: (value) {
              setState(() {
                subCategory = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget inputNumber(
      TextEditingController controller, String header, String hint) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            header,
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            width: double.infinity,
            child: TextField(
              controller: controller,
              decoration: new InputDecoration(labelText: hint),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          )
        ],
      ),
    );
  }

  Widget stringInput(
      TextEditingController controller, String header, String hint) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            header,
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<DocumentReference> addGig() {
    if (FirebaseAuth.instance.currentUser == null) {
      print('not logged in');
    } else {
      print('logged in');
    }

    return FirebaseFirestore.instance.collection('gigs').add(<String, dynamic>{
      'category': category,
      'subCategory': subCategory,
      'timeRequired': timerequiredController.text,
      'budget': budgetController.text,
      'description': descriptionController.text,
      'address': addressController.text,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'userId': FirebaseAuth.instance.currentUser.uid,
    });
  }

  Widget post() {
    bool loading = false;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            loading = true;
          });
          try {
            await addGig();
          } catch (e) {
            print(e);
          } finally {
            setState(() {
              loading = false;
            });
          }
        },
        child: loading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
            : Text(
                'Post A Request',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              top(),
              categories(),
              inputNumber(timerequiredController, 'Service Delivary time',
                  'Enter time required to complete task'),
              inputNumber(budgetController, 'What is your budget',
                  'Enter yur budget in rupees'),
              stringInput(
                  descriptionController, 'Add Description', 'Description'),
              stringInput(addressController, 'Add Address', 'Address'),
              post(),
            ],
          ),
        ),
      ),
    );
  }
}
