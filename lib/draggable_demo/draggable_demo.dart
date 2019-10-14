import 'package:flutter/material.dart';

class DraggableDemo extends StatefulWidget {
  @override
  State createState() => DraggableDemoState();
}

class DraggableDemoState extends State<DraggableDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Draggable Demo')),
      body: Container(
        color: Colors.red,
        child: Center(
          child: Draggable(
            axis: Axis.vertical,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.blue,
            ),
            feedback: Container(
              width: 100,
              height: 100,
              color: Colors.amber,
            ),
            childWhenDragging: Container(),
            data: [
              'hello',
              'alo',
            ],
          ),
        ),
      ),
    );
  }
}
