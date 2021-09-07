import 'package:yaarhelp/pages/main_tabs.dart';
import 'package:yaarhelp/pages/signup.dart';
import 'package:yaarhelp/pages/user_details.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'bezierContainer.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

@override
bool shouldReclip(CustomClipper<Path> oldClipper) {
  return true;
}

class _LoginPageState extends State<LoginPage> {
  String error = 'yes';
  bool loading = false;
  bool googleLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget _entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              controller: controller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  void login() async {
    setState(() {
      loading = true;
    });
    try {
      await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      showdialogBox('Success', 'Logged in successfully', false);
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((value) => {
                if (value.data() == null)
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserDetails(false)))
                  }
                else
                  {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MainTabs()),
                      (Route<dynamic> route) => false,
                    )
                  }
              });
    } catch (err) {
      print('error has occured ${err.message}');
      showdialogBox('Error has occured', err.message, true);
    } finally {
      loading = false;
    }
  }

  void showdialogBox(String title, String subTitle, bool isError) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(
          subTitle,
          style: isError
              ? TextStyle(color: Colors.red)
              : TextStyle(color: Colors.green),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void navigateToHome() {}
  Widget _submitButton() {
    return Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff7ED8D8), Color(0xff49BABA)])),
        child: TextButton(
          onPressed: () => login(),
          child: loading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
              : Text(
                  'Login',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
        ));
  }

  // Widget _divider() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 10),
  //     child: Row(
  //       children: <Widget>[
  //         SizedBox(
  //           width: 20,
  //         ),
  //         Expanded(
  //           child: Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 10),
  //             child: Divider(
  //               thickness: 1,
  //             ),
  //           ),
  //         ),
  //         Text('or'),
  //         Expanded(
  //           child: Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 10),
  //             child: Divider(
  //               thickness: 1,
  //             ),
  //           ),
  //         ),
  //         SizedBox(
  //           width: 20,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Future<void> signInWithGoogle() async {
    try {
      setState(() {
        googleLoading = true;
      });
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      // if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      showdialogBox('Success', 'loagged in', false);
    } catch (err) {
      showdialogBox('Error has occured', err.message, true);
    } finally {
      setState(() {
        googleLoading = false;
      });
    }
    // } else {
    //   showdialogBox('Error has occured', 'No google account found ', true);
    //   googleLoading = false;
    // }
  }

  // Widget _facebookButton() {
  //   return Container(
  //     height: 50,
  //     margin: EdgeInsets.symmetric(vertical: 20),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.all(Radius.circular(10)),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Expanded(
  //           flex: 1,
  //           child: Container(
  //             decoration: BoxDecoration(
  //               color: Theme.of(context).accentColor,
  //               borderRadius: BorderRadius.only(
  //                   bottomLeft: Radius.circular(5),
  //                   topLeft: Radius.circular(5)),
  //             ),
  //             alignment: Alignment.center,
  //             child: Text('G',
  //                 style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 25,
  //                     fontWeight: FontWeight.w400)),
  //           ),
  //         ),
  //         Expanded(
  //           flex: 5,
  //           child: Container(
  //             decoration: BoxDecoration(
  //               color: Theme.of(context).accentColor,
  //               borderRadius: BorderRadius.only(
  //                   bottomRight: Radius.circular(5),
  //                   topRight: Radius.circular(5)),
  //             ),
  //             alignment: Alignment.center,
  //             child: TextButton(
  //               onPressed: signInWithGoogle,
  //               child: googleLoading
  //                   ? CircularProgressIndicator(
  //                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
  //                   : Text('Log in with Google',
  //                       style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: 18,
  //                           fontWeight: FontWeight.w400)),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Color(0xff49BABA),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Text(
      'Yaar Help',
      style: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email id", emailController),
        _entryField("Password", passwordController, isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -height * .15,
            right: -MediaQuery.of(context).size.width * .4,
            child: BezierContainer(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: double.infinity,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 50),
                  _title(),
                  _emailPasswordWidget(),
                  _submitButton(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: Text('Forgot Password ?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                  // _divider(),
                  // _facebookButton(),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
