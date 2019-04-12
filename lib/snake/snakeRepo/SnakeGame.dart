import 'dart:math' as Math;

import 'package:flutter_app/snake/snakeRepo/Point.dart';
import 'package:flutter_app/snake/snakeRepo/Snake.dart';

class SnakeGame {
  List<List<int>> mBoard;

  Snake mSnake;

  Point mFood;

  bool isPause = true;

  bool gameOver = false;

  SnakeGame() {
    mSnake = Snake();
    mBoard = List.generate(20, (_) {
      return List.generate(20, (_) {
        return 0;
      });
    });

    makeBoard();
    randomFood();
    addFood();
  }

  void makeBoard() {
    mBoard = List.generate(20, (_) {
      return List.generate(20, (_) {
        return 0;
      });
    });

    for (int i = 0; i < mSnake.snakeBody.length; i++) {
      mBoard[mSnake.snakeBody[i].x][mSnake.snakeBody[i].y] = 1;
    }
  }

  void turn(Direction dir) {
//    mSnake.mDir = dir;
    mSnake.setDir(dir);
  }

  void move() {
    print('SnakeGame move');
    if (checkBoundary(mSnake.getNextMoveOnBoard()) ||
        mBoard[mSnake.getNextMoveOnBoard().x][mSnake.getNextMoveOnBoard().y] ==
            1) {
      gameOver = true;
    } else {
      if (checkCollision(mSnake.getNextMoveOnBoard(), mFood)) {
        mSnake.eatFood();
        randomFood();
      } else {
        mSnake.move();
      }
      makeBoard();
      addFood();
    }
  }

  bool checkBoundary(Point point) {
    if (point.x < 0 || point.x > 19 || point.y < 0 || point.y > 19) {
      return true;
    }
    return false;
  }

  void addFood() {
    mBoard[mFood.x][mFood.y] = 2;
  }

  void randomFood() {
    Math.Random rand = Math.Random();

    int x, y;

    do {
      x = rand.nextInt(20);
      y = rand.nextInt(20);
    } while (mBoard[x][y] != 0);

    mFood = Point(x: x, y: y);
  }

  bool checkCollision(Point a, Point b) {
    if (a == b) {
      return true;
    }
    return false;
  }

  void reset() {
    gameOver = false;
    mSnake = Snake();
    mBoard = List.generate(20, (_) {
      return List.generate(20, (_) {
        return 0;
      });
    });

    makeBoard();
    randomFood();
    addFood();
  }
}
