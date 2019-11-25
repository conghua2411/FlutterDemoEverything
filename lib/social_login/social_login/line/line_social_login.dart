import 'package:flutter_app/social_login/social_login/base_social_login/base_social_login.dart';
import 'package:flutter_app/social_login/social_login/user_social_data/token_social.dart';
import 'package:flutter_app/social_login/social_login/user_social_data/user_social.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';

/// setup in main
/// set up line sdk only once - 1653555607 - channelId from line developer
/// await LineSDK.instance.setup('1653555607');
class LineSocialLogin extends BaseSocialLogin {
  bool isReady = false;

  String channelId;

  /// must set channelId first
  setChannelId(String channelId) {
    this.channelId = channelId;
  }

  @override
  void init() {
    if (channelId == null) {
      return;
    }
    LineSDK.instance.setup(channelId).then((_) {
      isReady = true;
    });
  }

  @override
  Future<TokenSocial> getCurrentToken() {
    if (isReady == false) {
      throw ('LineSDK is not init');
    }
    return LineSDK.instance.currentAccessToken.then((result) {
      Map<String, dynamic> tokenData = Map();
      tokenData['accesstoken'] = result.value;
      return TokenSocial(
        accessToken: tokenData['accesstoken'],
      );
    });
  }

  @override
  Future<bool> logout() {
    if (isReady == false) {
      throw ('LineSDK is not init');
    }
    return LineSDK.instance.logout().then((_) {
      return true;
    });
  }

  @override
  Future<UserSocial> login() {
    if (isReady == false) {
      throw ('LineSDK is not init');
    }
    return LineSDK.instance
        .login(scopes: ["profile", "openid", "email"]).then((result) {
      Map<String, dynamic> userData = Map();
      Map<String, dynamic> profile = Map();
      profile['id'] = result.userProfile.userId;
      profile['name'] = result.userProfile.displayName;
      userData['profile'] = profile;
      userData['accesstoken'] = result.accessToken.value;
      return UserSocial(
        id: profile['id'],
        name: profile['name'],
        tokenSocial: TokenSocial(
          accessToken: userData['accesstoken'],
        ),
      );
    });
  }
}
