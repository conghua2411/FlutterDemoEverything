import 'package:flutter/material.dart';

import 'MyPaint.dart';

class FancyBackgroundScreen extends StatefulWidget {
  @override
  State createState() => FancyBackgroundState();
}

class FancyBackgroundState extends State<FancyBackgroundScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;

  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween<double>(begin: -1, end: 1).animate(animationController)
      ..addListener(() {
        print(animation.value);
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reset();
          animationController.forward();
        }
      });

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FancyBackground'),
      ),
      body: Container(
        child: CustomPaint(
          foregroundPainter: MyPaint(state: animation.value),
          child: Container(),
        ),
      ),
    );
  }
}
