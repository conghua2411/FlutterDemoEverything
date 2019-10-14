import 'package:flutter/material.dart';

class BottomEditDemo extends StatefulWidget {
  @override
  State createState() => BottomEditState();
}

class BottomEditState extends State<BottomEditDemo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom edit demo'),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Text('alo'),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottomBar();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showBottomBar() {

  }
}
