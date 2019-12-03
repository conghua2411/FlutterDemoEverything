import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class GameOfLife extends StatefulWidget {
  @override
  State createState() => GameOfLifeState();
}

class GameOfLifeState extends State<GameOfLife> {
  List<List<bool>> gameBoard;

  BehaviorSubject<List<List<bool>>> bsGameBoard;

  Timer gameTimer;

  List<List<int>> initCell;

  bool running = false;

  @override
  void initState() {
    super.initState();

    bsGameBoard = BehaviorSubject();

    gameBoard = List();
    gameBoard = List.generate(30, (index) {
      return List.generate(30, (i) {
        return false;
      });
    });

    gameBoard[10][10] = true;
    gameBoard[11][11] = true;
    gameBoard[12][11] = true;
    gameBoard[12][10] = true;
    gameBoard[12][9] = true;

    bsGameBoard.add(gameBoard);

    // game on
    gameTimer = Timer.periodic(Duration(milliseconds: 200), (time) {
      if (running) {
        _makeMove();
      }
    });
  }

  bool checkPos(int iRow, int iCol) {
    int count = 0;
    //top
    if (iRow != 0) {
      if (gameBoard[iRow - 1][iCol] == true) count++;
    }

    // top_right
    if (iRow != 0 && iCol != gameBoard[iRow].length - 1) {
      if (gameBoard[iRow - 1][iCol + 1] == true) count++;
    }

    // top_left
    if (iRow != 0 && iCol != 0) {
      if (gameBoard[iRow - 1][iCol - 1] == true) count++;
    }

    // left
    if (iCol != 0) {
      if (gameBoard[iRow][iCol - 1] == true) count++;
    }

    // right
    if (iCol != gameBoard.length - 1) {
      if (gameBoard[iRow][iCol + 1] == true) count++;
    }

    // bot
    if (iRow != gameBoard.length - 1) {
      if (gameBoard[iRow + 1][iCol] == true) count++;
    }

    // bot_left
    if (iRow != gameBoard.length - 1 && iCol != 0) {
      if (gameBoard[iRow + 1][iCol - 1] == true) count++;
    }

    // bot_right
    if (iRow != gameBoard.length - 1 && iCol != gameBoard.length - 1) {
      if (gameBoard[iRow + 1][iCol + 1] == true) count++;
    }

    if (gameBoard[iRow][iCol] == true && (count == 2 || count == 3)) {
      return true;
    }

    if (gameBoard[iRow][iCol] == false && count == 3) {
      return true;
    }

    return false;
  }

  void _makeMove() {
    List<Cell> listCellChange = List();

    for (int i = 0; i < gameBoard.length; i++) {
      for (int j = 0; j < gameBoard[i].length; j++) {
        if (gameBoard[i][j] != checkPos(i, j)) {
          listCellChange.add(Cell(iCol: i, iRow: j, value: checkPos(i, j)));
        }
      }
    }

    listCellChange.forEach((cell) {
      gameBoard[cell.iCol][cell.iRow] = cell.value;
    });

    bsGameBoard.add(gameBoard);
  }

  @override
  void dispose() {
    gameTimer.cancel();
    bsGameBoard.close();
    super.dispose();
  }

  _onStartGame() {
    running = true;
  }

  _onResetGame() {
    running = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.lightBlueAccent,
              child: _buildGame(),
            ),
            Padding(
              padding: const EdgeInsets.all(100.0),
              child: Container(
                child: Row(
                  children: <Widget>[
                    FlatButton(
                      child: Text('Start'),
                      onPressed: _onStartGame,
                    ),
                    FlatButton(
                      child: Text('Reset'),
                      onPressed: _onResetGame,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildGame() {
    return StreamBuilder<List<List<bool>>>(
      initialData: [],
      stream: bsGameBoard,
      builder: (context, snapshot) {
        List<Widget> boardCol = List();
        for (int i = 0; i < snapshot.data.length; i++) {
          List<Widget> listWidget = List();
          for (int j = 0; j < snapshot.data[i].length; j++) {
            listWidget.add(GestureDetector(
              onTap: () {
                gameBoard[i][j] = !gameBoard[i][j];
                bsGameBoard.add(gameBoard);
              },
              child: Container(
                width:
                    MediaQuery.of(context).size.width / snapshot.data[i].length,
                height:
                    MediaQuery.of(context).size.width / snapshot.data[i].length,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    color: gameBoard[i][j] ? Colors.red : Colors.white,
                  ),
                ),
              ),
            ));
          }
          boardCol.add(Row(
            children: listWidget,
          ));
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: boardCol,
        );
      },
    );
  }
}

class Cell {
  int iRow;
  int iCol;

  bool value;

  Cell({
    this.iRow,
    this.iCol,
    this.value,
  });
}
