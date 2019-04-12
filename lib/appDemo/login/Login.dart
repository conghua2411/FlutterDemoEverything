import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/appDemo/auth/Auth.dart';
import 'package:flutter_app/appDemo/login/bloc/LoginBloc.dart';
import 'package:flutter_app/appDemo/main/main.dart';
import 'package:flutter_app/appDemo/signup/SignUp.dart';
import 'package:flutter_app/transition/SlideTransition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  onTransition(Transition transition) {
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print(error);
  }
}

class Login extends StatefulWidget {
  @override
  State createState() => LoginState();
}

class LoginState extends State<Login> {
  LoginBloc _loginBloc = LoginBloc();

  String username = "", password = "";

  @override
  void initState() {
    BlocSupervisor().delegate = SimpleBlocDelegate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocProviderTree(
        blocProviders: [
          BlocProvider<LoginBloc>(bloc: _loginBloc),
        ],
        child: BlocBuilder(
            bloc: _loginBloc,
            builder: (_, LoginBlocState state) {
              if (state is LoginErrorState) {
                print("error login!!!!");
              } else if (state is LoginSuccessState) {
                _openMain();
              }
              return Stack(
                children: <Widget>[
                  Scaffold(
                    appBar: AppBar(
                      title: Text('Login'),
                    ),
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            size: 150.0,
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: TextField(
                              onChanged: (text) {
                                username = text;
                              },
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide:
                                    BorderSide(color: Colors.blue, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide:
                                    BorderSide(color: Colors.red, width: 2.0),
                                  ),
                                  hintText: 'username',
                                  contentPadding: EdgeInsets.only(
                                      left: 35.0,
                                      right: 20.0,
                                      top: 20.0,
                                      bottom: 20.0),
                                  labelText: 'username',
                                  labelStyle: TextStyle(fontSize: 14.0)),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: TextField(
                              onChanged: (text) {
                                password = text;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide:
                                  BorderSide(color: Colors.blue, width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                                ),
                                hintText: 'password',
                                contentPadding: EdgeInsets.only(
                                    left: 35.0,
                                    right: 20.0,
                                    top: 20.0,
                                    bottom: 20.0),
                                labelText: 'password',
                                labelStyle: TextStyle(fontSize: 14.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50.0,
                              child: RaisedButton(
                                onPressed: () {
                                  _onLoginButtonPressed();
                                },
                                child: Text('login'),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50.0,
                              child: RaisedButton(
                                onPressed: () {
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
//                                    Navigator.pushReplacement(context, CustomRoute(builder: (context) => SignUp()));
                                    Navigator.pushReplacement(context, SlideRightRoute(widget: SignUp()));
                                  });
                                },
                                child: Text('signup'),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: state is LoginLoadingState ? CircularProgressIndicator() : null,
                  ),
                ],
              );
            }));
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  void _openMain() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Main(username: username, password: password,)));
    });
    _loginBloc.dispatch(LoginComplete());
  }

  void _onLoginButtonPressed() {
      _loginBloc.dispatch(LoginEvent(username, password));
  }
}
