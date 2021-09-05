import 'package:yaarhelp/pages/main_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Yaarhelp());
}

class Yaarhelp extends StatefulWidget {
  @override
  _YaarhelpState createState() => _YaarhelpState();
}

class _YaarhelpState extends State<Yaarhelp> {
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
                  fontFamily: 'Lato'),

              // home: LoginPage(),
              home: MainTabs(),
            );
          }

          return Text('loading', textDirection: TextDirection.ltr);
        });
  }
}
