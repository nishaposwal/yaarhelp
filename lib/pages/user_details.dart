import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';

File imageFile;
var imageUrl;

class UserDetails extends StatefulWidget {
  // const CreatePost({ Key? key }) : super(key: key);
  @override
  _UserDetailsState createState() => _UserDetailsState();

  void initState() {
    imageFile = null;
    imageUrl = "";
  }
}

Widget top(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    child: Text(
      'Enter your details',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).accentColor,
          fontSize: 24),
    ),
  );
}

class _UserDetailsState extends State<UserDetails> {
  final nameController = new TextEditingController();
  final phoneNumberController = new TextEditingController();
  final descriptionController = new TextEditingController();
  final addressController = new TextEditingController();
  final skillsController = new TextEditingController();
  final languagesController = new TextEditingController();

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
                color: Colors.blueGrey[900],
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[700],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            width: double.infinity,
            child: TextField(
              controller: controller,
              decoration: new InputDecoration(
                labelText: hint,
                labelStyle: TextStyle(color: Colors.grey[400]),
              ),
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
                color: Colors.blueGrey[900],
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[700],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey[400]),
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

  void addDetails() {
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception("User not logged in");
    }

    final uid = FirebaseAuth.instance.currentUser.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    users.doc(uid).set({
      'displayName': nameController.text,
      'phoneNumber': phoneNumberController.text,
      'imageUrl': imageUrl,
      'skills': skillsController.text,
      'languages': languagesController.text,
      'description': descriptionController.text,
      'address': addressController.text,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'userId': uid,
    });
  }

  Widget chooseFile(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Please Upload Your Profile Picture',
            style: TextStyle(
                color: Colors.blueGrey[900],
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              _openGallery(context);
            },
            child: Text("Select Image"),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).accentColor,
              onSurface: Colors.blue,
            ),
          )
        ],
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      imageFile = File(pickedFile.path);
    });
  }

  void addImageToFirebase() async {
    String fileName = basename(imageFile.path);
    Reference ref = FirebaseStorage.instance.ref().child(
        "Profile_Pics/${FirebaseAuth.instance.currentUser.uid}/${fileName}");
    TaskSnapshot snap = await ref.putFile(imageFile);
    final String url = snap.ref.getDownloadURL().toString();
    setState(() {
      imageUrl = url;
    });
  }

  Widget submit(BuildContext context) {
    bool loading = false;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            loading = true;
          });
          try {
            await addImageToFirebase();
            await FirebaseAuth.instance.currentUser.updatePhotoURL(imageUrl);
            await FirebaseAuth.instance.currentUser
                .updateDisplayName(nameController.text);
            await addDetails();
          } catch (e) {
            print(e);
          } finally {
            setState(() {
              loading = false;
            });
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).accentColor,
          onSurface: Colors.blue,
        ),
        child: loading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
            : Text(
                'Submit',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Roboto'),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                top(context),
                stringInput(
                    nameController, 'Your Name', 'Please enter your name'),
                chooseFile(context),
                inputNumber(phoneNumberController, 'Your Contact Number',
                    'Please enter your contact number'),
                stringInput(descriptionController, 'Tell Us About You',
                    'Please fill your description'),
                stringInput(addressController, 'Where are you from?',
                    'Please fill your location'),
                stringInput(skillsController, 'Your skills',
                    'Please enter your skills'),
                stringInput(languagesController, 'Languages you know?',
                    'Please enter the languages you know'),
                submit(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
