import 'package:flutter/material.dart';
import 'package:flutter_app/custom_button/custom_button.dart';

class CustomButtonView extends StatefulWidget {
  @override
  _CustomButtonViewState createState() => _CustomButtonViewState();
}

class _CustomButtonViewState extends State<CustomButtonView> {
  List<CustomButton> _list;

  @override
  void initState() {
    super.initState();

    _list = [
      CustomButton(
        child: ElevatedButton(
          onPressed: () {
            _buttonClick(content: 'ElevatedButton');
          },
          child: Text('ElevatedButton'),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CustomButtonView'),
      ),
      body: SafeArea(
        bottom: false,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return _list[index].child;
          },
          itemCount: _list.length,
        ),
      ),
    );
  }

  void _buttonClick({String content}) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: 200,
          ),
          child: SingleChildScrollView(
            child: Text(
              '$content',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
        );
      },
    );
  }
}
