import 'dart:math';

import 'package:flutter/material.dart';

class TicTacToe extends StatelessWidget {
  TicTacToeWidget tacToeWidget = new TicTacToeWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TicTacToe"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: refreshGame,
          )
        ],
      ),
      body: Center(
        child: tacToeWidget,
      ),
    );
  }

  void refreshGame() {
    tacToeWidget.refreshGame();
  }
}

class TicTacToeWidget extends StatefulWidget {
  TicTacToeState tacToeState = new TicTacToeState();

  @override
  State<StatefulWidget> createState() => tacToeState;

  void refreshGame() {
    tacToeState.refreshGame();
  }
}

class TicTacToeState extends State<TicTacToeWidget> {
  List<List<int>> posState;
  Bot bot;

  TicTacToeState() {
    posState =
        List<List<int>>.generate(3, (i) => List<int>.generate(3, (j) => 0));
    bot = new Bot(posState: posState);
  }

  void refreshGame() {
    bot.setPlaying(true);
    setState(() {
      posState =
          List<List<int>>.generate(3, (i) => List<int>.generate(3, (j) => 0));
      bot.setPosState(posState);
    });
  }

  void setPosState(int state, int posX, int posY) {
    if (!bot.checkColli(posX, posY) && bot.getPlaying()) {
      print("player move");
      setState(() {
        posState[posX][posY] = state;
      });

      bot.setPosState(posState);
      if (bot.checkWin(1)) {
        showDialogWinner(1);
        bot.setPlaying(false);
      } else {
        botMakeMove(bot);
      }
    }
  }

  void botMakeMove(Bot bot) {
    if (!bot.checkFull() && bot.getPlaying()) {
      print("bot move");
      List<int> move = bot.calPosMove();

      setState(() {
        posState[move[0]][move[1]] = 2;
      });

      bot.setPosState(posState);
      if (bot.checkWin(2)) {
        showDialogWinner(2);
        bot.setPlaying(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: List.generate(3, (index) {
        return Expanded(child: showTicTacToeRow(posState[index], index));
      }),
    );
  }

  void showDialogWinner(int num) {
    AlertDialog dialog = new AlertDialog(
      title: Text('Game over'),
      content: Text('player $num win'),
      actions: <Widget>[
        FlatButton(
          child: Text('close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  Widget showTicTacToeRow(List<int> posData, int col) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: List.generate(posData.length, (index) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => setPosState(1, col, index),
              child: Container(
                color:
                    Colors.primaries[posData[index] % Colors.primaries.length],
                child: Center(
                    child: Text(
                  posData[index].toString(),
                  style: TextStyle(fontSize: 20),
                )),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class Bot {
  bool playing = true;

  List<List<int>> posState;

  List<List<String>> winCase = [
    ["00", "01", '02'],
    ["10", "11", '12'],
    ["20", "21", '22'],
    ["00", "10", '20'],
    ["01", "11", '21'],
    ["02", "12", '22'],
    ["00", "11", '22'],
    ["02", "11", '20'],
  ];

  Bot({@required this.posState});

  void setPosState(List<List<int>> posState) {
    this.posState = posState;
  }

  void setPlaying(bool playing) {
    this.playing = playing;
  }

  bool getPlaying() => this.playing;

  List<int> calPosMove() {
    int temp;

    if (!checkColli(1, 1)) {
      return [1, 1];
    }

    //check bot can win
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (!checkColli(i, j)) {
          temp = posState[i][j];
          posState[i][j] = 2;
          if (checkWin(2)) {
            print("bot 2 $i - $j");
            return [i, j];
          }
          posState[i][j] = temp;
        }
      }
    }

    //check player can win
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (!checkColli(i, j)) {
          temp = posState[i][j];
          posState[i][j] = 1;
          if (checkWin(1)) {
            print("player 1 $i - $j");
            return [i, j];
          }
          posState[i][j] = temp;
        }
      }
    }

    print("random 2");
    return randomMove();
  }

  bool checkWin(int num) {
    for (int i = 0; i < 8; i++) {
      if (getValueWincase(winCase[i][0]) == getValueWincase(winCase[i][1]) &&
          getValueWincase(winCase[i][1]) == getValueWincase(winCase[i][2]) &&
          getValueWincase(winCase[i][0]) == num) {
        return true;
      }
    }
    return false;
  }

  int getValueWincase(String wincase) {
    return posState[int.parse(wincase[0])][int.parse(wincase[1])];
  }

  List<int> randomMove() {
    Random rand = new Random();
    int x = -1, y = -1;
    do {
      x = rand.nextInt(3);
      y = rand.nextInt(3);

      print("random pos : $x - $y");
    } while (checkColli(x, y));

    print("random $x - $y");
    return [x, y];
  }

  bool checkColli(int x, int y) {
    if (posState[x][y] != 0) {
      return true;
    }
    return false;
  }

  bool checkFull() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (posState[i][j] == 0) {
          return false;
        }
      }
    }
    return true;
  }
}
