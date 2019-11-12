import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SocialLoginDemo extends StatefulWidget {
  @override
  State createState() => SocialLoginState();
}

class SocialLoginState extends State<SocialLoginDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Social Login State'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FacebookLoginWidget(
              child: Container(
                width: 200,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text('Facebook'),
                ),
              ),
              fbResult: (message) {
                print('callback result: $message');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FacebookLoginWidget extends StatefulWidget {
  final Widget child;
  final Function(String) fbResult;

  FacebookLoginWidget({
    @required this.child,
    @required this.fbResult,
  });

  @override
  State createState() => FacebookLoginState();
}

class FacebookLoginState extends State<FacebookLoginWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onLoginFbClick,
      child: widget.child,
    );
  }

  _onLoginFbClick() {
    final facebookLogin = FacebookLogin();

    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;

    facebookLogin.logIn(['email']).then((result) {
      print('facebookLogin: success - ${result.status}');

      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          http
              .get(
                  'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,gender&access_token=${result.accessToken.token}')
              .then((response) {

                //,link,profile_pic

            final profile = jsonDecode(response.body);

            widget.fbResult(profile.toString());
          }, onError: (e) {
            widget.fbResult('getProfile Error');
          });
          break;
        case FacebookLoginStatus.error:
          widget.fbResult('FacebookLoginStatus.error');
          break;
        case FacebookLoginStatus.cancelledByUser:
          widget.fbResult('FacebookLoginStatus.cancelledByUser');
          break;
      }
    }, onError: (e) {
      print('facebookLogin: error - $e');
    });
  }
}
