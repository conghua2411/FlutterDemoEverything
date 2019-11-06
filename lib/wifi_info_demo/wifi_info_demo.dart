import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class WifiInfoDemo extends StatefulWidget {
  @override
  State createState() => WifiInfoDemoState();
}

class WifiInfoDemoState extends State<WifiInfoDemo> {
  String wifiInfo = '';

  StreamController<String> wifiInfoStream = StreamController();

  @override
  void initState() {
    super.initState();

    Connectivity().getWifiBSSID().then((bssid) {
      wifiInfo += 'bssid : $bssid\n';
      wifiInfoStream.add(wifiInfo);
    });

    /// From android 8.0 onwards the GPS must be ON (high accuracy)
    Connectivity().getWifiName().then((wifiName) {
      wifiInfo += 'wifiName : $wifiName\n';
      wifiInfoStream.add(wifiInfo);
    });

    Connectivity().getWifiIP().then((ip) {
      wifiInfo += 'ip : $ip\n';
      wifiInfoStream.add(wifiInfo);
    });
  }

  @override
  void dispose() {
    wifiInfoStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WifiInfoDemo'),
      ),
      body: Center(
        child: StreamBuilder<String>(
          initialData: '',
          stream: wifiInfoStream.stream,
          builder: (context, snapshot) {
            return Text(snapshot.data);
          },
        ),
      ),
    );
  }
}
