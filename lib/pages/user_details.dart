import 'dart:io';
import 'package:yaarhelp/pages/loginPage.dart';
import 'package:yaarhelp/pages/multiselect.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

File imageFile;
String imageUrl;
bool loading = false;
String oldImageUrl;

class UserDetails extends StatefulWidget {
  final bool edit;
  UserDetails(this.edit);
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

Widget top(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          child: Icon(Icons.arrow_back_outlined),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Expanded(
          child: Text(
            'Enter your details',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
                fontSize: 24),
          ),
        ),
      ],
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
  List<Map<String, dynamic>> selectedOnlineCats = [];
  List<Map<String, dynamic>> selectedOfflineCats = [];

  void initState() {
    imageFile = null;
    imageUrl = null;
    oldImageUrl = null;
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((value) {
        if (value.data() == null) {
          return;
        }
        nameController.text = value.data()['displayName'];
        addressController.text = value.data()['address'];
        descriptionController.text = value.data()['description'];
        languagesController.text = value.data()['languages'];
        phoneNumberController.text = value.data()['phoneNumber'];
        skillsController.text = value.data()['skills'];
        setState(() {
          oldImageUrl = value.data()['imageUrl'];
        });
      });
    }
    super.initState();
  }

  List<Map<String, dynamic>> fun(List<dynamic> list) {
    List<Map<String, dynamic>> res = [];
    list.forEach((element) {
      res.add({'name': element['name']});
    });

    return res;
  }

  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    phoneNumberController.dispose();
    descriptionController.dispose();
    addressController.dispose();
    skillsController.dispose();
    languagesController.dispose();
    super.dispose();
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
                color: Colors.blueGrey[900],
                fontSize: 18,
                fontWeight: FontWeight.w600),
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
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey[400]),
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
                fontWeight: FontWeight.w600),
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
              controller: controller,
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

  bool validateControllers() {
    return (nameController.text != null &&
        phoneNumberController.text != null &&
        descriptionController.text != null &&
        addressController.text != null &&
        skillsController.text != null &&
        languagesController.text != null &&
        nameController.text != "" &&
        phoneNumberController.text != "" &&
        descriptionController.text != "" &&
        addressController.text != "" &&
        skillsController.text != "" &&
        languagesController.text != "");
  }

  Future<dynamic> addDetails(BuildContext context, bool editing) async {
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      return null;
    }

    if (!validateControllers()) {
      showdialogBox("Please fill all the fields", true, context);
      return null;
    }

    await addImageToFirebase(context);

    if (imageUrl == null) {
      imageUrl = oldImageUrl;
    }
    final uid = FirebaseAuth.instance.currentUser.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseAuth.instance.currentUser.updateDisplayName(nameController.text);
    final now = new DateTime.now();
    String formatter = DateFormat.yMMMM('en_US').format(now);
    editing == true
        ? await users.doc(uid).update({
            'displayName': nameController.text,
            'phoneNumber': phoneNumberController.text,
            'imageUrl': imageUrl,
            'skills': skillsController.text,
            'languages': languagesController.text,
            'description': descriptionController.text,
            'address': addressController.text,
            'onlineHelp': selectedOnlineCats,
            'offlineHelp': selectedOfflineCats
          })
        : await users.doc(uid).set({
            'displayName': nameController.text,
            'phoneNumber': phoneNumberController.text,
            'imageUrl': imageUrl,
            'skills': skillsController.text,
            'languages': languagesController.text,
            'description': descriptionController.text,
            'address': addressController.text,
            'joiningDate': formatter,
            'userId': uid,
            'onlineHelp': selectedOnlineCats,
            'offlineHelp': selectedOfflineCats
          });
    Navigator.pop(context);
    return null;
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
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              _openGallery(context);
            },
            child: Text(imageFile == null
                ? (widget.edit == true ? "Update Image" : "Select Image")
                : (basename(imageFile.path))),
            style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 15),
                primary: Theme.of(context).accentColor),
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

  Future<dynamic> addImageToFirebase(BuildContext context) async {
    if (imageFile == null) return;
    if (FirebaseAuth.instance.currentUser == null) return;
    String fileName = basename(imageFile.path);
    Reference ref = FirebaseStorage.instance.ref().child(
        "Profile_Pics/${FirebaseAuth.instance.currentUser.uid}/$fileName");
    UploadTask uploadTask = ref.putFile(imageFile);
    var url = await (await uploadTask).ref.getDownloadURL();
    url = url.toString();
    setState(() {
      imageUrl = url;
    });
    return FirebaseAuth.instance.currentUser.updatePhotoURL(url);
  }

  void showdialogBox(String subTitle, bool isError, BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.all(20),
        content: Text(
          subTitle,
          style: isError
              ? TextStyle(color: Colors.red)
              : TextStyle(color: Colors.green),
        ),
        actionsPadding: EdgeInsets.all(5),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget submit(BuildContext context, edit) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            loading = true;
          });
          try {
            await addDetails(context, edit);
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
        child: loading == true
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              )
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

  List<Map<String, dynamic>> onlineCategories = [
    {'name': "Assignment Help"},
    {'name': "Social Media Help"},
    {'name': "Art & Design Help"},
    {'name': 'Presentations Help'},
    {'name': 'Programming Help'},
    {'name': 'Question solving Help'},
    {'name': 'Writing Help'},
    {'name': 'Tech Help'},
    {'name': 'Content research Help'},
    {'name': 'Other Help'},
  ];
  List<Map<String, dynamic>> offlineCategories = [
    {'name': 'Personal Assistant Help'},
    {'name': 'Organize/Decor Help'},
    {'name': 'Health/Therapy Help'},
    {'name': 'Technical Help'},
    {'name': 'Drop-ship/Moving Help'},
    {'name': 'Baby/Pet Care Help'},
    {'name': 'Cafe/Hotel'},
    {'name': 'Repairing Help'},
    {'name': 'House Help'},
    {'name': 'Other Help'}
  ];

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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: MultuSelect(
                    heading: 'Select Interest in Online Help',
                    list: onlineCategories,
                    selectedValuse: selectedOnlineCats,
                    fn: (value) {
                      setState(() {
                        selectedOnlineCats = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: MultuSelect(
                    heading: 'Select Interest in Offline Help',
                    list: offlineCategories,
                    selectedValuse: selectedOfflineCats,
                    fn: (value) {
                      setState(() {
                        selectedOfflineCats = value;
                      });
                    },
                  ),
                ),
                submit(context, widget.edit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
