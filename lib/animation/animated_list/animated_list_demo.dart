import 'package:flutter/material.dart';

class AnimatedListDemo extends StatefulWidget {

  @override
  State createState() => AnimatedListDemoState();
}

class AnimatedListDemoState extends State<AnimatedListDemo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
      ),
    );
  }
}