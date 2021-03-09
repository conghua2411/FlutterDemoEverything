import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiScreen extends StatefulWidget {
  @override
  State createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('ic_launcher');
    var iOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        print('onDidReceiveLocalNotification: body $body');
        // didReceiveLocalNotificationSubject.add(ReceivedNotification(
        //     id: id, title: title, body: body, payload: payload));
      },
    );

    var initSettings = InitializationSettings(
      android: android,
      iOS: iOS,
    );

    flutterLocalNotificationsPlugin
        .initialize(
      initSettings,
      onSelectNotification: selectNoti,
    )
        .then((value) {
      print(
        'notification setup success',
      );
    });

    _requestPermissions();
  }

  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
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
    var android = AndroidNotificationDetails(
      '123',
      'notification channel',
      'description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    var iOS = IOSNotificationDetails();

    var platform = NotificationDetails(
      android: android,
      iOS: iOS,
    );

    flutterLocalNotificationsPlugin.show(
      0,
      'This is title',
      'This is body',
      platform,
      // payload: 'this is payload',
    );
  }

  // showGroupNotification() async {
  //   String groupKey = "GroupKey";
  //   String groupChannelId = "groupChannelId";
  //   String groupChannelName = "groupChannelName";
  //   String groupDescription = "groupDescription";
  //
  //   var androidFirst = AndroidNotificationDetails(
  //       groupChannelId, groupChannelName, groupDescription,
  //       importance: Importance.Max,
  //       priority: Priority.High,
  //       groupKey: groupKey);
  //
  //   var notiDetailFirst = NotificationDetails(androidFirst, null);
  //
  //   await flutterLocalNotificationsPlugin.show(
  //       1, 'first', "first android", notiDetailFirst,
  //       payload: 'first payload');
  //
  //   var androidSecond = AndroidNotificationDetails(
  //       groupChannelId, groupChannelName, groupDescription,
  //       importance: Importance.Max,
  //       priority: Priority.High,
  //       groupKey: groupKey);
  //
  //   var notiDetailSecond = NotificationDetails(androidSecond, null);
  //
  //   await flutterLocalNotificationsPlugin.show(
  //       2, 'second', "second android", notiDetailSecond,
  //       payload: 'second payload');
  //
  //   List<String> lines = List<String>();
  //
  //   lines.add('list first');
  //   lines.add('list second');
  //
  //   InboxStyleInformation inboxStyleInformation = InboxStyleInformation(lines,
  //       contentTitle: '2 new messages', summaryText: 'this is summary text');
  //
  //   AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //           groupChannelId, groupChannelName, groupDescription,
  //           style: AndroidNotificationStyle.Inbox,
  //           styleInformation: inboxStyleInformation,
  //           groupKey: groupKey,
  //           setAsGroupSummary: true);
  //
  //   NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(androidNotificationDetails, null);
  //
  //   await flutterLocalNotificationsPlugin.show(
  //       3, 'attention', 'two new message', platformChannelSpecifics);
  // }
}
