import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

abstract class LineFactory {
  Line createLine({
    List<Offset> points,
    Color penColor,
    double penSize,
  });
}

class SmoothLineFactory extends LineFactory {
  @override
  Line createLine({
    List<Offset> points,
    Color penColor,
    double penSize,
  }) {
    return SmoothLine(
      points: points,
      penColor: penColor,
      penSize: penSize,
    );
  }
}

class NormalLineFactory extends LineFactory {
  @override
  Line createLine({
    List<Offset> points,
    Color penColor,
    double penSize,
  }) {
    return NormalLine(
      points: points,
      penColor: penColor,
      penSize: penSize,
    );
  }
}

class StarLineFactory extends LineFactory {
  @override
  Line createLine({
    List<Offset> points,
    Color penColor,
    double penSize,
  }) {
    return StarLine(
      points: points,
      penColor: penColor,
      penSize: penSize,
    );
  }
}

enum LineType {
  Smooth,
  Normal,
  Star,
}

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
    for (int i = 1; i < points.length; i++) {
      canvas.drawLine(
        points[i - 1],
        points[i],
        paint
          ..color = penColor
          ..strokeWidth = penSize ?? 1,
      );
    }
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

class StarLine extends Line {
  double r = 25;

  StarLine({
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
    for (int i = 0; i < points.length; i++) {
      _drawAStar(canvas, paint, point: points[i]);
    }
  }

  void _drawAStar(Canvas canvas, Paint paint, {Offset point}) {
    /// angle
    /// 0
    /// 2 * pi / 5
    /// 4 * pi / 5
    /// 6 * pi / 5
    /// 8 * pi / 5
    /// 2 * pi
    ///
    List<double> angles = [
      pi,
      2 * pi / 5 + pi,
      4 * pi / 5 + pi,
      6 * pi / 5 + pi,
      8 * pi / 5 + pi,
    ];

    List<Offset> offsets = angles.map((a) {
      return Offset(
        r * sin(a) + point.dx,
        r * cos(a) + point.dy,
      );
    }).toList();

    for (int i = 0; i < offsets.length; i++) {
      canvas.drawLine(
        offsets[i],
        offsets[(i + 2) % 5],
        paint
          ..color = penColor
          ..strokeWidth = penSize ?? 1,
      );
    }
  }
}
