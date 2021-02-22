import 'package:flutter/material.dart';
import 'package:flutter_app/animation/paint/draw_item/line.dart';

class MyPainter extends CustomPainter {
  List<Line> list;

  MyPainter({
    this.list,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    list.forEach((line) {
      line.draw(canvas, paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
