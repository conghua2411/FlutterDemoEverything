import 'package:flutter/material.dart';

class HeroCustomRoute extends PageRouteBuilder {
  final Widget widget;

  HeroCustomRoute({this.widget})
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondAnimation) {
              return widget;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondAnimation,
                Widget child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 1.0),
                  end: const Offset(0.0, 0.0),
                ).animate(animation),
                child: child,
              );
            },
            transitionDuration: Duration(seconds: 1));
}
