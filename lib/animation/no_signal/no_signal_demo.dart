import 'package:flutter/material.dart';

class NoSignalDemo extends StatefulWidget {
  @override
  State createState() => NoSignalState();
}

const moveDirection = [
  [-1, -1],
  [1, -1],
  [1, 1],
  [-1, 1],
];

enum Direction {top_left, top_right, bottom_right, bottom_left}

const posDir = {
  0: Direction.top_left,
  1: Direction.top_right,
  2: Direction.bottom_right,
  3: Direction.bottom_left,
};

class Position {
  double x, y;

  Position(this.x, this.y);

  @override
  String toString() {
    return '{x - $x, y - $y}';
  }
}

const NoSignalContainerHeight = 50.0;
const NoSignalContainerWidth = 100.0;

class NoSignalState extends State<NoSignalDemo> with TickerProviderStateMixin {

  Size _screenSize;

  Position noSignalPos = Position(30, 80);

  Direction containerDir = Direction.bottom_right;

  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 10));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController)..addListener(() {
      if (_screenSize != null) {
        setState(() {

          // right
          if (noSignalPos.x + NoSignalContainerWidth >= _screenSize.width) {
            if (containerDir == Direction.bottom_right) {
              containerDir = Direction.bottom_left;
            } else {
              containerDir = Direction.top_left;
            }
          }

          //left
          if (noSignalPos.x <= 0) {
            if (containerDir == Direction.bottom_left) {
              containerDir = Direction.bottom_right;
            } else {
              containerDir = Direction.top_right;
            }
          }

          //top
          if (noSignalPos.y <= 0) {
            if (containerDir == Direction.top_left) {
              containerDir = Direction.bottom_left;
            } else {
              containerDir = Direction.bottom_right;
            }
          }

          //bottom
          if (noSignalPos.y + NoSignalContainerHeight >= _screenSize.height) {
            if (containerDir == Direction.bottom_left) {
              containerDir = Direction.top_left;
            } else {
              containerDir = Direction.top_right;
            }
          }

          int c = 0;

          switch (containerDir) {
            case Direction.top_left:
              c = 0;
              break;
            case Direction.top_right:
              c = 1;
              break;
            case Direction.bottom_right:
              c = 2;
              break;
            case Direction.bottom_left:
              c = 3;
              break;
          }

          noSignalPos = Position(noSignalPos.x + moveDirection[c][0], noSignalPos.y + moveDirection[c][1]);
        });
      }
    })..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.forward(from: 0);
      }
    });

    animationController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenSize = MediaQuery
        .of(context)
        .size;
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.black,
          ),
          Positioned(
            left: noSignalPos.x,
            top: noSignalPos.y,
            child: Container(
              width: NoSignalContainerWidth,
              height: NoSignalContainerHeight,
              child: Center(
                child: Text(
                  'No Signal',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white, width: 5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
