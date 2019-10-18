import 'package:flutter/material.dart';

class BottomSheetKeyboard extends StatefulWidget {
  @override
  State createState() => BottomSheetKeyboardState();
}

class BottomSheetKeyboardState extends State<BottomSheetKeyboard> {
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BottomSheetKeyboard'),
      ),
      body: Center(
        child: FlatButton(
          onPressed: () {
            _showBottomSheet();
          },
          child: Text('action'),
          color: Colors.blue,
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(hintText: 'alo 1234'),
            ),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
          );
        });
  }
}
