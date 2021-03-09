import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/animation/fireworks/item/fire_light.dart';

///
/// **********
/// **********
/// **********
/// **********
/// **********
///
///

class FireworkItem extends StatefulWidget {
  final double size;
  final Duration delay;
  final Color fireworkColor;

  FireworkItem({
    this.size = 40,
    this.delay,
    this.fireworkColor = Colors.amberAccent,
  });

  @override
  _FireworkItemState createState() => _FireworkItemState();
}

class _FireworkItemState extends State<FireworkItem>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  bool show = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(
        milliseconds: 500,
      ),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      _animationController,
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _animationController.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _animationController.forward();
          }
        },
      );

    if (widget.delay == null) {
      show = true;
      _animationController.forward();
    } else {
      Future.delayed(
        widget.delay,
        () {
          if (mounted) {
            setState(() {
              show = true;
              _animationController.forward();
            });
          }
        },
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double _distanceCenter() {
    return widget.size / 5;
  }

  double _calFireLightWidth() {
    return widget.size * 2 / 5;
  }

  double _calFireLightHeight() {
    return widget.size / 12;
  }

  @override
  Widget build(BuildContext context) {
    return show
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                widget.size,
              ),
            ),
            height: widget.size,
            width: widget.size,
            child: Stack(
              children: [
                /// middle
//          Positioned(
//            child: Center(
//              child: Container(
//                height: _calFireLightHeight(),
//                width: _calFireLightHeight(),
//                color: Colors.red,
//              ),
//            ),
//          ),

                ///right
                ///
                Positioned(
                  top: widget.size / 2 - _calFireLightHeight() / 2,
                  left: widget.size / 2 + _distanceCenter() / 2,
                  child: FireLight(
                    height: _calFireLightHeight(),
                    width: _calFireLightWidth(),
                    animation: _animation,
                    color: widget.fireworkColor,
                  ),
                ),

                ///left
                ///
                Positioned(
                  top: widget.size / 2 - _calFireLightHeight() / 2,
                  left: 0,
                  child: Transform.rotate(
                    angle: pi,
                    child: FireLight(
                      height: _calFireLightHeight(),
                      width: _calFireLightWidth(),
                      animation: _animation,
                      color: widget.fireworkColor,
                    ),
                  ),
                ),

                ///top
                ///
                Positioned(
                  top: _calFireLightWidth() / 2 - _calFireLightHeight() / 2,
                  left: (widget.size - _calFireLightWidth()) / 2,
                  child: Transform.rotate(
                    angle: 3 * pi / 2,
                    origin: Offset(0, 0),
                    child: FireLight(
                      height: _calFireLightHeight(),
                      width: _calFireLightWidth(),
                      animation: _animation,
                      color: widget.fireworkColor,
                    ),
                  ),
                ),

                ///bottom
                ///
                Positioned(
                  top: widget.size / 2 +
                      _calFireLightHeight() / 2 +
                      _calFireLightWidth() / 2 +
                      _calFireLightHeight() / 4,
                  left: (widget.size - _calFireLightWidth()) / 2,
                  child: Transform.rotate(
                    angle: pi / 2,
                    origin: Offset(0, 0),
                    child: FireLight(
                      height: _calFireLightHeight(),
                      width: _calFireLightWidth(),
                      animation: _animation,
                      color: widget.fireworkColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
