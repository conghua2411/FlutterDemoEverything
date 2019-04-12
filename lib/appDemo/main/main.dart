import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Main extends StatefulWidget {
  String username, password;

  Main({Key key, this.username, this.password}) : super(key: key);

  @override
  State createState() => MainState();
}

class MainState extends State<Main> {
//  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();

//    var initializationSettingAndroid = new AndroidInitializationSettings(
//        '@mipmap/ic_launcher');
//
//    var initializationSettingIos = new IOSInitializationSettings();
//
//    var initializationSetting = new InitializationSettings(
//        initializationSettingAndroid, initializationSettingIos);
//
//    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
//
//    flutterLocalNotificationsPlugin.initialize(
//        initializationSetting, onSelectNotification: onSelecNotification);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('main'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('${widget.username} --- ${widget.password}'),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    _showNotification();
                  },
                  child: Text('noti'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _showNotification() async {
//    var androidPlatformChannelSpecifics = new AndroidNotificationDetails('notification_channel_id', 'Channel Name', 'description');
//
//    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//
//    var platformChannelSpecifics = new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//
//    await flutterLocalNotificationsPlugin.show(0, 'title', 'body', platformChannelSpecifics, payload: 'payload data');
  }

  Future onSelecNotification(String payload) async {
//    showDialog(context: context,
//        builder: (_) =>
//        new AlertDialog(
//          title: const Text('Here is your payload'),
//          content: Text("payload : $payload"),
//        )
//    );
  }
}
