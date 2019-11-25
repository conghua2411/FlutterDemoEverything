class TokenSocial {
  String accessToken;
  String idToken;

  TokenSocial({
    this.accessToken,
    this.idToken,
  });

  @override
  String toString() {
    Map<String, String> map = Map();
    map['accessToken'] = accessToken;
    map['idToken'] = idToken;
    return map.toString();
  }
}
