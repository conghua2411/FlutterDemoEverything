import 'package:flutter/material.dart';
import 'package:flutter_app/social_login/social_login/social_login_service.dart';

class SocialLoginServiceDemo extends StatefulWidget {

  @override
  State createState() => SocialLoginServiceDemoState();
}

class SocialLoginServiceDemoState extends State<SocialLoginServiceDemo> {

  SocialLoginService socialLoginService;

  @override
  void initState() {
    super.initState();

    Set<SocialLoginType> listSocialSupport = Set();
    listSocialSupport.add(SocialLoginType.FACEBOOK);
    listSocialSupport.add(SocialLoginType.GOOGLE);
    listSocialSupport.add(SocialLoginType.KAKAO);
    listSocialSupport.add(SocialLoginType.LINE);

    socialLoginService = SocialLoginService();
    socialLoginService.initSocialLogin(listSocialSupport);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SocialLoginServiceDemo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.blue,
                child: Text('Facebook login'),
                onPressed: () {
                  socialLoginService.loginWithType(SocialLoginType.FACEBOOK).then((userSocial) {
                    print('Facebook login: success - $userSocial');
                  }, onError: (e) {
                    print('Facebook login: error - $e');
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.blue,
                child: Text('Google login'),
                onPressed: () {
                  socialLoginService.loginWithType(SocialLoginType.GOOGLE).then((userSocial) {
                    print('Google login: success - $userSocial');
                  }, onError: (e) {
                    print('Google login: error - $e');
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.blue,
                child: Text('Kakao login'),
                onPressed: () {
                  socialLoginService.loginWithType(SocialLoginType.KAKAO).then((userSocial) {
                    print('Kakao login: success - $userSocial');
                  }, onError: (e) {
                    print('Kakao login: error - $e');
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.blue,
                child: Text('Line login'),
                onPressed: () {
                  socialLoginService.loginWithType(SocialLoginType.LINE).then((userSocial) {
                    print('Line login: success - $userSocial');
                  }, onError: (e) {
                    print('Line login: error - $e');
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.blue,
                child: Text('Facebook token'),
                onPressed: () {
                  socialLoginService.getTokenWithType(SocialLoginType.FACEBOOK).then((tokenSocial) {
                    print('Facebook token: success - $tokenSocial');
                  }, onError: (e) {
                    print('Facebook token: error - $e');
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.blue,
                child: Text('Google token'),
                onPressed: () {
                  socialLoginService.getTokenWithType(SocialLoginType.GOOGLE).then((tokenSocial) {
                    print('Google token: success - $tokenSocial');
                  }, onError: (e) {
                    print('Google token: error - $e');
                  }).catchError((e) {
                    print('Google token: catchError - $e');
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.blue,
                child: Text('Kakao token'),
                onPressed: () {
                  socialLoginService.getTokenWithType(SocialLoginType.KAKAO).then((tokenSocial) {
                    print('Kakao token: success - $tokenSocial');
                  }, onError: (e) {
                    print('Kakao token: error - $e');
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.blue,
                child: Text('Line token'),
                onPressed: () {
                  socialLoginService.getTokenWithType(SocialLoginType.LINE).then((tokenSocial) {
                    print('Line token: success - $tokenSocial');
                  }, onError: (e) {
                    print('Line token: error - $e');
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.blue,
                child: Text('Facebook logout'),
                onPressed: () {
                  socialLoginService.logoutWithType(SocialLoginType.FACEBOOK).then((logoutStatus) {
                    print('Facebook logout: success - $logoutStatus');
                  }, onError: (e) {
                    print('Facebook logout: error - $e');
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.blue,
                child: Text('Google logout'),
                onPressed: () {
                  socialLoginService.logoutWithType(SocialLoginType.GOOGLE).then((logoutStatus) {
                    print('Google logout: success - $logoutStatus');
                  }, onError: (e) {
                    print('Google logout: error - $e');
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.blue,
                child: Text('Kakao logout'),
                onPressed: () {
                  socialLoginService.logoutWithType(SocialLoginType.KAKAO).then((logoutStatus) {
                    print('Kakao logout: success - $logoutStatus');
                  }, onError: (e) {
                    print('Kakao logout: error - $e');
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.blue,
                child: Text('Line logout'),
                onPressed: () {
                  socialLoginService.logoutWithType(SocialLoginType.LINE).then((logoutStatus) {
                    print('Line logout: success - $logoutStatus');
                  }, onError: (e) {
                    print('Line logout: error - $e');
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}