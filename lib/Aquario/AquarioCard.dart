import 'package:easy_aquarium_manager/Aquario/AquarioModel.dart';
import 'package:flutter/material.dart';

class AquarioCard extends StatelessWidget {
  final AquarioModel aquarioModel;
  AquarioCard({this.aquarioModel});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, "AquarioDetail",arguments: aquarioModel);
      },
      child: Card(
        elevation: 18.0,
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        clipBehavior: Clip.antiAlias,
        child: Column(
            children:[
              Hero(
                tag: aquarioModel.key,
                child: Image(image: AssetImage("assets/logo/logo.jpg"),)
              ),
              ListTile(
                title: Text(aquarioModel.name),
                subtitle: Text(
                  aquarioModel.key,
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ]
        ),
      ),
    );
  }
}