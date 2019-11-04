import 'package:flutter/material.dart';

class KeyboardInit extends StatefulWidget {

  @override
  State createState() => KeyboardInitState();
}

class KeyboardInitState extends State<KeyboardInit> {

  @override
  void initState() {
    super.initState();

    print('KeyboardInit initState: start');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KeyboardInit'),
      ),
      body: Center(
        child: TextField(
          decoration: InputDecoration(
            hintText: 'alo 1234',
          ),
        ),
      ),
    );
  }
}