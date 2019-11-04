import 'package:flutter/material.dart';

class DeepLinkNativeDemo extends StatefulWidget {

  @override
  State createState() => DeepLinkNativeState();
}

class DeepLinkNativeState extends State<DeepLinkNativeDemo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DeepLinkNativeDemo'),
      ),
      body: Container(
        color: Colors.amber,
      ),
    );
  }
}