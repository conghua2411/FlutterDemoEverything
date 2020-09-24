import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class SmileSplash extends StatefulWidget {
  @override
  _SmileSplashState createState() => _SmileSplashState();
}

class _SmileSplashState extends State<SmileSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlareActor(
        'assets/flare/splash.flr',
        animation: 'splash',
        fit: BoxFit.cover,
      ),
    );
  }
}
