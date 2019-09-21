import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionDemo extends StatefulWidget {
  @override
  State createState() => PermissionDemoState();
}

class PermissionDemoState extends State<PermissionDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Permission Demo'),
      ),
      body: Center(
        child: FlatButton(
            color: Colors.blue,
            onPressed: () async {
              Map<PermissionGroup, PermissionStatus> permissions =
                  await PermissionHandler()
                      .requestPermissions([PermissionGroup.contacts, PermissionGroup.storage]);

              print(permissions);
            },
            child: Text('requestPermission')),
      ),
    );
  }
}
