import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_aquarium_manager/Aquario/AquarioCard.dart';
import 'package:easy_aquarium_manager/Aquario/AquarioModel.dart';

import 'package:easy_aquarium_manager/errorPage.dart';
import 'package:easy_aquarium_manager/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StartUpLoader extends StatefulWidget {
  @override
  _StartUpLoaderState createState() => _StartUpLoaderState();
}

class _StartUpLoaderState extends State<StartUpLoader> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late List<AquarioCard> aquariums;
  late Future<dynamic> loadedData;
  @override
  void initState() {
    super.initState();
    aquariums = <AquarioCard>[];
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2500),
    );
    animationController.forward();
    animationController.addListener(() {
      if (animationController.status == AnimationStatus.completed) {
        setState(() {
          animationController.repeat();
        });
      }
    });
    loadedData = loadData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadedData,
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasError) return ErrorPage();
          switch (snap.connectionState) {
            case ConnectionState.done:
              print("done");
              return Homepage(
                aquarioList: aquariums,
              );
            case ConnectionState.active:
              print("active");
              return _loaderWidget();
            case ConnectionState.none:
              print("none");
              return _loaderWidget();
            case ConnectionState.waiting:
              print("wait");
              return _loaderWidget();
            default:
              print("ddef");
              return _loaderWidget();
          }
        });
  }

  loadData() async {
    //Load Custom User Data
    return await FirebaseFirestore.instance
        .collection("Aquariums")
        .where("AuthID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.size > 0) {
        for (Map aq in value.docs.first.data()["Aquarium"]) {
          AquarioModel aquarioModel = AquarioModel(key: '', name: '').fromMap(aq);
          aquariums.add(AquarioCard(aquarioModel: aquarioModel));
        }
      }
    });
  }

  _loaderWidget() {
    return Container(
        alignment: Alignment.center,
        color: Colors.lightBlue[100],
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(animationController),
          child: Image(image: AssetImage("assets/logo/logo.jpg")),
        ));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
