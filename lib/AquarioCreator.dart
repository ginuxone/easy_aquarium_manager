import 'package:flutter/material.dart';

class AquarioCreator extends StatefulWidget {
  AquarioCreator();

  @override
  _AquarioCreatorState createState() => _AquarioCreatorState();
}

class _AquarioCreatorState extends State<AquarioCreator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Aquarium"),
        centerTitle: true,
      ),
    );
  }
}
