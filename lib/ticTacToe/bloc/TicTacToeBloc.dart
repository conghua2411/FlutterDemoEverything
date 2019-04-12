import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TicTacToeBlocEvent extends Equatable {
  TicTacToeBlocEvent([List props = const []])
      : super(props);
}

class Normal extends TicTacToeBlocEvent {}

class Click extends TicTacToeBlocEvent {
  int posX, posY;

  Click({@required this.posX, @required this.posY})
      : assert(posX != null),
        assert(posY != null),
        super([posX, posY]);
}

abstract class TicTacToeBlocState extends Equatable {
  TicTacToeBlocState([List props = const []])
      : super(props);
}

class NormalState extends TicTacToeBlocState {

}
