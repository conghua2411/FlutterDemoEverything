import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EffectRect extends StatefulWidget {
  final double clickX;
  final double clickY;
  final double height;
  final double width;
  final Function onFinish;
  final double rotate;

  EffectRect({
    @required this.clickX,
    @required this.clickY,
    @required this.height,
    @required this.width,
    @required this.onFinish,
    @required this.rotate,
  });

  @override
  State createState() => EffectRectState();
}

class EffectRectState extends State<EffectRect>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  double positionX, positionY;
  double objectWidth, objectHeight;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInExpo,
    ))
      ..addListener(() {
        setState(() {
          positionX = widget.clickX - widget.width / 2 * _animation.value;
          positionY = widget.clickY - widget.height / 2 * _animation.value;

          objectWidth = widget.width * _animation.value;
          objectHeight = widget.height * _animation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onFinish();
        }
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: positionY ?? 0,
      left: positionX ?? 0,
      child: Transform.rotate(
        angle: widget.rotate,
        child: Container(
          width: objectWidth,
          height: objectHeight,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
          ),
        ),
      ),
    );
  }
}
