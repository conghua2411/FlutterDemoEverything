import 'package:flutter/material.dart';

class AnimatedListDemo extends StatefulWidget {
  @override
  State createState() => AnimatedListDemoState();
}

class AnimatedListDemoState extends State<AnimatedListDemo> {

  int itemCount = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedListDemo'),
      ),
      body: Container(
        color: Colors.red,
        child: AnimatedList(itemBuilder: (context, index, animation) {
          return _buildItem(index);
        },initialItemCount: itemCount,),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _addItem),
    );
  }

  void _addItem() {
    setState(() {
      itemCount++;
    });
  }

  _buildItem(int index) {
    return Container(
      color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Name$index'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Aloo $index'),
          ),
        ],
      ),
    );
  }
}
