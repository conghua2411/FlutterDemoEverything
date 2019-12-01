import 'package:flutter/material.dart';

import 'board_paint_path.dart';

class BoardPainter extends CustomPainter {
  final List<BoardPaintPath> listDirDraw;

  BoardPainter({
    @required this.listDirDraw,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = Colors.amber
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    Offset centerOffset = Offset(size.width / 2, size.height / 2);

    listDirDraw.forEach((dir) {
      switch (dir) {
        case BoardPaintPath.TOP:
          canvas.drawLine(centerOffset, Offset(size.width / 2, 0), line);
          break;
        case BoardPaintPath.TOP_LEFT:
          canvas.drawLine(centerOffset, Offset(0, 0), line);
          break;
        case BoardPaintPath.TOP_RIGHT:
          canvas.drawLine(centerOffset, Offset(size.width, 0), line);
          break;
        case BoardPaintPath.BOTTOM:
          canvas.drawLine(
              centerOffset, Offset(size.width / 2, size.height), line);
          break;
        case BoardPaintPath.BOTTOM_LEFT:
          canvas.drawLine(centerOffset, Offset(0, size.height), line);
          break;
        case BoardPaintPath.BOTTOM_RIGHT:
          canvas.drawLine(centerOffset, Offset(size.width, size.height), line);
          break;
        case BoardPaintPath.LEFT:
          canvas.drawLine(centerOffset, Offset(0, size.height / 2), line);
          break;
        case BoardPaintPath.RIGHT:
          canvas.drawLine(
              centerOffset, Offset(size.width, size.height / 2), line);
          break;
      }
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}