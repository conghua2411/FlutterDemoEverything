import 'package:flutter_app/social_login/social_login/user_social_data/token_social.dart';
import 'package:flutter_app/social_login/social_login/user_social_data/user_social.dart';

abstract class BaseSocialLogin {
  void init();
  Future<UserSocial> login();
  Future<bool> logout();
  Future<TokenSocial> getCurrentToken();
}