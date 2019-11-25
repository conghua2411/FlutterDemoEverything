import 'package:flutter/material.dart';
import 'package:sns_wrapper/sns_service_export.dart';

class LocalSnsPackageDemo extends StatefulWidget {
  @override
  State createState() => LocalSnsPackageState();
}

class LocalSnsPackageState extends State<LocalSnsPackageDemo> {
  SnsService snsService = SnsService();

  @override
  void initState() {
    super.initState();

    Set<SocialLoginType> listSocialSupport = Set();
    listSocialSupport.add(SocialLoginType.FACEBOOK);
    listSocialSupport.add(SocialLoginType.GOOGLE);
    listSocialSupport.add(SocialLoginType.KAKAO);
    listSocialSupport.add(SocialLoginType.LINE);

    snsService = SnsService();

    snsService.initFacebook();
    snsService.initGoogle();
    snsService.initKakao();
//    snsService.initLine('1653555607');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LocalSnsPackageDemo'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.blue,
                child: Text('Facebook login'),
                onPressed: () {
                  snsService.loginWithType(SocialLoginType.FACEBOOK).then(
                      (userSocial) {
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
                  snsService.loginWithType(SocialLoginType.GOOGLE).then(
                      (userSocial) {
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
                  snsService.loginWithType(SocialLoginType.KAKAO).then(
                      (userSocial) {
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
                  snsService.loginWithType(SocialLoginType.LINE).then(
                      (userSocial) {
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
                  snsService.getTokenWithType(SocialLoginType.FACEBOOK).then(
                      (tokenSocial) {
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
                  snsService.getTokenWithType(SocialLoginType.GOOGLE).then(
                      (tokenSocial) {
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
                  snsService.getTokenWithType(SocialLoginType.KAKAO).then(
                      (tokenSocial) {
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
                  snsService.getTokenWithType(SocialLoginType.LINE).then(
                      (tokenSocial) {
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
                  snsService.logoutWithType(SocialLoginType.FACEBOOK).then(
                      (logoutStatus) {
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
                  snsService.logoutWithType(SocialLoginType.GOOGLE).then(
                      (logoutStatus) {
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
                  snsService.logoutWithType(SocialLoginType.KAKAO).then(
                      (logoutStatus) {
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
                onPressed: _lineLogout,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _lineLogout() {
    snsService.logoutWithType(SocialLoginType.LINE).then((logoutStatus) {
      print('Line logout: success - $logoutStatus');
    }, onError: (e) {
      print('Line logout: error - $e');
    });
  }
}
