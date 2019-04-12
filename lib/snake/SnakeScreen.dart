import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/snake/bloc/SnakeBloc.dart';
import 'package:flutter_app/snake/snakeRepo/Snake.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SnakeBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(
        'detail : ${transition.currentState.info()} -- ${transition.nextState.info()} -- ${transition.event.info()} -- time ${DateTime.now()}');
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print('error : $error');
  }
}

class SnakeScreen extends StatefulWidget {
  @override
  State createState() => SnakeScreenState();
}

class SnakeScreenState extends State<SnakeScreen> {
  SnakeBloc _snakeBloc = SnakeBloc();

  bool changeColorSnake = false;

  List<List<int>> listInt2 = List.generate(20, (index) {
    return List.generate(20, (index2) {
      return 0;
    });
  });

  @override
  void initState() {
    BlocSupervisor().delegate = SnakeBlocDelegate();
    print('initState dispatch : SnakeEventMove');
    _snakeBloc.dispatch(SnakeEventMove());
    super.initState();
  }

  void showDialogGameOver() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AlertDialog dialog = new AlertDialog(
        title: Text('Game over'),
        content: Text('GAME OVER'),
        actions: <Widget>[
          FlatButton(
            child: Text('close'),
            onPressed: () {
              print('initState dispatch : SnakeResetEvent');
              _snakeBloc.dispatch(SnakeResetEvent());
              Navigator.of(context).pop();
            },
          ),
        ],
      );
      showDialog(context: context, builder: (BuildContext context) => dialog);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<SnakeBloc>(
          bloc: _snakeBloc,
        )
      ],
      child: BlocBuilder(
          bloc: _snakeBloc,
          builder: (BuildContext context, SnakeBlocState state) {
            if (state is SnakeStateMove) {
              print('build getState : SnakeStateMove');
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                await Future.delayed(Duration(milliseconds: 200));
                setState(() {
                  listInt2 = state.gameBoard;
                  print('build dispatch : SnakeEventMove');
                  _snakeBloc.dispatch(SnakeEventMove());
                });
              });
            } else if (state is SnakeStateGameOver) {
              print('build getState : SnakeStateGameOver');
              showDialogGameOver();
//              _snakeBloc.dispatch(SnakeResetPause());
            }

            return Scaffold(
              appBar: AppBar(
                title: Text('snake nake'),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        print('build dispatch : SnakeResetEvent');
                        _snakeBloc.dispatch(SnakeResetEvent());
                      });
                    },
                  )
                ],
              ),
              body: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      color: Colors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(listInt2.length, (index) {
                          return Expanded(
                            child: Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children:
                                    List.generate(listInt2.length, (index2) {
                                  return Expanded(
                                    child: Container(
                                      color: changeColorSnake
                                          ? listInt2[index][index2] == 2
                                              ? Colors.primaries[
                                                  (index + index2) %
                                                      Colors.primaries.length]
                                              : listInt2[index][index2] == 0
                                                  ? Colors.black
                                                  : Colors.primaries[((index +
                                                                  index2) *
                                                              index2 +
                                                          (index + 2 * index2) *
                                                              index) %
                                                      Colors.primaries.length]
                                          : listInt2[index][index2] == 0
                                              ? Colors.black
                                              : listInt2[index][index2] == 1
                                                  ? Colors.white
                                                  : Colors.red,
                                      child: Center(
                                        child: Text(''),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    flex: 10,
                  ),
                  Flexible(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: FlatButton(
                                onPressed: () {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    print(
                                        'build dispatch : SnakeEventTurn UP');
                                    _snakeBloc.dispatch(
                                        SnakeEventTurn(dir: Direction.UP));
//                                    _snakeBloc.dispatch(SnakeEventMove());
                                  });
                                },
                                child: Text('up')),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                child: FlatButton(
                                    onPressed: () {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        print(
                                            'build dispatch : SnakeEventTurn LEFT');
                                        _snakeBloc.dispatch(SnakeEventTurn(
                                            dir: Direction.LEFT));
//                                        _snakeBloc.dispatch(SnakeEventMove());
                                      });
                                    },
                                    child: Text('left')),
                              ),
                              Expanded(
                                child: FlatButton(
                                    onPressed: () {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        print(
                                            'build dispatch : SnakeEventTurn DOWN');
                                        _snakeBloc.dispatch(SnakeEventTurn(
                                            dir: Direction.DOWN));
//                                        _snakeBloc.dispatch(SnakeEventMove());
                                      });
                                    },
                                    child: Text('down')),
                              ),
                              Expanded(
                                child: FlatButton(
                                    onPressed: () {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        print(
                                            'build dispatch : SnakeEventTurn RIGHT');
                                        _snakeBloc.dispatch(SnakeEventTurn(
                                            dir: Direction.RIGHT));
//                                        _snakeBloc.dispatch(SnakeEventMove());
                                      });
                                    },
                                    child: Text('right')),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    flex: 3,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
