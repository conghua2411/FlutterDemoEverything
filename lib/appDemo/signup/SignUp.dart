import 'package:flutter/material.dart';
import 'package:flutter_app/appDemo/auth/Auth.dart';
import 'package:flutter_app/appDemo/login/Login.dart';
import 'package:flutter_app/appDemo/main/main.dart';
import 'package:flutter_app/appDemo/signup/SignUpBloc.dart';
import 'package:flutter_app/transition/ScaleTransition.dart';
import 'package:flutter_app/transition/SlideTransition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  final SignUpBloc signUpBloc = new SignUpBloc();

  @override
  State createState() => SignUpState();
}

class SignUpState extends State<SignUp> {

  SignUpBloc get _signUpBloc => widget.signUpBloc;

  String username, password, confirmPassword;

  @override
  Widget build(BuildContext context) {

    return BlocProviderTree(
      blocProviders: [
        BlocProvider<SignUpBloc>(bloc: _signUpBloc),
      ],
      child: BlocBuilder(
          bloc: _signUpBloc,
          builder: (_, SignUpBlocState state) {
            if (state is SignUpSuccess) {
              _openMain();
            }

            return Stack(
              children: <Widget>[
                Scaffold(
                  appBar: AppBar(
                    title: Text('signup'),
                  ),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          size: 100.0,
                          color: Colors.blue,
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
                              labelStyle: TextStyle(fontSize: 14.0),
                            ),
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
                          EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                          child: TextField(
                            onChanged: (text) {
                              confirmPassword = text;
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
                              hintText: 'confirm password',
                              contentPadding: EdgeInsets.only(
                                  left: 35.0,
                                  right: 20.0,
                                  top: 20.0,
                                  bottom: 20.0),
                              labelText: 'confirm password',
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
                                if (password == confirmPassword) {
                                  _onSignUpButtonPressed();
                                } else {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('password error'),
                                      backgroundColor: Colors.red,
                                    ));
                                  });
                                }
                              },
                              child: Text('signUp'),
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
                                  Navigator.pushReplacement(context, CustomRoute(builder: (context) => Login()));
//                                  Navigator.push(context, ScaleRoute(widget: Login()));
                                });
                              },
                              child: Text('login'),
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
                  child: state is SignUpLoading ? CircularProgressIndicator() : null,
                ),
              ],
            );
          }),
    );
  }

  @override
  void dispose() {
    _signUpBloc.dispose();
    super.dispose();
  }

  void _onSignUpButtonPressed() {
    _signUpBloc.dispatch(SignUpEvent(username: username, password: password));
  }

  void _openMain() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Main()));
    });
    _signUpBloc.dispatch(SignUpComplete());
  }
}
