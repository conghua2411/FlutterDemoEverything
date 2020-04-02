import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/animation/click_effect/effect_circle.dart';

import 'effect_rect.dart';

class ClickEffect extends StatefulWidget {
  @override
  State createState() => ClickEffectState();
}

class ClickEffectState extends State<ClickEffect> {
  List<Widget> listWidget;

  @override
  void initState() {
    super.initState();

    listWidget = List();
  }

  double currentAngle = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: GestureDetector(
          onTapDown: (detail) {
            setState(() {
              if (listWidget.length > 30) {
                listWidget.clear();
              } else {
                listWidget.add(EffectCircle(
                  clickX: detail.globalPosition.dx,
                  clickY: detail.globalPosition.dy,
                  width: 100,
                  height: 100,
                  onFinish: () {
                    print('finish here');
                  },
                ));

                currentAngle += pi/13;

                listWidget.add(EffectRect(
                  clickX: detail.globalPosition.dx,
                  clickY: detail.globalPosition.dy,
                  width: 100,
                  height: 100,
                  onFinish: () {
                    print('finish here');
                  },
                  rotate: currentAngle,
                ));
              }
            });
          },
          child: Stack(
            children: listEffect(),
          ),
        ),
      ),
    );
  }

  List<Widget> listEffect() {
    List<Widget> list = List();

    list.addAll(listWidget);

    list.add(Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.transparent,
    ));

    return list;
  }
}
