import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:sim_info/sim_info.dart';
//import 'package:sim_service/sim_service.dart';

class SimInfoDemo extends StatefulWidget {
  @override
  State createState() => SimInfoState();
}

class SimInfoState extends State<SimInfoDemo> {
  StreamController<String> simServiceStream;

  String simInfoData = '';
  StreamController<String> simInfoStream;

  @override
  void initState() {
    super.initState();
    simServiceStream = StreamController();

//    SimService.getSimData.then((data) {
//      simServiceStream.add(data.simState.toString());
//    }, onError: (e) {
//      simServiceStream.add('Error: $e');
//    });

    simInfoStream = StreamController();

//    SimInfo.getAllowsVOIP.then((allowsVOIP) {
//      simInfoData += '$allowsVOIP\n';
//    }, onError: (e) {
//      simInfoData += '1$e\n';
//    });
//
//    SimInfo.getCarrierName.then((carrierName) {
//      simInfoData += '$carrierName\n';
//    }, onError: (e) {
//      simInfoData += '2$e\n';
//    });
//
//    SimInfo.getIsoCountryCode.then((isoCountryCode) {
//      simInfoData += '$isoCountryCode\n';
//    }, onError: (e) {
//      simInfoData += '3$e\n';
//    });
//
//    SimInfo.getMobileCountryCode.then((mobileCountryCode) {
//      simInfoData += '$mobileCountryCode\n';
//    }, onError: (e) {
//      simInfoData += '4$e\n';
//    });
//
//    SimInfo.getMobileNetworkCode.then((mobileNetworkCode) {
//      simInfoData += '$mobileNetworkCode\n';
//    }, onError: (e) {
//      simInfoData += '5$e\n';
//    });
  }

  @override
  void dispose() {
    simServiceStream.close();
    simInfoStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SimInfoDemo'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<String>(
                initialData: '',
                stream: simServiceStream.stream,
                builder: (context, snapshot) {
                  return Text(snapshot.data);
                },
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<String>(
                initialData: '',
                stream: simInfoStream.stream,
                builder: (context, snapshot) {
                  return Text(snapshot.data);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
