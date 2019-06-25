import 'package:flutter/material.dart';

class InheritedWidgetDemo extends StatefulWidget {

  @override
  State createState() => InheritedWidgetState();
}

class InheritedWidgetState extends State<InheritedWidgetDemo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('hello'),
      ),
    );
  }
}