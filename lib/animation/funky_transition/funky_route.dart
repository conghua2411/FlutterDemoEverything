import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FunkyRoute extends PageRouteBuilder {
  static int funkyCount = 8;

  final Widget widget;
  final int type;

  FunkyRoute({this.widget, this.type})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondAnimation) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondAnimation,
              Widget child) {
            switch (type) {
              case 0:
                return FunkyTransition(
                  funky: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.linear,
                      reverseCurve: Curves.linear,
                    ),
                  ),
                  child: widget,
                );
              case 1:
                return FunkyTransition2(
                  funky: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.linear,
                      reverseCurve: Curves.linear,
                    ),
                  ),
                  child: widget,
                );
              case 2:
                return FunkyTransition3(
                  funky: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.linear,
                      reverseCurve: Curves.linear,
                    ),
                  ),
                  child: widget,
                );
              case 3:
                return FunkyTransition4(
                  funky: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.linear,
                      reverseCurve: Curves.linear,
                    ),
                  ),
                  child: widget,
                );
              case 4:
                return FunkyTransition5(
                  funky: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.linear,
                      reverseCurve: Curves.linear,
                    ),
                  ),
                  child: widget,
                );
              case 5:
                return FunkyTransition6(
                  funky: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.linear,
                      reverseCurve: Curves.linear,
                    ),
                  ),
                  child: widget,
                );
              case 6:
                return FunkyTransition7(
                  funky: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.bounceOut,
                      reverseCurve: Curves.linear,
                    ),
                  ),
                  child: widget,
                );
              case 7:
                return FunkyTransition8(
                  funky: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.linear,
                      reverseCurve: Curves.linear,
                    ),
                  ),
                  child: widget,
                );
              default:
                return FunkyTransition2(
                  funky: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.linear,
                      reverseCurve: Curves.linear,
                    ),
                  ),
                  child: widget,
                );
            }
          },
        );

  @override
  Duration get transitionDuration {
    return Duration(seconds: 2);
  }
}

/// class custom transition
///
/// 1
class FunkyTransition extends AnimatedWidget {
  FunkyTransition({
    Key key,
    @required Animation<double> funky,
    this.alignment = Alignment.centerLeft,
    this.child,
  })  : assert(funky != null),
        super(key: key, listenable: funky);

  Animation<double> get funky => listenable;

  final Alignment alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double funkyValue = funky.value;
    final Matrix4 transform = Matrix4.identity()
      ..setEntry(3, 2, 0.002)
      ..rotateY(pi / 2 * (1 - funkyValue));
    return Transform(
      transform: transform,
      alignment: alignment,
      child: child,
    );
  }
}

/// 2
class FunkyTransition2 extends AnimatedWidget {
  FunkyTransition2({
    Key key,
    @required Animation<double> funky,
    this.alignment = Alignment.centerRight,
    this.child,
  })  : assert(funky != null),
        super(key: key, listenable: funky);

  Animation<double> get funky => listenable;

  final Alignment alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double funkyValue = funky.value;
    final Matrix4 transform = Matrix4.identity()
      ..setEntry(3, 2, 0.002)
      ..rotateY(-pi / 2 * (1 - funkyValue));
    return Transform(
      transform: transform,
      alignment: alignment,
      child: child,
    );
  }
}

/// 3
class FunkyTransition3 extends AnimatedWidget {
  FunkyTransition3({
    Key key,
    @required Animation<double> funky,
    this.alignment = Alignment.center,
    this.child,
  })  : assert(funky != null),
        super(key: key, listenable: funky);

  Animation<double> get funky => listenable;

  final Alignment alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double funkyValue = funky.value;

    /// rotate and scale
    final Matrix4 transform = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..scale(funkyValue, funkyValue, 1.0)
      ..rotateZ(2 * pi * (1 - funkyValue));

    return Transform(
      transform: transform,
      alignment: alignment,
      child: child,
    );
  }
}

/// 4
class FunkyTransition4 extends AnimatedWidget {
  FunkyTransition4({
    Key key,
    @required Animation<double> funky,
    this.alignment = Alignment.center,
    this.child,
  })  : assert(funky != null),
        super(key: key, listenable: funky);

  Animation<double> get funky => listenable;

  final Alignment alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double funkyValue = funky.value;
    return Transform.translate(
      offset: Offset(
        -MediaQuery.of(context).size.width * (1 - funkyValue),
        -MediaQuery.of(context).size.height * (1 - funkyValue),
      ),
      child: child,
    );
  }
}

/// 5
class FunkyTransition5 extends AnimatedWidget {
  FunkyTransition5({
    Key key,
    @required Animation<double> funky,
    this.alignment = Alignment.center,
    this.child,
  })  : assert(funky != null),
        super(key: key, listenable: funky);

  Animation<double> get funky => listenable;

  final Alignment alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double funkyValue = funky.value;
    return Transform.translate(
      offset: Offset(
        -MediaQuery.of(context).size.width * (1 - funkyValue),
        _bounce(1.0 - funkyValue) * 200,
      ),
      child: child,
    );
  }

  double _bounce(double t) {
    if (t < 1.0 / 2.75) {
      return 7.5625 * t * t;
    } else if (t < 2 / 2.75) {
      t -= 1.5 / 2.75;
      return 7.5625 * t * t + 0.75;
    } else if (t < 2.5 / 2.75) {
      t -= 2.25 / 2.75;
      return 7.5625 * t * t + 0.9375;
    }
    t -= 2.625 / 2.75;
    return 7.5625 * t * t + 0.984375;
  }
}

/// 6
class FunkyTransition6 extends AnimatedWidget {
  FunkyTransition6({
    Key key,
    @required Animation<double> funky,
    this.alignment = Alignment.center,
    this.child,
  })  : assert(funky != null),
        super(key: key, listenable: funky);

  Animation<double> get funky => listenable;

  final Alignment alignment;
  final Widget child;

  /// random from -1 to 1
  /// -1 > 1
  random() {
    Random rand = Random();
    return (rand.nextDouble() - 0.5) * 2;
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

  double randomRotation(double value) {
    if (value < 0.9 && value > 0) {
      return random() * 10;
    } else {
      return 0;
    }
  }

  double randomScale(double value) {
    if (value < 0.9 && value > 0) {
      return random() * 0.1 + 0.95;
    } else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double funkyValue = funky.value;

    final double funkyScale = randomScale(funkyValue);

    /// rotate and scale
    final Matrix4 transform = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..scale(funkyScale, funkyScale, 1.0)
      ..rotateZ(randomRotation(funkyValue) / 360);

    return Transform.translate(
      offset: Offset(randomLeft(funkyValue), randomTop(funkyValue)),
      child: Transform(
        transform: transform,
        alignment: alignment,
        child: child,
      ),
    );
  }
}

/// 7
class FunkyTransition7 extends AnimatedWidget {
  FunkyTransition7({
    Key key,
    @required Animation<double> funky,
    this.alignment = Alignment.topLeft,
    this.child,
  })  : assert(funky != null),
        super(key: key, listenable: funky);

  Animation<double> get funky => listenable;

  final Alignment alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double funkyValue = funky.value;
    return Transform.rotate(
      alignment: alignment,
      angle: pi / 2 * (1 - funkyValue),
      origin: Offset(20, 20),
      child: child,
    );
  }
}

/// 8
class FunkyTransition8 extends AnimatedWidget {
  FunkyTransition8({
    Key key,
    @required Animation<double> funky,
    this.alignment = Alignment.center,
    this.child,
  })  : assert(funky != null),
        super(key: key, listenable: funky);

  Animation<double> get funky => listenable;

  final Alignment alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double funkyValue = funky.value;
    return Transform.translate(
      offset: Offset(
        0,
        -MediaQuery.of(context).size.height * (1 - funkyValue),
      ),
      child: child,
    );
  }
}
