import 'package:flutter/material.dart';
import 'package:flutter_app/animation/shake/shake_demo_screen.dart';
import 'package:flutter_app/animation/slideButton/SlideButtonScreen.dart';

import 'bottomBox/BottomBox.dart';
import 'fancyBackground/FancyBackgroundScreen.dart';
import 'flip/flip_image_screen.dart';
import 'hero/HeroCustomRoute.dart';
import 'hero/HeroDemoScreen.dart';
import 'music_animation/music_animation_demo.dart';
import 'number_increase/number_increase_demo.dart';

class AnimationScreen extends StatefulWidget {
  @override
  State createState() => AnimationState();
}

class AnimationState extends State<AnimationScreen> {
  final List<String> listAnimation = [
    'slideButton',
    'hero',
    'fancyBackground',
    'flipImage',
    'bottomBox',
    'shake',
    'numberIncrease',
    'musicAnimation'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation screen'),
      ),
      body: ListView.builder(
          itemCount: listAnimation.length,
          itemBuilder: (buildContext, index) {
            return Container(
              height: 50,
              color: Colors.amber[(index % 10) * 100],
              child: Center(
                child: FlatButton(
                    onPressed: () => gotoAnimation(context, index),
                    child: Hero(
                        tag: 'heroTest-$index',
                        child: Material(
                            child: Text(
                              listAnimation[index],
                              style: TextStyle(fontSize: 20),
                            ),
                            color: Colors.transparent))),
              ),
            );
          }),
    );
  }

  gotoAnimation(BuildContext context, int index) {
    // goto next screen
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => SlideButtonScreen()));
        break;
      case 1:
        Navigator.push(context, HeroCustomRoute(widget: HeroDemoScreen()));
        break;
      case 2:
        Navigator.push(
            context, HeroCustomRoute(widget: FancyBackgroundScreen()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => FlipImageScreen()));
        break;
      case 4:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => BottomBoxScreen()));
        break;
      case 5:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => ShakeDemoScreen()));
        break;
      case 6:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => NumberIncreaseScreen()));
        break;
      case 7:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => MusicAnimationDemo()));
        break;
      default:
        break;
    }
  }
}
