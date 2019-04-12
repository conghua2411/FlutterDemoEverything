import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

abstract class MemriseEvent extends Equatable {
  MemriseEvent([List props = const []]) : super(props);
}

class AnswerClick extends MemriseEvent {
  final String answerData;

  AnswerClick({this.answerData})
      : assert(answerData != null),
        super([answerData]);
}

class NormalMemrise extends MemriseEvent {}

abstract class MemriseBlocState extends Equatable {
  MemriseBlocState([List props = const[]]) : super(props);
}

class AnswerClickState extends MemriseBlocState {
  final String answerData;

  AnswerClickState({this.answerData})
      : assert(answerData != null),
        super([answerData]);
}

class NormalState extends MemriseBlocState {}

class MemriseBloc extends Bloc<MemriseEvent, MemriseBlocState> {

  @override
  MemriseBlocState get initialState => NormalState();

  @override
  Stream<MemriseBlocState> mapEventToState(MemriseEvent event) async* {
    if (event is AnswerClick) {
      yield AnswerClickState(answerData: event.answerData);
    }else {
      yield NormalState();
    }
  }
}
