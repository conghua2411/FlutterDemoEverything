import 'package:sns_wrapper/model/token_social.dart';
import 'package:sns_wrapper/model/user_social.dart';
import 'package:sns_wrapper/sns/facebook/facebook_sns.dart';
import 'package:sns_wrapper/sns/google/google_sns.dart';
import 'package:sns_wrapper/sns/kakao/kakao_sns.dart';
import 'package:sns_wrapper/sns/line/line_sns.dart';
import 'package:sns_wrapper/sns/base/base_sns.dart';


enum SocialLoginType {
  FACEBOOK,
  GOOGLE,
  KAKAO,
  LINE,
}

class SnsService {
  List<SocialLoginType> listSocialSupport;

  FacebookSNS facebookSns;
  GoogleSNS googleSns;
  KakaoSNS kakaoSns;
  LineSNS lineSns;

  Map<SocialLoginType, BaseSNS> mapSnsLogin = Map();

  @deprecated
  initSocialLogin(Set<SocialLoginType> supportLoginType) {
    supportLoginType.forEach((type) {
      switch (type) {
        case SocialLoginType.FACEBOOK:
          facebookSns = FacebookSNS();
          facebookSns.init();
          break;
        case SocialLoginType.GOOGLE:
          googleSns = GoogleSNS();
          googleSns.init();
          break;
        case SocialLoginType.KAKAO:
          kakaoSns = KakaoSNS();
          kakaoSns.init();
          break;
        case SocialLoginType.LINE:
          lineSns = LineSNS();
          lineSns.setChannelId('1653555607');
          lineSns.init();
          break;
      }
    });
  }

  initFacebook() {
    facebookSns = FacebookSNS();
    facebookSns.init();
    mapSnsLogin[SocialLoginType.FACEBOOK] = facebookSns;
  }

  initGoogle() {
    googleSns = GoogleSNS();
    googleSns.init();
    mapSnsLogin[SocialLoginType.GOOGLE] = googleSns;
  }

  initKakao() {
    kakaoSns = KakaoSNS();
    kakaoSns.init();
    mapSnsLogin[SocialLoginType.KAKAO] = kakaoSns;
  }

  initLine(String channelId) {
    lineSns = LineSNS();
    lineSns.setChannelId(channelId);
    lineSns.init();
    mapSnsLogin[SocialLoginType.LINE] = lineSns;
  }

  Future<UserSocial> loginWithType(SocialLoginType type) {
    if (mapSnsLogin[type] == null) {
      return Future.error('${type.toString()} is not init');
    } else {
      return mapSnsLogin[type].login();
    }
  }

  Future<bool> logoutWithType(SocialLoginType type) {
    if (mapSnsLogin[type] == null) {
      return Future.error('${type.toString()} is not init');
    } else {
      return mapSnsLogin[type].logout();
    }
  }

  Future<TokenSocial> getTokenWithType(SocialLoginType type) {
    if (mapSnsLogin[type] == null) {
      return Future.error('${type.toString()} is not init');
    } else {
      return mapSnsLogin[type].getCurrentToken();
    }
  }
}