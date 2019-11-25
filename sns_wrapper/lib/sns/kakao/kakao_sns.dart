import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:sns_wrapper/model/token_social.dart';
import 'package:sns_wrapper/model/user_social.dart';
import 'package:sns_wrapper/sns/base/base_sns.dart';

class KakaoSNS extends BaseSNS {
  FlutterKakaoLogin _kakaoLogin;

  @override
  void init() {
    _kakaoLogin = FlutterKakaoLogin();
  }

  @override
  Future<TokenSocial> getCurrentToken() {
    return _kakaoLogin.currentAccessToken.then((result) {
      Map<String, dynamic> tokenData = Map();
      tokenData['accesstoken'] = result.token;
      return TokenSocial(
        accessToken: tokenData['accesstoken'],
      );
    });
  }

  @override
  Future<bool> logout() {
    return _kakaoLogin.logOut().then((result) {
      return result.status == KakaoLoginStatus.loggedOut;
    });
  }

  @override
  Future<UserSocial> login() {
    return _kakaoLogin.logIn().then(
          (result) {
        switch (result.status) {
          case KakaoLoginStatus.loggedIn:
            return _kakaoLogin.currentAccessToken.then(
                  (result) {
                Map<String, dynamic> userData = Map();
                userData['accesstoken'] = result.token;
                return _kakaoLogin.getUserMe().then((result) {
                  Map<String, dynamic> profile = Map();
                  profile['id'] = result.account.userID;
                  profile['name'] = result.account.userNickname;
                  profile['mail'] = result.account.userEmail;
                  return UserSocial(
                    id: profile['id'],
                    name: profile['name'],
                    email: profile['mail'],
                    tokenSocial: TokenSocial(
                      accessToken: userData['accesstoken'],
                    ),
                  );
                });
              },
            );
          case KakaoLoginStatus.loggedOut:
            throw ('KakaoLoginStatus.loggedOut');
          case KakaoLoginStatus.error:
            throw ('KakaoLoginStatus.error');
          default:
            throw ('wtf is this');
        }
      },
    );
  }
}
