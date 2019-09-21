import 'dart:math';

import 'package:flutter/material.dart';

class PlayBtnAnimationDemo extends StatefulWidget {
  @override
  State createState() => PlayBtnAnimationState();
}

class PlayBtnAnimationState extends State<PlayBtnAnimationDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PlayBtnAnimationState'),
      ),
      body: Center(
        child: PlayBtn(
          onPressed: () {
            print('onPressed');
          },
          onComplete: () {
            print('onComplete');
          },
          timeLimit: Duration(seconds: 5),
          idleChild: Icon(Icons.mic, color: Colors.white),
          playingChild: Icon(
            Icons.stop,
            color: Color(0xFFe94e1b),
            size: 40,
          ),
          size: 36,
          idleBackgroundColor: Color(0xFFe94e1b),
          playingBackgroundColor: Color(0x33ffffff),
          lineColor: Color(0x4Def825e),
        ),
      ),
    );
  }
}

class PlayBtn extends StatefulWidget {
  final VoidCallback onPressed;
  final VoidCallback onComplete;

  final Duration timeLimit;
  final Widget idleChild;
  final Widget playingChild;
  final double size;

  final Color idleBackgroundColor;
  final Color playingBackgroundColor;
  final Color lineColor;

  PlayBtn(
      {@required this.onPressed,
      @required this.onComplete,
      @required this.timeLimit,
      @required this.idleChild,
      @required this.playingChild,
      @required this.size,
      @required this.idleBackgroundColor,
      @required this.playingBackgroundColor,
      @required this.lineColor});

  @override
  State createState() => PlayBtnState();
}

class PlayBtnState extends State<PlayBtn> with TickerProviderStateMixin {
  double percentage;
  AnimationController _animationController;
  Animation<double> _animation;

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    percentage = 0;

    _animationController =
        AnimationController(vsync: this, duration: widget.timeLimit);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {
          percentage = _animation.value * 100;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _animationController.reset();
            widget.onComplete();
            isPlaying = false;
          });
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size * 2,
      width: widget.size * 2,
      child: CustomPaint(
        foregroundPainter: MyPainter(
            lineColor:
                isPlaying ? widget.lineColor : widget.idleBackgroundColor,
            completeColor: widget.idleBackgroundColor,
            completePercent: percentage,
            width: 8.0),
        child: FlatButton(
            color: isPlaying
                ? widget.playingBackgroundColor
                : widget.idleBackgroundColor,
            splashColor: Color(0x33FFFFFF),
            shape: CircleBorder(),
            child: isPlaying ? widget.playingChild : widget.idleChild,
            onPressed: () {
              if (isPlaying) {
                _animationController.reset();
                widget.onComplete();
                isPlaying = false;
              } else {
                _animationController.forward();
                widget.onPressed();
                isPlaying = true;
              }
            }),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  Color lineColor;
  Color completeColor;
  double completePercent;
  double width;

  MyPainter(
      {this.lineColor, this.completeColor, this.completePercent, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);

    double radius = min(size.width / 2, size.height / 2);

    Paint line = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Paint complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    canvas.drawCircle(center, radius, line);

    double arcAngle = 2 * pi * (completePercent / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
