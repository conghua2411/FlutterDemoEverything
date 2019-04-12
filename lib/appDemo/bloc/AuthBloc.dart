import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/appDemo/Repo/AuthRepo.dart';
import 'package:meta/meta.dart';

import 'dart:async';

// event
abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const []]) : super(props);
}

class SignUpEvent extends AuthEvent {}

class SplashEvent extends AuthEvent {}

class LogInEvent extends AuthEvent {}

abstract class AuthState extends Equatable {}

class AuthSplash extends AuthState {}

class AuthLogin extends AuthState {}

class AuthSignUp extends AuthState {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRepo authRepo;

  AuthBloc({this.authRepo});

  @override
  AuthState get initialState => AuthSplash();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is SplashEvent) {
      yield AuthSplash();
      await Future.delayed(Duration(seconds: 1));
      yield AuthLogin();


//    bool checkLogin = await authRepo.isLoggedIn();
//
//    if (checkLogin) {
//      yield AuthLogin();
//    } else {
//      yield AuthSplash();
//    }
    } else if (event is LogInEvent) {
      yield AuthLogin();
    } else if (event is SignUpEvent) {
      yield AuthSignUp();
    }
  }

  Future<bool> checkLogin() async {
    await Future.delayed(Duration(seconds: 2));
    return true;
  }
}
