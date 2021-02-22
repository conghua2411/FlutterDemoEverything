import 'dart:ui';
import 'package:flutter/material.dart';

abstract class Line {
  List<Offset> points;
  Color penColor;
  double penSize;

  Line({
    this.points,
    this.penColor,
    this.penSize,
  });

  void addPoint({Offset point}) {
    points.add(point);
  }

  void draw(Canvas canvas, Paint paint);
}

class SmoothLine extends Line {
  SmoothLine({
    List<Offset> points,
    Color penColor,
    double penSize,
  }) : super(
          points: points,
          penColor: penColor,
          penSize: penSize,
        );

  @override
  void draw(Canvas canvas, Paint paint) {
    Path path = Path();

    path.moveTo(
      points[0].dx,
      points[0].dy,
    );

    for (int i = 1; i < points.length; i++) {
      path.lineTo(
        points[i].dx,
        points[i].dy,
      );
    }

    canvas.drawPath(
      path,
      paint
        ..color = penColor
        ..strokeWidth = penSize ?? 1,
    );
  }
}

class NormalLine extends Line {
  NormalLine({
    List<Offset> points,
    Color penColor,
    double penSize,
  }) : super(
          points: points,
          penColor: penColor,
          penSize: penSize,
        );

  @override
  void draw(Canvas canvas, Paint paint) {
    canvas.drawPoints(
      PointMode.points,
      points,
      paint
        ..color = penColor
        ..strokeWidth = penSize,
    );
  }
}
