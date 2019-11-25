import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireBaseMessagingDemo extends StatefulWidget {
  @override
  State createState() => FireBaseMessagingState();
}

class FireBaseMessagingState extends State<FireBaseMessagingDemo> {
  StreamController<String> notificationData = StreamController();

  FirebaseMessaging _firebaseMessaging;

  @override
  void initState() {
    super.initState();

    _firebaseMessaging = FirebaseMessaging();

    _firebaseMessaging.subscribeToTopic('alo1234');
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        sharedPreferences.setString(
            'noti_alo_1234',
            '${sharedPreferences.getString('noti_alo_1234') ?? 'null'}'
                '\nonMessage: ${message.toString()}');

        notificationData.add('onMessage: ${message.toString()}');
      },
      onLaunch: (Map<String, dynamic> message) async {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        sharedPreferences.setString(
            'noti_alo_1234',
            '${sharedPreferences.getString('noti_alo_1234') ?? 'null'}'
                '\nonLaunch: ${message.toString()}');
        notificationData.add('onLaunch: ${message.toString()}');
      },
      onResume: (Map<String, dynamic> message) async {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        sharedPreferences.setString(
            'noti_alo_1234',
            '${sharedPreferences.getString('noti_alo_1234') ?? 'null'}'
                '\nonResume: ${message.toString()}');
        notificationData.add('onResume: ${message.toString()}');
      },
    );
  }

  @override
  void dispose() {
    notificationData.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FirebaseMessagingDemo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<String>(
              initialData: 'initdata',
              stream: notificationData.stream,
              builder: (context, snapshot) {
                return Text(snapshot.data);
              },
            ),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              onPressed: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();

                notificationData.add(
                    sharedPreferences.getString('noti_alo_1234') ?? 'null');
              },
              child: Text(
                'Show data',
              ),
            ),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              onPressed: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();

                sharedPreferences.clear().then((ok) {
                  notificationData.add('clear data: $ok');
                }, onError: (e) {
                  notificationData.add('clear data error : $e');
                });
              },
              child: Text(
                'Clear data',
              ),
            )
          ],
        ),
      ),
    );
  }
}
