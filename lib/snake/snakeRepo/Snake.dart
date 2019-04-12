import 'Point.dart';

enum Direction { LEFT, UP, RIGHT, DOWN }

class Snake {
  Point head = Point(x: 0, y: 0);
  Point tail = Point(x: 0, y: 0);
  List<Point> snakeBody;

  Direction mDir;

  Snake() {
    snakeBody = List.generate(3, (index) {
      return Point(x: 10, y: 10 - index);
    });

    head = Point.copy(snakeBody[0]);
    tail = Point.copy(snakeBody[snakeBody.length - 1]);

    mDir = Direction.RIGHT;
  }

  void move() {
    Point next = getNextPosMove();

    head.x += next.x;
    head.y += next.y;

    for (int i = snakeBody.length - 1; i > 0; i--) {
      snakeBody[i] = Point.copy(snakeBody[i - 1]);
    }

    snakeBody[0] = Point.copy(head);

    tail = Point.copy(snakeBody[snakeBody.length - 1]);
  }

  void eatFood() {
    Point temp = Point.copy(tail);

    move();

    snakeBody.add(temp);

    tail = Point.copy(snakeBody[snakeBody.length - 1]);
  }

  Point getNextPosMove() {
    switch (mDir) {
      case Direction.LEFT:
        return Point(x: 0, y: -1);
      case Direction.UP:
        return Point(x: -1, y: 0);
      case Direction.RIGHT:
        return Point(x: 0, y: 1);
      case Direction.DOWN:
        return Point(x: 1, y: 0);
    }
    return Point(x: 0, y: 0);
  }

  void setDir(Direction dir) {
    if (dir == mDir) {
      return;
    } else if (Direction.LEFT == dir && Direction.RIGHT == mDir) {
      return;
    } else if (Direction.RIGHT == dir && Direction.LEFT == mDir) {
      return;
    } else if (Direction.DOWN == dir && Direction.UP == mDir) {
      return;
    } else if (Direction.UP == dir && Direction.DOWN == mDir) {
      return;
    }
    mDir = dir;
  }

  Point getNextMoveOnBoard() {
    Point next = getNextPosMove();
    return Point(x: head.x + next.x, y: head.y + next.y);
  }
}
