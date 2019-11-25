import 'package:sns_wrapper/model/token_social.dart';

class UserSocial {
  TokenSocial tokenSocial;
  String id;
  String name;
  String email;

  UserSocial({
    this.id,
    this.name,
    this.email,
    this.tokenSocial,
  });

  @override
  String toString() {
    Map<String, String> map = Map();
    map['tokenSocial'] = tokenSocial.toString();
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    return map.toString();
  }
}