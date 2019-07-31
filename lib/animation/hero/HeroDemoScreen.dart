import 'package:flutter/material.dart';

class HeroDemoScreen extends StatefulWidget {
  @override
  State createState() => HeroDemoState();
}

class HeroDemoState extends State<HeroDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[500],
        title: Hero(
            tag: 'heroTest-2',
            child: Material(
              child: Text(
                'fancyBackground',
                style: TextStyle(fontSize: 20),
              ),
              color: Colors.transparent,
            )),
      ),
      body: Center(
        child: Hero(
            tag: 'heroTest-1',
            child: Material(
              child: Text(
                'hero',
                style: TextStyle(fontSize: 20),
              ),
              color: Colors.transparent,
            )),
      ),
    );
  }
}
