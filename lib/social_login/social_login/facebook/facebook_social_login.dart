import 'dart:convert';

import 'package:flutter_app/social_login/social_login/base_social_login/base_social_login.dart';
import 'package:flutter_app/social_login/social_login/user_social_data/token_social.dart';
import 'package:flutter_app/social_login/social_login/user_social_data/user_social.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

class FacebookSocialLogin extends BaseSocialLogin {
  FacebookLogin _facebookLogin;

  @override
  void init() {
    _facebookLogin = FacebookLogin();
  }

  @override
  Future<UserSocial> login() {
    if (_facebookLogin == null) {
      throw ('_facebookLogin is null');
    }
    return _facebookLogin.logIn(['email']).then((result) {
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          return http
              .get(
                  'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,gender&access_token=${result.accessToken.token}')
              .then((response) {
            Map<String, dynamic> dataUser = Map();

            dataUser['accesstoken'] = result.accessToken.token;

            dataUser['profile'] = jsonDecode(response.body);

            return UserSocial(
                id: dataUser['profile']['id'],
                name: dataUser['profile']['name'],
                email: dataUser['profile']['email'],
                tokenSocial: TokenSocial(
                  accessToken: dataUser['accesstoken'],
                ),);
          }, onError: (e) {
            throw (e);
          });
        case FacebookLoginStatus.error:
          throw ('FacebookLoginStatus.error - ${result.errorMessage}');
        case FacebookLoginStatus.cancelledByUser:
          throw ('FacebookLoginStatus.cancelledByUser - ${result.errorMessage}');
        default:
          throw ('wtf is this');
      }
    });
  }

  @override
  Future<TokenSocial> getCurrentToken() {
    if (_facebookLogin == null) {
      throw ('_facebookLogin is null');
    }
    return _facebookLogin.currentAccessToken.then((result) {
      if (result == null) {
        throw ('User not login');
      } else {
        Map<String, dynamic> tokenData = Map();
        tokenData['accesstoken'] = result.token;
        return TokenSocial(
          accessToken: tokenData['accesstoken'],
        );
      }
    });
  }

  @override
  Future<bool> logout() {
    if (_facebookLogin == null) {
      throw ('_facebookLogin is null');
    }
    return _facebookLogin.logOut().then((_) {
      return true;
    });
  }
}
