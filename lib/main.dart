import 'package:fiverr_clone/pages/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FiverrClone());
}

class FiverrClone extends StatefulWidget {
  @override
  _FiverrCloneState createState() => _FiverrCloneState();
}

class _FiverrCloneState extends State<FiverrClone> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return FutureBuilder<Object>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('something went wrong',
                textDirection: TextDirection.ltr);
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: Colors.white,
                accentColor: Color(0xFF7ED8D8),
              ),
              home: LoginPage(),
            );
          }

          return Text('loading', textDirection: TextDirection.ltr);
        });
  }
}
