import 'package:flutter/material.dart';

class CustomSlideColorBar extends StatefulWidget {
  final Color colorMain;

  CustomSlideColorBar({this.colorMain = Colors.white});

  @override
  State createState() => CustomSlideColorBarState();
}

class CustomSlideColorBarState extends State<CustomSlideColorBar> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Transform(
        transform: new Matrix4.identity()..rotateZ(90 * 3.1415927 / 180),
        child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 10,
              activeTrackColor: Colors.white,
              trackShape: CustomTrack(colorMain: widget.colorMain),
              thumbColor: Colors.white,
              thumbShape: CustomThumb(
                  thumbRadius: 8, value: _value, colorMain: widget.colorMain),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
            ),
            child: Slider(
              value: _value,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            )),
      ),
    );
  }
}

// thumb
class CustomThumb extends SliderComponentShape {
  final double thumbRadius;
  final double value;
  final Color colorMain;

  CustomThumb({
    this.thumbRadius = 6.0,
    this.value = 0,
    this.colorMain = Colors.white,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {Animation<double> activationAnimation,
      Animation<double> enableAnimation,
      bool isDiscrete,
      TextPainter labelPainter,
      RenderBox parentBox,
      SliderThemeData sliderTheme,
      TextDirection textDirection,
      double value,
      double textScaleFactor,
      Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    final rect = Rect.fromCircle(center: center, radius: thumbRadius);

    final rrect = RRect.fromRectAndRadius(
      Rect.fromPoints(
        Offset(rect.left - 1, rect.top),
        Offset(rect.right + 1, rect.bottom),
      ),
      Radius.circular(thumbRadius - 2),
    );

    final fillPaint = Paint()
//      ..color = sliderTheme.activeTrackColor
//      ..color = Colors.blue
      ..color = Color.fromARGB(
          0xff,
          (colorMain.red * (1 - value)).toInt(),
          (colorMain.green * (1 - value)).toInt(),
          (colorMain.blue * (1 - value)).toInt())
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.8
      ..style = PaintingStyle.stroke;

//    canvas.drawRRect(rrect, fillPaint);
//    canvas.drawRRect(rrect, borderPaint);

    canvas.drawCircle(Offset(center.dx, center.dy), 10, fillPaint);
  }
}

// track
class CustomTrack extends SliderTrackShape {
  final Color colorMain;

  CustomTrack({this.colorMain = Colors.white});

  @override
  Rect getPreferredRect(
      {RenderBox parentBox,
      Offset offset = Offset.zero,
      SliderThemeData sliderTheme,
      bool isEnabled,
      bool isDiscrete}) {
    final double thumbWidth =
        sliderTheme.thumbShape.getPreferredSize(true, isDiscrete).width;
    final double trackHeight = sliderTheme.trackHeight;
    assert(thumbWidth >= 0);
    assert(trackHeight >= 0);
    assert(parentBox.size.width >= thumbWidth);
    assert(parentBox.size.height >= trackHeight);

    final double trackLeft = offset.dx + thumbWidth / 2;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - thumbWidth;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(PaintingContext context, Offset offset,
      {RenderBox parentBox,
      SliderThemeData sliderTheme,
      Animation<double> enableAnimation,
      Offset thumbCenter,
      bool isEnabled,
      bool isDiscrete,
      TextDirection textDirection}) {
    if (sliderTheme.trackHeight == 0) {
      return;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Gradient gradientLinear = new LinearGradient(
      colors: <Color>[
        colorMain,
        Colors.black,
      ],
    );

    final Paint fillPaint = Paint()
//      ..color = sliderTheme.activeTrackColor
      ..shader = gradientLinear.createShader(trackRect)
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final pathSegment = Path()
      ..moveTo(trackRect.left, trackRect.top)
      ..lineTo(trackRect.right, trackRect.top)
      ..lineTo(trackRect.right, trackRect.bottom)
      ..lineTo(trackRect.left, trackRect.bottom)
      ..lineTo(trackRect.left, trackRect.top);

    context.canvas.drawRect(trackRect, fillPaint);

//    context.canvas.drawPath(pathSegment, fillPaint);
    context.canvas.drawPath(pathSegment, borderPaint);
  }
}
