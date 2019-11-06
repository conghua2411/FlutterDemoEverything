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
        String modelName = calculateModelName(iosDeviceInfo);
        deviceInfoText = 'model - ${iosDeviceInfo.model}\n'
            'name - ${iosDeviceInfo.name}\n'
            'isPhysicalDevice - ${iosDeviceInfo.isPhysicalDevice}\n'
            'systemName - ${iosDeviceInfo.systemName}\n'
            'systemVersion - ${iosDeviceInfo.systemVersion}\n'
            'identifierForVendor - ${iosDeviceInfo.identifierForVendor}\n'
            'utsname.machine - ${iosDeviceInfo.utsname.machine}\n'
            'utsname.release - ${iosDeviceInfo.utsname.release}\n'
            'utsname.nodename - ${iosDeviceInfo.utsname.nodename}\n'
            'utsname.sysname - ${iosDeviceInfo.utsname.sysname}\n'
            'modelName - $modelName\n';
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

  String calculateModelName(IosDeviceInfo iosDeviceInfo) {
    switch (iosDeviceInfo.utsname.machine) {
      case "iPod5,1":
        return "iPod touch (5th generation)";
      case "iPod7,1":
        return "iPod touch (6th generation)";
      case "iPod9,1":
        return "iPod touch (7th generation)";
      case "iPhone3,1":
      case "iPhone3,2":
      case "iPhone3,3":
        return "iPhone 4";
      case "iPhone4,1":
        return "iPhone 4s";
      case "iPhone5,1":
      case "iPhone5,2":
        return "iPhone 5";
      case "iPhone5,3":
      case "iPhone5,4":
        return "iPhone 5c";
      case "iPhone6,1":
      case "iPhone6,2":
        return "iPhone 5s";
      case "iPhone7,2":
        return "iPhone 6";
      case "iPhone7,1":
        return "iPhone 6 Plus";
      case "iPhone8,1":
        return "iPhone 6s";
      case "iPhone8,2":
        return "iPhone 6s Plus";
      case "iPhone9,1":
      case "iPhone9,3":
        return "iPhone 7";
      case "iPhone9,2":
      case "iPhone9,4":
        return "iPhone 7 Plus";
      case "iPhone8,4":
        return "iPhone SE";
      case "iPhone10,1":
      case "iPhone10,4":
        return "iPhone 8";
      case "iPhone10,2":
      case "iPhone10,5":
        return "iPhone 8 Plus";
      case "iPhone10,3":
      case "iPhone10,6":
        return "iPhone X";
      case "iPhone11,2":
        return "iPhone XS";
      case "iPhone11,4":
      case "iPhone11,6":
        return "iPhone XS Max";
      case "iPhone11,8":
        return "iPhone XR";
      case "iPhone12,1":
        return "iPhone 11";
      case "iPhone12,3":
        return "iPhone 11 Pro";
      case "iPhone12,5":
        return "iPhone 11 Pro Max";
      case "iPad2,1":
      case "iPad2,2":
      case "iPad2,3":
      case "iPad2,4":
        return "iPad 2";
      case "iPad3,1":
      case "iPad3,2":
      case "iPad3,3":
        return "iPad (3rd generation)";
      case "iPad3,4":
      case "iPad3,5":
      case "iPad3,6":
        return "iPad (4th generation)";
      case "iPad6,11":
      case "iPad6,12":
        return "iPad (5th generation)";
      case "iPad7,5":
      case "iPad7,6":
        return "iPad (6th generation)";
      case "iPad7,11":
      case "iPad7,12":
        return "iPad (7th generation)";
      case "iPad4,1":
      case "iPad4,2":
      case "iPad4,3":
        return "iPad Air";
      case "iPad5,3":
      case "iPad5,4":
        return "iPad Air 2";
      case "iPad11,4":
      case "iPad11,5":
        return "iPad Air (3rd generation)";
      case "iPad2,5":
      case "iPad2,6":
      case "iPad2,7":
        return "iPad mini";
      case "iPad4,4":
      case "iPad4,5":
      case "iPad4,6":
        return "iPad mini 2";
      case "iPad4,7":
      case "iPad4,8":
      case "iPad4,9":
        return "iPad mini 3";
      case "iPad5,1":
      case "iPad5,2":
        return "iPad mini 4";
      case "iPad11,1":
      case "iPad11,2":
        return "iPad mini (5th generation)";
      case "iPad6,3":
      case "iPad6,4":
        return "iPad Pro (9.7-inch)";
      case "iPad6,7":
      case "iPad6,8":
        return "iPad Pro (12.9-inch)";
      case "iPad7,1":
      case "iPad7,2":
        return "iPad Pro (12.9-inch) (2nd generation)";
      case "iPad7,3":
      case "iPad7,4":
        return "iPad Pro (10.5-inch)";
      case "iPad8,1":
      case "iPad8,2":
      case "iPad8,3":
      case "iPad8,4":
        return "iPad Pro (11-inch)";
      case "iPad8,5":
      case "iPad8,6":
      case "iPad8,7":
      case "iPad8,8":
        return "iPad Pro (12.9-inch) (3rd generation)";
      case "AppleTV5,3":
        return "Apple TV";
      case "AppleTV6,2":
        return "Apple TV 4K";
      case "AudioAccessory1,1":
        return "HomePod";
      case "i386":
      case "x86_64":
        return "Simulator ${iosDeviceInfo.name}";
      default:
        return iosDeviceInfo.name;
    }
  }
}
