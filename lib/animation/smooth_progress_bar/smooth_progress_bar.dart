import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Draws a circular animated progress bar.
class SmoothProgressBar extends StatefulWidget {
  final Duration animationDuration;
  final Color backgroundColor;
  final Color foregroundColor;
  final double value;

  const SmoothProgressBar({
    Key key,
    this.animationDuration,
    this.backgroundColor,
    @required this.foregroundColor,
    @required this.value,
  }) : super(key: key);

  @override
  SmoothProgressBarState createState() {
    return SmoothProgressBarState();
  }
}

class SmoothProgressBarState extends State<SmoothProgressBar>
    with SingleTickerProviderStateMixin {
  static const TRANSPARENT = Color(0x00000000);
  AnimationController _controller;

  Animation<double> curve;
  Tween<double> valueTween;
  Tween<Color> backgroundColorTween;
  Tween<Color> foregroundColorTween;

  @override
  void initState() {
    super.initState();

    this._controller = AnimationController(
      duration: this.widget.animationDuration ?? const Duration(seconds: 1),
      vsync: this,
    );

    this.curve = CurvedAnimation(
      parent: this._controller,
      curve: Curves.linear,
    );

    // Build the initial required tweens.
    this.valueTween = Tween<double>(
      begin: 0,
      end: this.widget.value,
    );

    this._controller.forward();
  }

  @override
  void didUpdateWidget(SmoothProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (this.widget.value != oldWidget.value) {
      // Try to start with the previous tween's end value. This ensures that we
      // have a smooth transition from where the previous animation reached.
      double beginValue =
          this.valueTween?.evaluate(this.curve) ?? oldWidget?.value ?? 0;

      // Update the value tween.
      this.valueTween = Tween<double>(
        begin: beginValue,
        end: this.widget.value ?? 1,
      );

      // Clear cached color tweens when the color hasn't changed.
      if (oldWidget?.backgroundColor != this.widget.backgroundColor) {
        this.backgroundColorTween = ColorTween(
          begin: oldWidget?.backgroundColor ?? TRANSPARENT,
          end: this.widget.backgroundColor ?? TRANSPARENT,
        );
      } else {
        this.backgroundColorTween = null;
      }

      if (oldWidget.foregroundColor != this.widget.foregroundColor) {
        this.foregroundColorTween = ColorTween(
          begin: oldWidget?.foregroundColor,
          end: this.widget.foregroundColor,
        );
      } else {
        this.foregroundColorTween = null;
      }

      this._controller
        ..value = 0
        ..forward();
    }
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: this.curve,
      child: Container(),
      builder: (context, child) {
        final backgroundColor =
            this.backgroundColorTween?.evaluate(this.curve) ??
                this.widget.backgroundColor;
        final foregroundColor =
            this.foregroundColorTween?.evaluate(this.curve) ??
                this.widget.foregroundColor;

        return CustomPaint(
          child: child,
          foregroundPainter: SmoothProgressBarPainter(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            percentage: this.valueTween.evaluate(this.curve),
          ),
        );
      },
    );
  }
}

class SmoothProgressBarPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final Color backgroundColor;
  final Color foregroundColor;

  SmoothProgressBarPainter({
    this.backgroundColor,
    @required this.foregroundColor,
    @required this.percentage,
    double strokeWidth,
  }) : this.strokeWidth = strokeWidth ?? 6;

  @override
  void paint(Canvas canvas, Size size) {
    final foregroundPaint = Paint()
      ..color = this.foregroundColor
      ..strokeWidth = this.strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Offset startLine = Offset(0, 0);

    Offset endLine;
    if (percentage >= 1) {
      endLine = Offset(size.width, 0);
    } else {
      endLine = Offset(size.width * percentage, 0);
    }

    canvas.drawLine(startLine, endLine, foregroundPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = (oldDelegate as SmoothProgressBarPainter);
    return oldPainter.percentage != this.percentage ||
        oldPainter.backgroundColor != this.backgroundColor ||
        oldPainter.foregroundColor != this.foregroundColor ||
        oldPainter.strokeWidth != this.strokeWidth;
  }
}
