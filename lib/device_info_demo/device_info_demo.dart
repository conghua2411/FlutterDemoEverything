import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class DeviceInfoDemo extends StatefulWidget {
  @override
  State createState() => DeviceInfoDemoState();
}

class DeviceInfoDemoState extends State<DeviceInfoDemo> {
  String deviceInfoText = '';

  BehaviorSubject<String> deviceInfoTextStream = BehaviorSubject();

  @override
  void initState() {
    super.initState();

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      print('android');
      deviceInfo.androidInfo.then((androidDeviceInfo) {
        print('android success');
        deviceInfoText = 'version - ${androidDeviceInfo.version.codename}\n'
            'model - ${androidDeviceInfo.model}\n'
            'board - ${androidDeviceInfo.board}\n'
            'manufacturer - ${androidDeviceInfo.manufacturer}\n'
            'androidId - ${androidDeviceInfo.androidId}\n'
            'id - ${androidDeviceInfo.id}\n'
            'device - ${androidDeviceInfo.device}\n'
            'hardware - ${androidDeviceInfo.hardware}';
        deviceInfoTextStream.add(deviceInfoText);
      }, onError: (e) {
        print('android error $e');
        deviceInfoText = e.toString();
        deviceInfoTextStream.add(deviceInfoText);
      });
    } else if (Platform.isIOS) {
      print('ios');
      deviceInfo.iosInfo.then((iosDeviceInfo) {
        print('ios success');
        deviceInfoText = 'model - ${iosDeviceInfo.model}\n'
            'name - ${iosDeviceInfo.name}\n'
            'isPhysicalDevice - ${iosDeviceInfo.isPhysicalDevice}\n'
            'systemName - ${iosDeviceInfo.systemName}\n'
            'systemVersion - ${iosDeviceInfo.systemVersion}\n'
            'identifierForVendor - ${iosDeviceInfo.identifierForVendor}\n';
        deviceInfoTextStream.add(deviceInfoText);
      }, onError: (e) {
        print('ios error $e');
        deviceInfoText = e.toString();
        deviceInfoTextStream.add(deviceInfoText);
      });
    }
  }

  @override
  void dispose() {
    deviceInfoTextStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DeviceInfoDemo'),
      ),
      body: Center(
        child: StreamBuilder<String>(
          stream: deviceInfoTextStream,
          initialData: '',
          builder: (context, snapshot) {
            return Text(snapshot.data);
          },
        ),
      ),
    );
  }
}
