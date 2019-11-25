import 'package:sns_wrapper/model/token_social.dart';
import 'package:sns_wrapper/model/user_social.dart';

abstract class BaseSNS {
  void init();
  Future<UserSocial> login();
  Future<bool> logout();
  Future<TokenSocial> getCurrentToken();
}