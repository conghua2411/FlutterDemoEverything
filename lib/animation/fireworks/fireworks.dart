import 'package:flutter/material.dart';

class Fireworks extends StatefulWidget {
  @override
  State createState() => FireworksState();
}

class FireworksState extends State<Fireworks> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(
        () {
          if (DateTime.now().second % 2 == 0) {
            setState(() {});
          }
        },
      );

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            '${_animation.value}',
          ),
        ),
      ),
    );
  }
}
