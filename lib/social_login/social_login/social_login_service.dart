import 'package:flutter_app/social_login/social_login/user_social_data/token_social.dart';
import 'package:flutter_app/social_login/social_login/user_social_data/user_social.dart';

import 'facebook/facebook_social_login.dart';
import 'google/google_social_login.dart';
import 'kakao/kakao_social_login.dart';
import 'line/line_social_login.dart';

enum SocialLoginType {
  FACEBOOK,
  GOOGLE,
  KAKAO,
  LINE,
}

class SocialLoginService {
  List<SocialLoginType> listSocialSupport;

  FacebookSocialLogin facebookSocialLogin;
  GoogleSocialLogin googleSocialLogin;
  KakaoSocialLogin kakaoSocialLogin;
  LineSocialLogin lineSocialLogin;

  initSocialLogin(Set<SocialLoginType> supportLoginType) {
    supportLoginType.forEach((type) {
      switch (type) {
        case SocialLoginType.FACEBOOK:
          facebookSocialLogin = FacebookSocialLogin();
          facebookSocialLogin.init();
          break;
        case SocialLoginType.GOOGLE:
          googleSocialLogin = GoogleSocialLogin();
          googleSocialLogin.init();
          break;
        case SocialLoginType.KAKAO:
          kakaoSocialLogin = KakaoSocialLogin();
          kakaoSocialLogin.init();
          break;
        case SocialLoginType.LINE:
          lineSocialLogin = LineSocialLogin();
          lineSocialLogin.setChannelId('1653555607');
          lineSocialLogin.init();
          break;
      }
    });
  }

  Future<UserSocial> loginWithType(SocialLoginType type) {
    switch (type) {
      case SocialLoginType.FACEBOOK:
        return facebookSocialLogin.login();
      case SocialLoginType.GOOGLE:
        return googleSocialLogin.login();
      case SocialLoginType.KAKAO:
        return kakaoSocialLogin.login();
      case SocialLoginType.LINE:
        return lineSocialLogin.login();
      default:
        throw ('Not support login type');
    }
  }

  Future<bool> logoutWithType(SocialLoginType type) {
    switch (type) {
      case SocialLoginType.FACEBOOK:
        return facebookSocialLogin.logout();
      case SocialLoginType.GOOGLE:
        return googleSocialLogin.logout();
      case SocialLoginType.KAKAO:
        return kakaoSocialLogin.logout();
      case SocialLoginType.LINE:
        return lineSocialLogin.logout();
      default:
        throw ('Not support login type');
    }
  }

  Future<TokenSocial> getTokenWithType(SocialLoginType type) {
    switch (type) {
      case SocialLoginType.FACEBOOK:
        return facebookSocialLogin.getCurrentToken();
      case SocialLoginType.GOOGLE:
        return googleSocialLogin.getCurrentToken();
      case SocialLoginType.KAKAO:
        return kakaoSocialLogin.getCurrentToken();
      case SocialLoginType.LINE:
        return lineSocialLogin.getCurrentToken();
      default:
        throw ('Not support login type');
    }
  }
}
