import 'package:flutter/material.dart';

class DeepLinkScreen extends StatefulWidget {

  @override
  State createState() => DeepLinkState();
}

class DeepLinkState extends State<DeepLinkScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('deep link demo'),
      ),
    );
  }
}