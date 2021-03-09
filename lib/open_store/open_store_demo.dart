import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenStoreDemo extends StatefulWidget {
  @override
  _OpenStoreDemoState createState() => _OpenStoreDemoState();
}

class _OpenStoreDemoState extends State<OpenStoreDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          child: Text('Open Store'),
          onPressed: () {

//            if (Platform.isIos)
            launch('https://apps.apple.com/app/id284882215');

//            LaunchReview.launch(
//              androidAppId: "com.facebook.katana",
//              iOSAppId: "284882215",
//              writeReview: false,
//            );
          },
        ),
      ),
    );
  }
}
