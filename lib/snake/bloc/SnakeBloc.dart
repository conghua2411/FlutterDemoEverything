import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/snake/snakeRepo/Snake.dart';
import 'package:flutter_app/snake/snakeRepo/SnakeGame.dart';
import 'package:meta/meta.dart';

abstract class SnakeBlocEvent extends Equatable {
  SnakeBlocEvent([List props = const []]) : super(props);

  String info();
}

class SnakeEventMove extends SnakeBlocEvent {
  @override
  String info() {
    return 'SnakeEventMove';
  }
}

class SnakeEventTurn extends SnakeBlocEvent {
  Direction dir;

  SnakeEventTurn({@required this.dir})
      : assert(dir != null),
        super([dir]);

  @override
  String info() {
    return 'SnakeEventTurn';
  }
}

class SnakeResetEvent extends SnakeBlocEvent {
  @override
  String info() {
    return 'SnakeResetEvent';
  }
}

class SnakeResetPause extends SnakeBlocEvent {
  @override
  String info() {
    return 'SnakeResetPause';
  }
}

abstract class SnakeBlocState extends Equatable {
  SnakeBlocState([List props = const []]) : super(props);

  String info();
}

class SnakeStateMove extends SnakeBlocState {
  List<List<int>> gameBoard;

  SnakeStateMove({@required this.gameBoard}) : super([gameBoard]);

  @override
  String info() {
    return 'SnakeStateMove';
  }
}

class SnakeStatePause extends SnakeBlocState {
  @override
  String info() {
    return 'SnakeStatePause';
  }
}

class SnakeStateGameOver extends SnakeBlocState {
  @override
  String info() {
    return 'SnakeStateGameOver';
  }
}

class SnakeBloc extends Bloc<SnakeBlocEvent, SnakeBlocState> {
  SnakeGame mSnakeGame;

  SnakeBloc() : super() {
    mSnakeGame = SnakeGame();
  }

  @override
  SnakeBlocState get initialState => SnakeStatePause();

  @override
  Stream<SnakeBlocState> mapEventToState(SnakeBlocEvent event) async* {
    if (mSnakeGame.gameOver) {
      print('SnakeBloc - mSnakeGame.gameOver');
      yield SnakeStateGameOver();
    } else if (event is SnakeResetEvent) {
      print('SnakeBloc - SnakeResetEvent');
      mSnakeGame.reset();
      yield SnakeStateMove(gameBoard: mSnakeGame.mBoard);
    } else if (event is SnakeEventTurn) {
      print('SnakeBloc - SnakeEventTurn');
      mSnakeGame.turn(event.dir);
      yield SnakeStateMove(gameBoard: mSnakeGame.mBoard);
    } else if (event is SnakeEventMove) {
      print('SnakeBloc - SnakeEventMove');
      mSnakeGame.move();
      yield SnakeStateMove(gameBoard: mSnakeGame.mBoard);
    }
    if (event is SnakeResetPause) {
      print('SnakeBloc - SnakeResetPause');
      yield SnakeStatePause();
    }
  }
}
