import 'dart:math';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/animation/funky_transition/funky_route.dart';

class FunkyTransitionView extends StatefulWidget {
  @override
  _FunkyTransitionViewState createState() => _FunkyTransitionViewState();
}

class _FunkyTransitionViewState extends State<FunkyTransitionView> {
  int currentType = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                FunkyRoute(
                  widget: FunkyKyKy(),
                  type: currentType++ % FunkyRoute.funkyCount,
                ),
              );
            },
            color: Colors.blue,
            child: Text(
              'F U N K Y',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FunkyKyKy extends StatefulWidget {
  @override
  _FunkyKyKyState createState() => _FunkyKyKyState();
}

class _FunkyKyKyState extends State<FunkyKyKy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.primaries[Random().nextInt(10) + 1],
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              color: Colors.primaries[Random().nextInt(10) + 1],
              height: MediaQuery.of(context).size.height * 2 / 3,
              width: MediaQuery.of(context).size.width * 2 / 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: FlareActor(
                      'assets/flare/splash.flr',
                      animation: 'splash',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: Text(
                      'F U N K Y',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
