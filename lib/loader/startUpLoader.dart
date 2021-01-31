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
  AnimationController animationController;
  List<AquarioCard> aquariums;
  Future<dynamic> loadedData;
  @override
  void initState() {
    super.initState();
    aquariums=List<AquarioCard>();
    animationController=AnimationController(
      vsync:this,
      duration:Duration(milliseconds: 2500),
    );
    animationController.forward();
    animationController.addListener(() {
      if(animationController.status==AnimationStatus.completed){
        setState(() {
          animationController.repeat();
        });
      }
    });
    loadedData=loadData();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadedData,
      builder: (BuildContext context,AsyncSnapshot snap){
        if(snap.hasError)
          return ErrorPage();
        switch (snap.connectionState) {
          case ConnectionState.done:
            print("done");
            return Homepage(aquarioList: aquariums,);
            break;
          case ConnectionState.active:
          print("active");
            return _loaderWidget();
              break;
          case ConnectionState.none:
          print("none");
            return _loaderWidget();
            break;
          case ConnectionState.waiting:
          print("wait");
            return _loaderWidget();
            break;
          default:
          print("ddef");
            return _loaderWidget();
        }
      }
    );
  }

  loadData()async{
    //Load Custom User Data
    return await FirebaseFirestore.instance.collection("Aquariums").where("AuthID", isEqualTo:FirebaseAuth.instance.currentUser.uid).get()
    .then((value){
      if(value.size>0){
        for (Map aq in value.docs.first.data()["Aquarium"]) {
          aquariums.add(
            AquarioCard(
              aquarioModel:AquarioModel().fromMap(aq)
            )
          );
        }
      }
    });
  }

  _loaderWidget(){
    return Container(
      alignment: Alignment.center,
      color: Colors.lightBlue[100],
      child: RotationTransition(
        turns: Tween(begin: 0.0,end: 1.0).animate(animationController),
        child: Image(image: AssetImage("assets/logo/logo.jpg")),
      )
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}