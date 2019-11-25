import 'package:flutter_app/social_login/social_login/base_social_login/base_social_login.dart';
import 'package:flutter_app/social_login/social_login/user_social_data/token_social.dart';
import 'package:flutter_app/social_login/social_login/user_social_data/user_social.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';

class KakaoSocialLogin extends BaseSocialLogin {
  FlutterKakaoLogin _kakaoLogin;

  @override
  void init() {
    _kakaoLogin = FlutterKakaoLogin();
  }

  @override
  Future<TokenSocial> getCurrentToken() {
    if (_kakaoLogin == null) {
      throw ('_kakaoLogin is null');
    }
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
    if (_kakaoLogin == null) {
      throw ('_kakaoLogin is null');
    }
    return _kakaoLogin.logOut().then((result) {
      return result.status == KakaoLoginStatus.loggedOut;
    });
  }

  @override
  Future<UserSocial> login() {
    if (_kakaoLogin == null) {
      throw ('_kakaoLogin is null');
    }
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
