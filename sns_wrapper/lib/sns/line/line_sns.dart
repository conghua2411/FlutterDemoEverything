import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:sns_wrapper/model/token_social.dart';
import 'package:sns_wrapper/model/user_social.dart';
import 'package:sns_wrapper/sns/base/base_sns.dart';

/// set up line sdk only once - 1653555607 - channelId from line developer
/// await LineSDK.instance.setup('1653555607');
class LineSNS extends BaseSNS {
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
      Future.error('LineSDK is not init');
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
      Future.error('LineSDK is not init');
    }
    return LineSDK.instance.logout().then((_) {
      return true;
    });
  }

  @override
  Future<UserSocial> login() {
    if (isReady == false) {
      Future.error('LineSDK is not init');
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