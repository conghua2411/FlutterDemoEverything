import 'dart:async';
import 'dart:convert';

import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:amazon_cognito_identity_dart/sig_v4.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;

final userPool =
    CognitoUserPool('ap-southeast-1_GwZ4hQOVY', '707f1vt23s1jnleakfvliufntk');

final cognitoUser = CognitoUser('conghua2411@yopmail.com', userPool);

final graphQlEndpoint =
    'https://grfo19kcbl.execute-api.ap-southeast-1.amazonaws.com/m1/internal-graphql';

final endpoint =
    'https://grfo19kcbl.execute-api.ap-southeast-1.amazonaws.com/m1';

final region = 'ap-southeast-1';

final credentials = CognitoCredentials(
    'ap-southeast-1:25005517-9ed3-44e5-b9a3-a143b0f4d457', userPool);

class AwsCognitoDevUploadS3 extends StatefulWidget {
  @override
  State createState() => AwsCognitoDevUploadS3State();
}

class AwsCognitoDevUploadS3State extends State<AwsCognitoDevUploadS3> {
  String log;

  StreamController<String> _streamLog = StreamController();

  CognitoUserSession currentSession;

  @override
  void dispose() {
    _streamLog.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AwsCognitoDevUploadS3'),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            child: Text('SignIn'),
            onPressed: signIn,
          ),
          FlatButton(
            child: Text('SignOut'),
            onPressed: _signOut,
          ),
          FlatButton(
            child: Text('testGraphQl'),
            onPressed: _testGraphQl,
          ),
          FlatButton(
            child: Text('uploadS3'),
            onPressed: _uploadS3,
          ),
          StreamBuilder<String>(
              initialData: '',
              stream: _streamLog.stream,
              builder: (context, snapshot) {
                return Text('asdasd');
              }),
        ],
      ),
    );
  }

  void signIn() {
    cognitoUser
        .authenticateUser(AuthenticationDetails(
            username: 'conghua2411@yopmail.com', password: '111111'))
        .then((session) {
      currentSession = session;
      print('_signIn: token - ${session.accessToken.jwtToken}');
      _streamLog.add('_signIn: token - ${session.accessToken.jwtToken}');
    }, onError: (e) {
      print('_signIn: error $e');
      _streamLog.add('_signIn: error - $e');
    });
  }

  void _signOut() {
    if (cognitoUser != null) {
      cognitoUser.signOut().then((_) {
        currentSession = null;
        print('_signOut: success');
        _streamLog.add('_signOut: success');
      }, onError: (e) {
        print('_signOut: error');
        _streamLog.add('_signOut: error');
      });
    }
  }

  void _testGraphQl() {
    String query = '''
      query user {
        user(username: "conghua2411@yopmail.com") {
          id
          username
          pName
        }
      }
    ''';
    if (currentSession != null) {
      http.post(graphQlEndpoint, headers: {
        'X-Api-Key': 'XsNWM6ee8P3guYquBFB4b6zwYqwvrrV82GP2uIiF',
        'can-id-token': currentSession.idToken.jwtToken
      }, body: {
        'operationName': 'user',
        'query': query
      }).then((response) {
        print('http.post success : ${response.body}');
        log += '\nhttp.post success : ${response.body}';
        _streamLog.add(log);
      }, onError: (e) {
        print('http.post error : $e');
        log += '\nhttp.post error : $e';
        _streamLog.add(log);
      });
    } else {
      _streamLog.add('currentSession = null');
    }
  }

  void _uploadS3() {
    ImagePicker.pickImage(source: ImageSource.gallery).then((file) async {
      await credentials.getAwsCredentials(currentSession.idToken.jwtToken);


      final stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
      final length = await file.length();

      final uri = Uri.parse(endpoint);
      final req = http.MultipartRequest("POST", uri);
//      req.headers.putIfAbsent('Content-Type', () => 'image/*');
      final multipartFile = http.MultipartFile('file', stream, length,
          filename: path.basename(file.path));

      final policy = Policy.fromS3PresignedPost(
          'protected/ap-southeast-1:31a7fecb-a07e-4ce3-90da-6931779e72a4/testUploadS3Rest.jpg',
          'crypto-badge-static-m1',
          15,
          credentials.accessKeyId,
          length,
          credentials.sessionToken,
          region: region);

      final key = SigV4.calculateSigningKey(
          credentials.secretAccessKey, policy.datetime, region, 's3');
      final signature = SigV4.calculateSignature(key, policy.encode());

      req.files.add(multipartFile);
      req.fields['key'] = policy.key;
      req.fields['acl'] = 'public-read';
      req.fields['X-Amz-Credential'] = policy.credential;
      req.fields['X-Amz-Algorithm'] = 'AWS4-HMAC-SHA256';
      req.fields['X-Amz-Date'] = policy.datetime;
      req.fields['Policy'] = policy.encode();
      req.fields['X-Amz-Signature'] = signature;
      req.fields['x-amz-security-token'] = credentials.sessionToken;

      try {
        final res = await req.send();
        await for (var value in res.stream.transform(utf8.decoder)) {
          print('UploadS3 success $value');
        }
      } catch (e) {
        print('UploadS3 catchError $e');
      }
    }, onError: (e) {
      print('ImagePicker: error $e');
    });
  }
}

class Policy {
  String expiration;
  String region;
  String bucket;
  String key;
  String credential;
  String datetime;
  String sessionToken;
  int maxFileSize;

  Policy(this.key, this.bucket, this.datetime, this.expiration, this.credential,
      this.maxFileSize, this.sessionToken,
      {this.region = 'ap-southeast-1'});

  factory Policy.fromS3PresignedPost(
    String key,
    String bucket,
    int expiryMinutes,
    String accessKeyId,
    int maxFileSize,
    String sessionToken, {
    String region,
  }) {
    final datetime = SigV4.generateDatetime();
    final expiration = (DateTime.now())
        .add(Duration(minutes: expiryMinutes))
        .toUtc()
        .toString()
        .split(' ')
        .join('T');
    final cred =
        '$accessKeyId/${SigV4.buildCredentialScope(datetime, region, 's3')}';
    final p = Policy(
        key, bucket, datetime, expiration, cred, maxFileSize, sessionToken,
        region: region);
    return p;
  }

  String encode() {
    final bytes = utf8.encode(toString());
    return base64.encode(bytes);
  }

  @override
  String toString() {
    return '''
    { "expiration": "${this.expiration}",
      "conditions": [
        {"bucket": "${this.bucket}"},
        ["starts-with", "\$key", "${this.key}"],
        {"acl": "public-read"},
        ["content-length-range", 1, ${this.maxFileSize}],
        {"x-amz-credential": "${this.credential}"},
        {"x-amz-algorithm": "AWS4-HMAC-SHA256"},
        {"x-amz-date": "${this.datetime}" },
        {"x-amz-security-token": "${this.sessionToken}" }
      ]
    }
    ''';
  }
}
