import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'dart:async';

//event
abstract class LoginBlocEvent extends Equatable {
  LoginBlocEvent([List props = const []]) : super(props);
}

class LoginEvent extends LoginBlocEvent {
  final String username, password;

  LoginEvent(this.username, this.password)
      : assert(username != null),
        assert(password != null),
        super([username, password]);
}

class LoginComplete extends LoginBlocEvent {}

//state
abstract class LoginBlocState extends Equatable {
  LoginBlocState([List props = const []]) : super(props);
}

class LoginSuccessState extends LoginBlocState {
  final String username, password;

  LoginSuccessState(this.username, this.password)
      : assert(username != null),
        assert(password != null),
        super([username, password]);
}

class LoginLoadingState extends LoginBlocState {}

class LoginState extends LoginBlocState {}

class LoginErrorState extends LoginBlocState {
  final String error;

  LoginErrorState(this.error)
      : assert(error != null),
        super([error]);
}

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  @override
  LoginBlocState get initialState => LoginState();

  @override
  Stream<LoginBlocState> mapEventToState(LoginBlocEvent event) async* {
    if (event is LoginEvent) {
      yield LoginLoadingState();
      // handle login logic
      await Future.delayed(Duration(seconds: 2));

      yield LoginSuccessState(event.username, event.password);
    } else {
      yield LoginState();
    }
  }
}
