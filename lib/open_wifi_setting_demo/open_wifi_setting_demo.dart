import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class OpenWifiSettingDemo extends StatefulWidget {
  @override
  State createState() => OpenWifiSettingState();
}

class OpenWifiSettingState extends State<OpenWifiSettingDemo>
    with WidgetsBindingObserver {
  String wifiScreenState = '';

  StreamController<String> wifiStateStream;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    wifiStateStream = StreamController();
  }

  @override
  void dispose() {
    wifiConnection?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    wifiStateStream.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        print('OpenWifiSettingDemo: AppLifecycleState.resumed');
        wifiScreenState += 'OpenWifiSettingDemo: AppLifecycleState.resumed\n';
        checkWifi();
        break;
      case AppLifecycleState.inactive:
        print('OpenWifiSettingDemo: AppLifecycleState.inactive');
        wifiScreenState += 'OpenWifiSettingDemo: AppLifecycleState.inactive\n';
        break;
      case AppLifecycleState.paused:
        print('OpenWifiSettingDemo: AppLifecycleState.paused');
        wifiScreenState += 'OpenWifiSettingDemo: AppLifecycleState.paused\n';
        break;
      case AppLifecycleState.suspending:
        print('OpenWifiSettingDemo: AppLifecycleState.suspending');
        wifiScreenState +=
            'OpenWifiSettingDemo: AppLifecycleState.suspending\n';
        break;
    }

    wifiStateStream.add(wifiScreenState);
  }

  @override
  Widget build(BuildContext context) {
    print('OpenWifiSettingDemo: build');
    wifiScreenState += 'OpenWifiSettingDemo: build\n';
    wifiStateStream.add(wifiScreenState);
    return Scaffold(
      appBar: AppBar(
        title: Text('OpenWifiSettingDemo'),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              StreamBuilder<String>(
                  initialData: '',
                  stream: wifiStateStream.stream,
                  builder: (context, snapshot) {
                    return Text(snapshot.data);
                  }),
              FlatButton(
                child: Text('open wifi setting'),
                onPressed: () {
                  print('OpenWifiSettingDemo: open wifi setting');
                  AppSettings.openWIFISettings().then(
                    (_) {
                      print('OpenWifiSettingDemo: success : check new wifi');
                      wifiScreenState +=
                          'OpenWifiSettingDemo: success : check new wifi\n';
                      wifiStateStream.add(wifiScreenState);
                    },
                    onError: (e) {
                      print('OpenWifiSettingDemo: error : $e');
                      wifiScreenState += 'OpenWifiSettingDemo: error : $e\n';
                      wifiStateStream.add(wifiScreenState);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  StreamSubscription<String> wifiConnection;

  void checkWifi() {
    wifiConnection?.cancel();

    wifiConnection = Connectivity().getWifiName().asStream().listen((data) {
      wifiScreenState += 'Connectivity().getWifiName() wifiName: $data\n';
      wifiStateStream.add(wifiScreenState);
    }, onError: (e) {
      wifiScreenState += 'Connectivity().getWifiName() error: $e\n';
      wifiStateStream.add(wifiScreenState);
    });
  }
}
