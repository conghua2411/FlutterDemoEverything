import 'package:flutter/material.dart';
import 'package:amazon_cognito_identity_dart/cognito.dart';

const _awsUserPoolId = 'ap-southeast-1_GwZ4hQOVY';
const _awsClientId = '4g9ejtj8oh87vq4mdqdhn0ns2j';

const _identityPoolId = 'ap-southeast-1:25005517-9ed3-44e5-b9a3-a143b0f4d457';

// Setup endpoints here:
const _region = 'ap-southeast-1';
const _endpoint =
    'https://grfo19kcbl.execute-api.ap-southeast-1.amazonaws.com/m1/internal-graphql-dev/';

// secret: 1uf6e4tm4h4kefrii3tsq8928jde0k1q03fqkevhq2u61kcbvbc6

final userPool = new CognitoUserPool(_awsUserPoolId, _awsClientId);

class CognitoScreen extends StatefulWidget {
  @override
  State createState() => CognitoState();
}

class CognitoState extends State<CognitoScreen> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cognito'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'email'),
            ),
            TextField(
              controller: pwController,
              decoration: InputDecoration(hintText: 'password'),
            ),
            FlatButton(
              child: Text('signup'),
              onPressed: signUp,
            ),
          ],
        ),
      ),
    );
  }

  Future<String> signUp() async {
    CognitoUserPoolData data;
    data = await userPool.signUp(emailController.text, pwController.text);

    return data.userConfirmed.toString();
  }
}
