import 'dart:math';

import 'package:flutter/material.dart';

class WeirdTextFieldView extends StatefulWidget {
  @override
  _WeirdTextFieldViewState createState() => _WeirdTextFieldViewState();
}

class _WeirdTextFieldViewState extends State<WeirdTextFieldView>
    with TickerProviderStateMixin {
  Random _random;

  Color _randomColor() {
    return Colors.primaries[_random.nextInt(10) + 1];
  }

  double x = 0;
  double y = 0;
  double z = 0;

  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();

    _random = Random();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.forward(from: 0);
        }
      });

    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _rotate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WeirdTextField',
        ),
        actions: [
          Checkbox(
            value: _rotate,
            onChanged: (change) {
              setState(() {
                _rotate = change;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            builder: (context, child) {

              return Transform.rotate(
                angle: _rotate ? _animation.value * pi * 2 : 0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: _randomColor(),
                    border: Border.all(
                      color: _randomColor(),
                      width: 10,
                    ),
                  ),
                  child: child,
                ),
              );
            },
            animation: _animation,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration.collapsed(
                  hintText: 'Input something',
                ),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
