import 'dart:math';

import 'package:flutter/material.dart';

class CustomProfileScreen extends StatefulWidget {
  @override
  State createState() => CustomProfileState();
}

class CustomProfileState extends State<CustomProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: CustomPaint(
                      painter: OutSidePaint(),
                      child: Container(),
                    )),
                    Container(
                      child: CustomPaint(
                        painter: MyPaint(),
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    shape: BoxShape.circle),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: CustomPaint(
                      painter: OutSidePaint(),
                      child: Container(),
                    ))
                  ],
                ),
              ),
              _customPathPaint()
            ],
          ),
        )),
      ),
    );
  }

  _customPathPaint() {
    return Container(
      height: 240,
      child: CustomPaint(
        painter: ShadowPaint(),
        child: Container(),
      ),
    );
  }
}

class MyPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0x33000000)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    Offset center = new Offset(size.width / 2, size.height / 2);

    double radius = min(size.width / 2, size.height / 2);

    double arcAngle = 2 * pi * 0.5;
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), -pi,
        arcAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class OutSidePaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0x33000000)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    canvas.drawLine(
        Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ShadowPaint extends CustomPainter {
  /// 0 -> 400
  /// 0 -> 140 --- 260 -> 400

  @override
  void paint(Canvas canvas, Size size) {
//    Paint paint = Paint()
//      ..color = Colors.red
//      ..strokeWidth = 2
//      ..style = PaintingStyle.fill;
//
//    Path path = Path();
//
//    path.moveTo(0, size.height / 2);
//    path.relativeLineTo(size.width / 2 - 60, size.height / 2);
//
//    path.relativeArcToPoint(Offset(size.width / 2 + 60, size.height / 2), radius: Radius.circular(60),);
//    path.relativeLineTo(size.width, size.height/2);
//    path.close();
//
//    canvas.drawShadow(path, Color(0x33000000), 2.0, false);
//    canvas.drawPath(path, paint);

    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    double start = size.width / 2 - 60;
    double end = size.width / 2 + 60;

    Path path = Path();
    path.moveTo(0, size.height / 2);
    path.lineTo(start, size.height / 2);

    double newPointX = (end + start) / 2;
    double newPointY = size.height / 2 - 120;

    path.quadraticBezierTo(newPointX, newPointY, end, size.height / 2);
    path.lineTo(size.width, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
