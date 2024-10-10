import 'package:easy_aquarium_manager/Aquario/AquarioCard.dart';
import 'package:easy_aquarium_manager/MyButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  final List<AquarioCard> aquarioList;
  Homepage({required this.aquarioList});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Aquariums"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
          DrawerHeader(
            child: Text('Aquarium Manager'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: TextButton.icon(
                icon: Icon(Icons.vpn_key_outlined),
                label: Text("Logout from the app"),
                style: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(Colors.red.shade300)),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                }),
          ),
        ]),
      ),
      body: checkForNone(),
    );
  }

  Widget checkForNone() {
    if (widget.aquarioList.isEmpty) {
      MyButton but = new MyButton();
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Nessun acquario trovato", textAlign: TextAlign.center),
            but,
            Text("Crea il tuo primo acquario!"),
          ]);
    } else {
      return ListView(
        children: widget.aquarioList,
      );
    }
  }

/*
  Widget newAcquario() {
    return TextButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: Color.fromARGB(10, 0, 0, 255),
      ),
      onPressed: () {
        Navigator.pushNamed(context, 'AquarioCreator');
      },
      icon: Icon(Icons.add),
      label: Text(''),
    );
  }*/
}
