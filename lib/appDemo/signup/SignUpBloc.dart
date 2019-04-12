import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import 'dart:async';

import 'package:meta/meta.dart';

//Event
abstract class SignUpBlocEvent extends Equatable {
  SignUpBlocEvent([List props = const []]) : super(props);
}

class SignUpEvent extends SignUpBlocEvent {
  String username, password;

  SignUpEvent({@required this.username, @required this.password})
      : assert(username != null),
        assert(password != null),
        super([username, password]);
}

class SignUpComplete extends SignUpBlocEvent {}

//State
abstract class SignUpBlocState extends Equatable {}

class SignUpNormal extends SignUpBlocState {}

class SignUpLoading extends SignUpBlocState {}

class SignUpSuccess extends SignUpBlocState {}

//Bloc
class SignUpBloc extends Bloc<SignUpBlocEvent, SignUpBlocState> {
  @override
  SignUpBlocState get initialState => SignUpNormal();

  @override
  Stream<SignUpBlocState> mapEventToState(SignUpBlocEvent event) async* {
    if (event is SignUpEvent) {
      yield SignUpLoading();

      await Future.delayed(Duration(seconds: 1));

      yield SignUpSuccess();
    } else {
      yield SignUpNormal();
    }
  }
}
