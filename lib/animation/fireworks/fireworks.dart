import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/animation/fireworks/item/firework_item.dart';

class Fireworks extends StatefulWidget {
  final int fireworkNumber;
  final double skyWidth;
  final double skyHeight;

  Fireworks({
    @required this.skyWidth,
    @required this.skyHeight,
    this.fireworkNumber = 50,
  });

  @override
  State createState() => FireworksState();
}

class FireworksState extends State<Fireworks> {
  Random _rand = Random();

  List<Widget> _listGeneratedFirework = [];

  @override
  void initState() {
    super.initState();

    _listGeneratedFirework = _generateFireworks(
      fireworkNumber: widget.fireworkNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(43, 43, 43, 1),
      body: _fireworkShow(),
//      body: Center(
//        child: FireworkItem(
//          size: 200,
//        ),
//      ),
    );
  }

  Widget _fireworkShow() {
    return Stack(
      children: _listGeneratedFirework,
    );
  }

  List<Widget> _generateFireworks({
    int fireworkNumber,
  }) {
    return List.generate(fireworkNumber, (index) {
      return _generateItem();
    });
  }

  List<Duration> _delayTime = List.generate(
    21,
    (index) => Duration(milliseconds: index * 250),
  );

  List<Color> _fireworkColor = [
    Color(0xffCE2029),
    Color(0xffFFFCAF),
    Color(0xffFFE17C),
    Color(0xffFF664B),
    Color(0xff903843),
  ];

  Color _randomColor() {
    return _fireworkColor[_rand.nextInt(100) % 5];
  }

  List<double> _fireworkSize = [
    20,
    30,
    40,
    50,
    60,
    70,
    80,
    90,
  ];

  double _randomSize() {
    return _fireworkSize[_rand.nextInt(10000) % 8];
  }

  Widget _generateItem() {
    double itemSize = _randomSize();

    /// position
    ///
    double posX = _rand.nextDouble() * (widget.skyWidth - itemSize);
    double posY = _rand.nextDouble() * (widget.skyHeight - itemSize);

    /// delay
    ///

    Duration delay = _delayTime[_rand.nextInt(1000) % 21];

    return Positioned(
      left: posX,
      top: posY,
      child: FireworkItem(
        size: itemSize,
        delay: delay,
        fireworkColor: _randomColor(),
      ),
    );
  }
}
