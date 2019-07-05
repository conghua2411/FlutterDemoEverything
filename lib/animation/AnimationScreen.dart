import 'package:flutter/material.dart';
import 'package:flutter_app/animation/slideButton/SlideButtonScreen.dart';

import 'fancyBackground/FancyBackgroundScreen.dart';
import 'hero/HeroCustomRoute.dart';
import 'hero/HeroDemoScreen.dart';

class AnimationScreen extends StatefulWidget {
  @override
  State createState() => AnimationState();
}

class AnimationState extends State<AnimationScreen> {
  final List<String> listAnimation = ['slideButton', 'hero', 'fancyBackground'];

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
        Navigator.push(
            context, HeroCustomRoute(widget: HeroDemoScreen()));
        break;
      case 2:
        Navigator.push(
            context, HeroCustomRoute(widget: FancyBackgroundScreen()));
        break;
      default:
        break;
    }
  }
}
