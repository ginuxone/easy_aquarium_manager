import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  late final String cntxt;

  ///To default the button redirect to 'AquarioCreator' page
  MyButton([String cntxt = 'AquarioCreator']) : this.cntxt = cntxt;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, this.cntxt);
          },
        ),
      ],
    );
  }
}
