import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';

Future main() async {
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
}

class BoxGame extends Game {

  @override
  void update(double t) {

  }

  @override
  void render(Canvas canvas) {

  }
}

class FlameGame extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flame Game'),
      ),
      body: Center(
        child: Text('gameBoard'),
      ),
    );
  }
}