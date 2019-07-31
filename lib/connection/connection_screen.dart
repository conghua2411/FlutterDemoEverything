import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/animation/AnimationScreen.dart';

//class ConnectionScreen extends ConnectionWidget<ConnectionState2> {
//  @override
//  ConnectionState2 getState() {
//    return ConnectionState2();
//  }
//}

class ConnectionScreen extends StatefulWidget {
  @override
  State createState() => ConnectionState2();
}

class ConnectionState2 extends ConnectionWidgetState<ConnectionScreen> with TickerProviderStateMixin {
  String text = 'lost connection';

  @override
  void hasConnection() {
    print('has connection');
    setState(() {
      text = 'has connection';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ConnectionCheck'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Text(text),
          FlatButton(
            color: Colors.blue,
            child: Text('nextScreen'),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => AnimationScreen()));
            },
          )
        ],
      )),
    );
  }

  @override
  void lostConnection() {
    print('lost connection');
    setState(() {
      text = 'lost connection';
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

//class ConnectionState extends State<ConnectionScreen> {
//
////  StreamSubscription _connectionChangeStream;
////  bool isOnline = false;
//
//  @override
//  void initState() {
//    super.initState();
//
////    ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
////    _connectionChangeStream = connectionStatus.connectionChange.listen(connectionChanged);
////
////    print('ConnectionScreen initState: ${connectionStatus.hasConnection}');
//
////    isOnline = connectionStatus.hasConnection;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return ConnectionWidget(
//      child: Scaffold(
//        appBar: AppBar(
//          title: Text('Connection Screen'),
//        ),
//        body: Center(
////          child: isOnline ? Text('has connection') : Text('lost connection'),
//          child: Text('test connection widget'),
//        ),
//      ),
//    );
//  }
//
////  void connectionChanged(dynamic hasConnection) {
////    setState(() {
////      isOnline = hasConnection;
////    });
////  }
//}

// connection singleton
class ConnectionStatusSingleton {
  static final ConnectionStatusSingleton _singleton =
      new ConnectionStatusSingleton._internal();

  ConnectionStatusSingleton._internal();

  static ConnectionStatusSingleton getInstance() => _singleton;

  bool hasConnection = false;

  StreamController connectivityChangeController = StreamController.broadcast();

  final Connectivity _connectivity = Connectivity();

  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  Stream get connectionChange => connectivityChangeController.stream;

  void _connectionChange(ConnectivityResult result) {
    print('ConnectionStatusSingleton : _connectionChange');
    checkConnection();
  }

  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    if (previousConnection != hasConnection) {
      connectivityChangeController.add(hasConnection);
    }

    return hasConnection;
  }

  void dispose() {
    connectivityChangeController.close();
  }
}

// connection widget
abstract class ConnectionWidget<T extends ConnectionWidgetState>
    extends StatefulWidget {
  ConnectionWidget();

  T getState();

  @override
  State createState() => getState();
}

//abstract class ConnectionWidgetState extends State<ConnectionWidget> {
abstract class ConnectionWidgetState<W extends StatefulWidget>
    extends State<W> {
  StreamSubscription _connection;

  @override
  void initState() {
    super.initState();
    _connection = Connectivity().onConnectivityChanged.listen((result) async {
      await checkConnection();
    });

    checkConnection();
  }

  Future checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection();
      } else {
        lostConnection();
      }
    } on SocketException catch (_) {
      lostConnection();
    }
  }

  @override
  void dispose() {
    print('ConnectionWidgetState: dispose');
    _connection.cancel();
    super.dispose();
  }

  void hasConnection();

  void lostConnection();
}
