import 'dart:async';

import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:amazon_cognito_identity_dart/sig_v4.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

final userPool =
    new CognitoUserPool('userPoolId', 'clientId');

final cognitoUser = CognitoUser('username', userPool);

final graphQlEndpoint =
    'graphQlEndpoint';

final endpoint = 'endpoint';

final region = 'region';

final credentials = CognitoCredentials(
    'identityPoolId', userPool);

class AwsCognitoProd extends StatefulWidget {
  @override
  State createState() => AwsCognitoProdState();
}

class AwsCognitoProdState extends State<AwsCognitoProd> {
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
        title: Text('AwsCognitoProd'),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  child: Text('SignIn'),
                  onPressed: _signIn,
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  child: Text('SignOut'),
                  onPressed: _signOut,
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  child: Text('testGraphQl'),
                  onPressed: _testGraphQl,
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  child: Text('changeName'),
                  onPressed: _changeName,
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('log'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder<String>(
                  initialData: 'init',
                  stream: _streamLog.stream,
                  builder: (context, snapshot) {
                    return Text('${snapshot.data}');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() {
    cognitoUser
        .authenticateUser(AuthenticationDetails(
            username: 'username', password: 'replace password'))
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
        user(username: "username") {
          id
          username
          pName
        }
      }
    ''';

    if (currentSession != null) {
      credentials.getAwsCredentials(currentSession.idToken.jwtToken).then((_) {
        print('_testGraphQl: accessKeyId - ${credentials.accessKeyId}');
        print('_testGraphQl: secretAccessKey - ${credentials.secretAccessKey}');
        print('_testGraphQl: sessionToken - ${credentials.sessionToken}');

        log =
            '_testGraphQl: \naccessKeyId - ${credentials.accessKeyId}\nsecretAccessKey - ${credentials.secretAccessKey}\nsessionToken - ${credentials.sessionToken}';

        _streamLog.add(log);

        var awsSigV4Client = AwsSigV4Client(
            credentials.accessKeyId, credentials.secretAccessKey, endpoint,
            sessionToken: credentials.sessionToken, region: region);
        var signedRequest = SigV4Request(
          awsSigV4Client,
          method: 'POST',
          path: '/internal-graphql',
          headers: {
            'Content-Type': 'application/graphql; charset=utf-8',
            'can-id-token': currentSession.idToken.jwtToken,
          },
          body: {'operationName': 'user', 'query': query},
        );

        print('graphql url : ${signedRequest.url}');

        log += '\ngraphql url : ${signedRequest.url}';

        _streamLog.add(log);

        http
            .post(signedRequest.url,
                headers: signedRequest.headers, body: signedRequest.body)
            .then((response) {
          print('http.post success : ${response.body}');
          log += '\nhttp.post success : ${response.body}';
          _streamLog.add(log);
        }, onError: (e) {
          print('http.post error : $e');
          log += '\nhttp.post error : $e';
          _streamLog.add(log);
        });
      }, onError: (e) {
        print('_testGraphQl: error - $e');
        log += '\n_testGraphQl: error - $e';
        _streamLog.add(log);
      });
    }
  }

  void _changeName() {
    String query = '''
      mutation updateUserSetting {
        updateUserSetting(userInput: {name: "alo321"}) {
          name
        }
      }
    ''';

    if (currentSession != null) {
      credentials.getAwsCredentials(currentSession.idToken.jwtToken).then((_) {
        print('_testGraphQl: accessKeyId - ${credentials.accessKeyId}');
        print('_testGraphQl: secretAccessKey - ${credentials.secretAccessKey}');
        print('_testGraphQl: sessionToken - ${credentials.sessionToken}');

        log =
            '_testGraphQl: \naccessKeyId - ${credentials.accessKeyId}\nsecretAccessKey - ${credentials.secretAccessKey}\nsessionToken - ${credentials.sessionToken}';

        _streamLog.add(log);

        var awsSigV4Client = AwsSigV4Client(
            credentials.accessKeyId, credentials.secretAccessKey, endpoint,
            sessionToken: credentials.sessionToken, region: region);
        var signedRequest = SigV4Request(
          awsSigV4Client,
          method: 'POST',
          path: '/internal-graphql',
          headers: {
            'Content-Type': 'application/graphql; charset=utf-8',
            'can-id-token': currentSession.idToken.jwtToken,
          },
          body: {'operationName': 'updateUserSetting', 'query': query},
        );

        print('graphql url : ${signedRequest.url}');

        log += '\ngraphql url : ${signedRequest.url}';

        _streamLog.add(log);

        http
            .post(signedRequest.url,
                headers: signedRequest.headers, body: signedRequest.body)
            .then((response) {
          print('http.post success : ${response.body}');

          log += '\nhttp.post success : ${response.body}';
          _streamLog.add(log);
        }, onError: (e) {
          print('http.post error : $e');
          log += '\nhttp.post error : $e';
          _streamLog.add(log);
        });
      }, onError: (e) {
        print('_testGraphQl: error - $e');
        log += '\n_testGraphQl: error - $e';
        _streamLog.add(log);
      });
    }
  }
}
