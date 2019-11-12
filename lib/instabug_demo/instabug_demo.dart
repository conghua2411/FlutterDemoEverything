import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instabug_flutter/Instabug.dart';

class InstabugDemo extends StatefulWidget {
  @override
  State createState() => InstabugState();
}

class InstabugState extends State<InstabugDemo> {
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      Instabug.start('cc0ac6016f007b7b53e623b20ebaff87', [
        InvocationEvent.shake,
        InvocationEvent.floatingButton,
        InvocationEvent.screenshot
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InstabugDemo'),
      ),
      body: Center(
        child: Text('InstabugDemo'),
      ),
    );
  }
}
