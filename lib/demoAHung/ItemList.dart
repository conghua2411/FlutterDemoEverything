import 'package:flutter/material.dart';

import 'ExpandedSection.dart';

class ItemList extends StatefulWidget {
  final int index;

  ItemList({this.index});

  @override
  State createState() => ItemListState();
}

class ItemListState extends State<ItemList> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          child: Text('item : ${widget.index}'),
          onTap: () {
            setState(() {
              expanded = !expanded;
            });
          },
        ),
        ExpandedSection(
          expand: expanded,
          child: PageView(
            children: <Widget>[
              Container(
                height: 200,
                color: Colors.blue,
                child: Center(
                  child: Text('hello'),
                ),
              ),
              Container(
                height: 200,
                color: Colors.yellow,
              )
            ],
          ),
        )
      ],
    );
  }
}
