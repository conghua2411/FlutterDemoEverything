import 'package:flutter/material.dart';

class CustomTextFieldView extends StatefulWidget {
  @override
  _CustomTextFieldViewState createState() => _CustomTextFieldViewState();
}

class _CustomTextFieldViewState extends State<CustomTextFieldView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Text Field View'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            customTextField0(),
          ],
        ),
      ),
    );
  }

  Widget customTextField0() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8,
          ),
          child: Container(
            child: TextField(
              decoration: InputDecoration.collapsed(
                hintText: null,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
