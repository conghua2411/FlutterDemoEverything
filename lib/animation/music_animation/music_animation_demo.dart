import 'dart:math';

import 'package:flutter/material.dart';

class MusicAnimationDemo extends StatefulWidget {
  @override
  State createState() => MusicAnimationState();
}

class MusicAnimationState extends State<MusicAnimationDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Animation'),
      ),
      body: Center(
        child: MusicCustomAnimation(),
      ),
    );
  }
}

class MusicCustomAnimation extends StatefulWidget {
  @override
  State createState() => MusicCustomAnimationState();
}

class MusicCustomAnimationState extends State<MusicCustomAnimation> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            AnimationMusicColumn(),
            SizedBox(
              width: 10,
            ),
            AnimationMusicColumn(),
            SizedBox(
              width: 10,
            ),
            AnimationMusicColumn(),
            SizedBox(
              width: 10,
            ),
            AnimationMusicColumn(),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class AnimationMusicColumn extends StatefulWidget {
  @override
  State createState() => AnimationMusicColumnState();
}

const double MAX_HEIGHT_COLUMN = 90;
const double MIN_HEIGHT_COLUMN = 30;

class AnimationMusicColumnState extends State<AnimationMusicColumn>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  double height = 50;

  double currentHeight = 50;
  double nextHeight;

  bool isForward = true;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {
          height = calculateHeight(_animation.value);
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          currentHeight = nextHeight;

          nextHeight = randomNext();

          randomAnimationControllerDuration();

          isForward = false;

          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          currentHeight = nextHeight;

          nextHeight = randomNext();

          randomAnimationControllerDuration();

          isForward = true;

          _animationController.forward(from: 0);
        }
      });

    nextHeight = randomNext();

    randomAnimationControllerDuration();

    _animationController.forward();
  }

  randomNext() {
    Random rand = Random();

    return (rand.nextDouble() * (MAX_HEIGHT_COLUMN - MIN_HEIGHT_COLUMN)) +
        MIN_HEIGHT_COLUMN;
  }

  randomAnimationControllerDuration() {
    Random rand = Random();

    _animationController.duration =
        Duration(milliseconds: (rand.nextDouble() * 100).toInt() + 300);
  }

  calculateHeight(double value) {
    if (isForward) {
      return ((nextHeight - currentHeight) * value) + currentHeight;
    } else {
      return ((nextHeight - currentHeight) * (1 - value)) + currentHeight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: height,
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(20)),
    );
  }
}
