import 'dart:math';

import 'package:flutter/material.dart';

class ShakeDemoScreen extends StatefulWidget {
  @override
  State createState() => ShakeDemoState();
}

class ShakeDemoState extends State<ShakeDemoScreen>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  bool _isForward = true;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  double randomRotation(double value) {
    if (value < 0.9 && value > 0) {
      return random() * 10;
    } else {
      return 0;
    }
  }

  double randomTop(double value) {
    if (value < 0.9 && value > 0) {
      return random();
    } else {
      return 0;
    }
  }

  double randomLeft(double value) {
    if (value < 0.9 && value > 0) {
      return random();
    } else {
      return 0;
    }
  }

  random() {
    Random rand = Random();

    return (rand.nextDouble() - 0.5)*2;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('ShakeDemoScreen'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: randomTop(_animation.value) - height / 2,
            left: randomLeft(_animation.value) - width / 2,
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(
                  randomRotation(_animation.value) / 360),
              child: Container(
                  width: width * 2,
                  height: height * 2,
                  color: Colors.red,
                  child: Center(
                    child: Container(
                      width: width / 6,
                      height: height / 6,
                      color: Colors.red,
                      child: Center(
                        child: Icon(Icons.notifications),
                      ),
                    ),
                  )),
            ),
          ),
          Container(
            child: Positioned(
                top: height / 3 + randomTop(_animation.value),
                left: width / 3 + randomLeft(_animation.value),
                child: RotationTransition(
                    turns: AlwaysStoppedAnimation(
                        randomRotation(_animation.value) / 360),
                    child: FlatButton(
                        color: Colors.amber,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () {
                          if (_isForward) {
                            _animationController.forward();
                          } else {
                            _animationController.reverse();
                          }
                          _isForward = !_isForward;
                        },
                        child: Text('shake me')))),
          ),
        ],
      ),
    );
  }
}
