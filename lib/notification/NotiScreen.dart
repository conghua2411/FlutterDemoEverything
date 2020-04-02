import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiScreen extends StatefulWidget {
  @override
  State createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {
  static const platform = const MethodChannel("com.example.flutter_app/main");

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();

    var initSettings = InitializationSettings(android, iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: selectNoti);
  }

  Future selectNoti(String payload) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('noti click'),
        content: Text('content: $payload'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('notification'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: showNotification,
          child: Text('notification'),
        ),
      ),
    );
  }

  showNotification() async {
//    if (Platform.isAndroid) {
//      await platform.invokeMethod("showNotification");
//    } else {
//      showDialog(
//        context: context,
//        builder: (_) => AlertDialog(
//              title: Text('notification'),
//              content: Text('not support'),
//            ),
//      );
//    }
    var android = AndroidNotificationDetails(
      'channel id',
      'channel name',
      'description',
//      priority: Priority.Max,
//      importance: Importance.Max,
    );

    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);

    DateTime dateTime = DateTime.now().add(Duration(seconds: 5));
    print('now: ${DateTime.now()} -- lul: $dateTime}');

    flutterLocalNotificationsPlugin
        .schedule(
      0,
      'title',
      'body',
      dateTime,
      platform,
//      payload: 'this is payload',
    )
        .then((_) {
      print('OKKKKK');
    }, onError: (e) {
      print('wtf dude: $e');
    });
  }

  showGroupNotification() async {
    String groupKey = "GroupKey";
    String groupChannelId = "groupChannelId";
    String groupChannelName = "groupChannelName";
    String groupDescription = "groupDescription";

    var androidFirst = AndroidNotificationDetails(
        groupChannelId, groupChannelName, groupDescription,
        importance: Importance.Max,
        priority: Priority.High,
        groupKey: groupKey);

    var notiDetailFirst = NotificationDetails(androidFirst, null);

    await flutterLocalNotificationsPlugin.show(
        1, 'first', "first android", notiDetailFirst,
        payload: 'first payload');

    var androidSecond = AndroidNotificationDetails(
        groupChannelId, groupChannelName, groupDescription,
        importance: Importance.Max,
        priority: Priority.High,
        groupKey: groupKey);

    var notiDetailSecond = NotificationDetails(androidSecond, null);

    await flutterLocalNotificationsPlugin.show(
        2, 'second', "second android", notiDetailSecond,
        payload: 'second payload');

    List<String> lines = List<String>();

    lines.add('list first');
    lines.add('list second');

    InboxStyleInformation inboxStyleInformation = InboxStyleInformation(lines,
        contentTitle: '2 new messages', summaryText: 'this is summary text');

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            groupChannelId, groupChannelName, groupDescription,
            style: AndroidNotificationStyle.Inbox,
            styleInformation: inboxStyleInformation,
            groupKey: groupKey,
            setAsGroupSummary: true);

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(androidNotificationDetails, null);

    await flutterLocalNotificationsPlugin.show(
        3, 'attention', 'two new message', platformChannelSpecifics);
  }
}
