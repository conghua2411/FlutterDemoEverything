import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UploadS3Screen extends StatefulWidget {
  @override
  State createState() => UploadS3State();
}

class UploadS3State extends State<UploadS3Screen> {

  static const platform = const MethodChannel("com.example.flutter_app/main");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('upload s3'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(onPressed: () => signIn(), child: Text('signin')),
            FlatButton(onPressed: () => signOut(), child: Text('signOut')),
            FlatButton(onPressed: () => uploadS3(), child: Text('upload')),
          ],
        ),
      ),
    );
  }

  uploadS3() async {
    await platform.invokeMethod("uploadImage");
  }

  signIn() {
    final userPool = new CognitoUserPool(
        "ap-southeast-1_GwZ4hQOVY", '3uhjka1l7iopcc30amfgrh1ja6');

    final cognitoUser = new CognitoUser("conghua2411@yopmail.com", userPool);

    final authDetails =
      AuthenticationDetails(username: "conghua2411@yopmail.com", password: "111111");

    cognitoUser.authenticateUser(authDetails).then((session) {
      print("SUCCESS: ${session.isValid()}");
    }, onError: (e) {
      print("ERROR: ${e.toString()}");
    });
  }

  signOut() async {
    await platform.invokeMethod("signOutCognito");
  }
}
