import 'package:flutter/material.dart';

class FireLight extends StatefulWidget {
  final Animation animation;
  final double height;
  final double width;
  final Color color;

  FireLight({
    this.animation,
    this.height,
    this.width,
    this.color = Colors.amberAccent,
  });

  @override
  _FireLightState createState() => _FireLightState();
}

class _FireLightState extends State<FireLight> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: widget.height +
                  (widget.width - widget.height) * widget.animation.value,
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  widget.height,
                ),
                color: widget.color,
              ),
            ),
          ),
        );
      },
      child: Container(),
    );
  }
}
