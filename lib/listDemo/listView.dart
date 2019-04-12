import 'package:flutter/material.dart';
import 'listItem.dart';
import 'package:flutter/scheduler.dart';

class ListViewScreen extends StatefulWidget {
  @override
  State createState() {
    return ListViewState();
  }
}

class ListViewState extends State<ListViewScreen> {
  List<String> _listData = List();
  ScrollController _scrollController = new ScrollController();

  final textController = TextEditingController();

  void _addItem([String name]) {
    setState(() {
      if (name != null && name.isNotEmpty) {
        _listData.add(name);
      }
    });

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("dialog title"),
            content: Text("this is content"),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Close"))
            ],
          );
        });
  }

  void _showCustomDialog() {
    Dialog customDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('Add item'),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'enter item',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
              ),
            ),
            Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    _addItem(textController.text);
                    textController.text = "";
                    Navigator.pop(context);
                  },
                  child: Text('ok'),
                  textColor: Colors.blue,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('close'),
                  textColor: Colors.blue,
                )
              ],
            )
          ],
        ),
      ),
    );

    showDialog(
        context: context, builder: (BuildContext context) => customDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test list"),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: RaisedButton(
//              onPressed: _showCustomDialog,
              onPressed: _showCustomDialog,
              child: Text("add item"),
            ),
          ),
          Flexible(
            child: ListItem(_listData, _scrollController),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
