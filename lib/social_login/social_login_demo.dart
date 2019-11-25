import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SocialLoginDemo extends StatefulWidget {
  @override
  State createState() => SocialLoginState();
}

class SocialLoginState extends State<SocialLoginDemo> {
  String profileData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Social Login State'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 14),
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

                setState(() {
                  profileData = message;
                });
              },
            ),
            SizedBox(height: 14),
            GoogleLoginWidget(
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
                  child: Text('Google'),
                ),
              ),
              googleLoginResult: (message) {
                setState(() {
                  profileData = message;
                });
              },
            ),
            SizedBox(
              height: 14,
            ),
            KakaoLoginWidget(
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
                  child: Text('Kakao'),
                ),
              ),
              kakaoLoginResult: (message) {
                setState(() {
                  profileData = message;
                });
              },
            ),
            SizedBox(
              height: 14,
            ),
            LineLoginView(
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
                  child: Text('Line'),
                ),
              ),
              lineLoginResult: (message) {
                setState(() {
                  profileData = message;
                });
              },
            ),
            Text(profileData),
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

class GoogleLoginWidget extends StatefulWidget {
  final Widget child;
  final Function(String) googleLoginResult;

  GoogleLoginWidget({
    @required this.child,
    @required this.googleLoginResult,
  });

  @override
  State createState() => GoogleLoginState();
}

class GoogleLoginState extends State<GoogleLoginWidget> {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  _onLoginGoogleClick() {
    String msg = '';
    _googleSignIn.signIn().then((googleSignInAccount) {
      print('_onLoginGoogleClick: success - ${googleSignInAccount.id}');

      msg += '\n_onLoginGoogleClick: success - ${googleSignInAccount.id}'
          '\n';

      googleSignInAccount.authentication.then((authentication) {
        print(
            '_onLoginGoogleClick: authentication: sucess - ${authentication.accessToken}');
        msg +=
            '\n_onLoginGoogleClick: authentication: sucess - ${authentication.accessToken}';
        widget.googleLoginResult(msg);
      }, onError: (e) {
        print('_onLoginGoogleClick: authentication: error - $e');
        msg += '\n_onLoginGoogleClick: authentication: error - $e';
        widget.googleLoginResult(msg);
      });
    }, onError: (e) {
      print('_onLoginGoogleClick: error - $e');
      msg += '\n_onLoginGoogleClick: error - $e';
      widget.googleLoginResult(msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onLoginGoogleClick,
      child: widget.child,
    );
  }
}

class KakaoLoginWidget extends StatefulWidget {
  final Widget child;
  final Function(String) kakaoLoginResult;

  KakaoLoginWidget({
    @required this.child,
    @required this.kakaoLoginResult,
  });

  @override
  State createState() => KakaoLoginState();
}

class KakaoLoginState extends State<KakaoLoginWidget> {
  FlutterKakaoLogin kakaoLogin = FlutterKakaoLogin();

  _kakaoLogin() {
    String msg = '';

    kakaoLogin.logIn().then((result) {
      switch (result.status) {
        case KakaoLoginStatus.loggedIn:
          msg += '\n_kakaoLogin: logIn: KakaoLoginStatus.loggedIn';
          kakaoLogin.currentAccessToken.then((accessToken) {
            msg +=
                '\n_kakaoLogin: logIn: currentAccessToken: ${accessToken.token}';
            kakaoLogin.getUserMe().then((me) {
              msg +=
                  '\n_kakaoLogin: logIn: getUserMe: ${me.account.userID} -- ${me.account.userEmail}';
              widget.kakaoLoginResult(msg);
            }, onError: (e) {
              msg += '\n_kakaoLogin: logIn: getUserMe: error: $e';
              widget.kakaoLoginResult(msg);
            });
          }, onError: (e) {
            msg += '\n_kakaoLogin: logIn: currentAccessToken: error: $e';
            widget.kakaoLoginResult(msg);
          });
          break;
        case KakaoLoginStatus.loggedOut:
          msg += '\n_kakaoLogin: logIn: KakaoLoginStatus.loggedOut';
          widget.kakaoLoginResult(msg);
          break;
        case KakaoLoginStatus.error:
          msg += '\n_kakaoLogin: logIn: KakaoLoginStatus.error';
          widget.kakaoLoginResult(msg);
          break;
      }
    }, onError: (e) {
      msg += '\n_kakaoLogin: error: $e';
      widget.kakaoLoginResult(msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _kakaoLogin,
      child: widget.child,
    );
  }
}

class LineLoginView extends StatefulWidget {
  final Widget child;
  final Function(String) lineLoginResult;

  LineLoginView({
    @required this.child,
    @required this.lineLoginResult,
  });

  @override
  State createState() => LineLoginState();
}

class LineLoginState extends State<LineLoginView> {

  bool isReady = false;


  @override
  void initState() {
    super.initState();
    //  set up line sdk only once - 1653555607
    LineSDK.instance.setup('1653555607').then((_) {
      isReady = true;
    });
  }

  _lineLogin() {
    if (isReady) {
      String msg = '';

      LineSDK.instance.login(scopes: ["profile", "openid", "email"]).then((
          result) {
        msg +=
        '\n_lineLogin: success: ${result.accessToken.value} --- userId: ${result
            .userProfile.userId}';
        widget.lineLoginResult(msg);
      }, onError: (e) {
        msg += '\n_lineLogin: error: $e';
        widget.lineLoginResult(msg);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _lineLogin,
      child: widget.child,
    );
  }
}
