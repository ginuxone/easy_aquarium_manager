import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animationController.forward();
    animationController.addListener(() {
      if (animationController.status == AnimationStatus.completed) {
        setState(() {
          animationController.repeat();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
