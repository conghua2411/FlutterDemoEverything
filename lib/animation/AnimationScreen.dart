import 'package:flutter/material.dart';
import 'package:flutter_app/animation/rolling/rolling_animation.dart';
import 'package:flutter_app/animation/shake/shake_demo_screen.dart';
import 'package:flutter_app/animation/slideButton/SlideButtonScreen.dart';

import 'animated_list/animated_list_demo.dart';
import 'bottomBox/BottomBox.dart';
import 'click_effect/click_effect.dart';
import 'fancyBackground/FancyBackgroundScreen.dart';
import 'fireworks/fireworks.dart';
import 'flip/flip_image_screen.dart';
import 'hero/HeroCustomRoute.dart';
import 'hero/HeroDemoScreen.dart';
import 'image_drag_pop/image_drag_pop.dart';
import 'image_hero/image_hero_demo.dart';
import 'list_builder_animated/list_builder_animated_demo.dart';
import 'music_animation/music_animation_demo.dart';
import 'no_signal/no_signal_demo.dart';
import 'number_increase/number_increase_demo.dart';
import 'play_btn_animation/play_btn_animation.dart';

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
    'musicAnimation',
    'PlayBtnAnimation',
    'ImageHeroDemo',
    'NoSignalDemo',
    'AnimatedListDemo',
    'ListBuilderAnimatedDemo',
    'ImageDragPop',
    'ClickEffect',
    'Fireworks',
    'Rolling',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation screen'),
      ),
      body: Container(
        color: Colors.amber,
        child: ListView.builder(
            itemCount: listAnimation.length,
            itemBuilder: (buildContext, index) {
              return Container(
                height: 50,
                color: Colors.amber[(index % 9 +1) * 100],
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
      ),
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
      case 8:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => PlayBtnAnimationDemo()));
        break;
      case 9:
        Navigator.push(
            context, HeroCustomRoute(widget: ImageHeroDemo()));
        break;
      case 10:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => NoSignalDemo()));
        break;
      case 11:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => AnimatedListDemo()));
        break;
      case 12:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => ListBuilderAnimatedDemo()));
        break;
      case 13:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => ImageDragPop()));
        break;
      case 14:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => ClickEffect()));
        break;
      case 15:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => Fireworks()));
        break;
      case 16:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => RollingAnimation()));
        break;
      default:
        break;
    }
  }
}
