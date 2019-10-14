import 'package:flutter/material.dart';

class ViewPageBottomBar extends StatefulWidget {

  @override
  State createState() => ViewPageBottomBarState();
}

class ViewPageBottomBarState extends State<ViewPageBottomBar> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.blue,
            ),
          ),
          Container(
            width: 56,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}