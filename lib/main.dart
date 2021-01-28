import 'package:easy_aquarium_manager/loader/startUpLoader.dart';
import 'package:easy_aquarium_manager/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'errorPage.dart';
import 'loader/loader.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return ErrorPage();
        }
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return _handleLoginScreen();
            break;
          default:
            return Loader();
        }
      },
    );
  }
  _handleLoginScreen(){
    auth.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
        return Login();
      } else {
        print('User is signed in!');
        return StartUpLoader();
      }
    });
  }
}
