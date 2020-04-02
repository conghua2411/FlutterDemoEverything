import 'dart:math';

import 'package:flutter/material.dart';

class RollingAnimation extends StatefulWidget {
  @override
  State createState() => RollingAnimationState();
}

class RollingAnimationState extends State<RollingAnimation>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(
        seconds: 3,
      ),
      vsync: this,
    );

    _animation =
        Tween<double>(begin: -10, end: 10).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Transform.rotate(
          angle: 2 * pi * ((_animation.value + 10) / 20),
          child: Container(
//            color: Colors.amber[200],
            child: Align(
              alignment: Alignment(
                _animation.value / 10,
                0,
              ),
              child: Transform.rotate(
                angle: pi * _animation.value,
                child: Container(
                  height: 50,
                  width: 50,
                  child: Icon(Icons.list),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(
                      50,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_circle_filled),
        onPressed: () {
          _animationController.forward(from: 0);
        },
      ),
    );
  }
}
