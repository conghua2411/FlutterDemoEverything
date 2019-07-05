import 'package:flutter/material.dart';
import 'dart:async';

class RxDartDemo extends StatefulWidget {
  @override
  State createState() => RxDartDemoState();
}

class RxDartDemoState extends State<RxDartDemo> {
  int _counter = 0;

  final StreamController<int> _streamController = StreamController<int>();

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RxDart-Stream"),
      ),
      body: Center(
        child: StreamBuilder<int>(
            stream: _streamController.stream,
            initialData: _counter,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Text('hello ${snapshot.data}');
            }),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            _streamController.sink.add(++_counter);
          }),
    );
  }
}
