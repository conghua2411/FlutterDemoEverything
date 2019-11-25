import 'package:google_sign_in/google_sign_in.dart';
import 'package:sns_wrapper/model/token_social.dart';
import 'package:sns_wrapper/model/user_social.dart';
import 'package:sns_wrapper/sns/base/base_sns.dart';

class GoogleSNS extends BaseSNS {
  GoogleSignIn _googleSignIn;

  @override
  void init() {
    _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
        'https://www.googleapis.com/auth/userinfo.profile',
      ],
    );
  }

  @override
  Future<UserSocial> login() {
    return _googleSignIn.signIn().then((googleSignInAccount) {
      Map<String, dynamic> profile = Map();
      profile['id'] = googleSignInAccount.id;
      profile['name'] = googleSignInAccount.displayName;
      profile['email'] = googleSignInAccount.email;
      return googleSignInAccount.authentication.then((authentication) {
        Map<String, dynamic> dataUser = Map();
        dataUser['accesstoken'] = authentication.accessToken;
        dataUser['idtoken'] = authentication.idToken;
        dataUser['profile'] = profile;
        return UserSocial(
          id: profile['id'],
          name: profile['name'],
          email: profile['email'],
          tokenSocial: TokenSocial(
            idToken: dataUser['idtoken'],
            accessToken: dataUser['accesstoken'],
          ),
        );
      }, onError: (e) {
        throw (e);
      });
    }, onError: (e) {
      throw (e);
    });
  }

  @override
  Future<TokenSocial> getCurrentToken() {
    if (_googleSignIn.currentUser == null) {
      return Future.error('currentUser is null');
    }
    return _googleSignIn.currentUser.authentication.then((authentication) {
      Map<String, dynamic> tokenData = Map();

      tokenData['accesstoken'] = authentication.accessToken;

      tokenData['idtoken'] = authentication.idToken;

      return TokenSocial(
        accessToken: tokenData['accesstoken'],
        idToken: tokenData['idtoken'],
      );
    });
  }

  @override
  Future<bool> logout() {
    return _googleSignIn.signOut().then((googleSignInAccount) {
      return googleSignInAccount == null;
    });
  }
}