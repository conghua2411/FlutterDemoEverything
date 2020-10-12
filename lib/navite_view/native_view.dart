import 'dart:io';

import 'package:flutter/material.dart';

class NativeView extends StatefulWidget {
  @override
  _NativeViewState createState() => _NativeViewState();
}

class _NativeViewState extends State<NativeView> {
  void showDialogNotSupport() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('NOT SUPPORT'),
          content: Text('YOUR OS NOT SUPPORT'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Native View'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  color: Colors.blue,
                  child: Text(
                    'Android',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (Platform.isAndroid) {
                      print('ok');
                    } else {
                      showDialogNotSupport();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  color: Colors.blue,
                  child: Text(
                    'IOS',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (Platform.isIOS) {
                      print('ok');
                    } else {
                      showDialogNotSupport();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
