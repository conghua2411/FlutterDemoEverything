import 'package:flutter/material.dart';

class MyPaint extends CustomPainter {
  var customPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.blue
    ..isAntiAlias = true
    ..strokeWidth = 5;

  double state = -1;

  MyPaint({this.state}): super();

  @override
  void paint(Canvas canvas, Size size) {
    print('paint : hello $state');
//    var path = Path();
//
//    var controlPoint1 = Offset(size.width / 4, size.height / 2 - 40);
//    var controlPoint2 = Offset(size.width * 3 / 4, size.height / 2 + 40);
//
//    path.moveTo(0, size.height / 2);
//
//    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
//        controlPoint2.dy, size.width, size.height);
//
//    canvas.drawPath(path, customPaint);

    var startPoint = Offset(0, size.height / 2);

//    var controlPoint1 = Offset(size.width / 4, size.height / 3);
//    var controlPoint2 = Offset(3 * size.width / 4, 2 * size.height / 3);

    var controlPoint1 = Offset(size.width / 2, size.height / 2 + 30*state);
    var controlPoint2 = Offset(size.width / 2, size.height / 2 + 30*state);

    var endPoint = Offset(size.width, size.height / 2);

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    canvas.drawPath(path, customPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
