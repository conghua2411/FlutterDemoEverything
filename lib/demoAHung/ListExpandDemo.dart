import 'package:flutter/material.dart';

import 'ItemList.dart';

class ListExpandDemo extends StatefulWidget {
  @override
  State createState() => ListExpandState();
}

class ListExpandState extends State<ListExpandDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListExpandDemo'),
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return ItemList(index: index);
          }),
    );
  }
}
