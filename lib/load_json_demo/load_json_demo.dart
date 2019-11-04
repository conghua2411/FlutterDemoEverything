import 'dart:convert';

import 'package:flutter/material.dart';

class LoadJsonDemo extends StatefulWidget {

  @override
  State createState() => LoadJsonState();
}

class LoadJsonState extends State<LoadJsonDemo> {

  String jsonText = '';
  
  @override
  void initState() {
    super.initState();

    DefaultAssetBundle.of(context).loadString('assets/json/en.json').then((data) {
      setState(() {
        jsonText = (json.decode(data) as Map)['app.components.SettingForm.profileUrlValidationMessage'];
      });
    }, onError: (e) {
      setState(() {
        jsonText = e.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoadJsonDemo'),
      ),
      body: Center(
        child: Text('$jsonText'),
      ),
    );
  }
}