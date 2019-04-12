import 'package:meta/meta.dart';

class AuthRepo {
  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }

  Future<bool> isLoggedIn() async {
    await Future.delayed(Duration(seconds: 1));
    return true;
  }
}
