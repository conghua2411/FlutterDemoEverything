import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebasePrefData extends StatefulWidget {
  @override
  State createState() => FirebasePrefDataState();
}

class FirebasePrefDataState extends State<FirebasePrefData> {
  StreamController<String> prefData = StreamController();

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((pref) {
      prefData.add('SharedPreferences: success\n'
          '${pref.getString('noti_alo_1234')}');
    }, onError: (e) {
      prefData.add('SharedPreferences: error - $e');
    });
  }

  @override
  void dispose() {
    prefData.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FirebasePrefData'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder<String>(
            initialData: 'initData',
            stream: prefData.stream,
            builder: (context, snapshot) {
              return Text(snapshot.data);
            },
          ),
        ],
      ),
    );
  }
}
