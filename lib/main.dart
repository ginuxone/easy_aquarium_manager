import 'package:easy_aquarium_manager/AquarioCreator.dart';
import 'package:easy_aquarium_manager/homePage.dart';
import 'package:easy_aquarium_manager/loader/startUpLoader.dart';
import 'package:easy_aquarium_manager/LoginRegistration/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Aquario/AquarioDetatil.dart';
import 'LoginRegistration/register.dart';
import 'errorPage.dart';
import 'loader/loader.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: "/",
        routes: {
          'Login': (context) => Login(),
          'Register': (context) => Register(),
          'HomePage': (context) => Homepage(
                aquarioList: [],
              ),
          'AquarioDetail': (context) => AquarioDetail(),
          'AquarioCreator': (context) => AquarioCreator(),
        },
        home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              print("error:\t" + snapshot.error.toString());
              return ErrorPage();
            }
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return _handleLoginScreen(context);
              case ConnectionState.none:
                return ErrorPage();
              case ConnectionState.waiting:
                return Loader();
              default:
                return Loader();
            }
          },
        ));
  }

  _handleLoginScreen(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return ErrorPage();
        } else if (snapshot.hasData) {
          if (!(snapshot.data!.isAnonymous)) return StartUpLoader();
        }
        return Login();
      },
    );
  }
}
