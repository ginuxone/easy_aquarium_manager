import 'package:easy_aquarium_manager/Aquario/AquarioModel.dart';
import 'package:flutter/material.dart';

class AquarioDetail extends StatefulWidget {
  @override
  _AquarioDetailState createState() => _AquarioDetailState();
}

class _AquarioDetailState extends State<AquarioDetail> {
  @override
  Widget build(BuildContext context) {
    AquarioModel aquarioModel = ModalRoute.of(context)!.settings.arguments as AquarioModel;
    return Scaffold(
      body: Column(children: [
        Stack(
          children: [
            Hero(
              tag: aquarioModel.key,
              child: Image.asset("assets/logo/logo.jpg"),
            ),
            Positioned(
              bottom: 0,
              child: Text(aquarioModel.name),
            )
          ],
        ),
      ]),
    );
  }
}
