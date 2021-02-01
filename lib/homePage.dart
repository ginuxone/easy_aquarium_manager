import 'package:easy_aquarium_manager/Aquario/AquarioCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  final List<AquarioCard> aquarioList;
  Homepage({this.aquarioList});
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
        child: ListView(
          padding: EdgeInsets.zero,
          children:[
            DrawerHeader(
              child: Text('Aquarium Manager'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: FlatButton.icon(
                icon: Icon(Icons.vpn_key_outlined),
                label: Text("Logout from the app"),
                color: Colors.red[300],
                onPressed: (){
                  FirebaseAuth.instance.signOut();
                }
              ),
            ),
          ]
        ),
      ),
      body: ListView(
        children: widget.aquarioList,
      ),
    );
  }
}