import 'package:flutter/material.dart';

class ExpandedSection extends StatefulWidget {

  final Widget child;
  final bool expand;

  ExpandedSection({this.expand = false, this.child});

  @override
  State createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection>
    with SingleTickerProviderStateMixin {

  AnimationController expandedController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: animation,
      child: widget.child,
    );
  }

  void prepareAnimation() {
    expandedController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    Animation curve = CurvedAnimation(
        parent: expandedController, curve: Curves.fastOutSlowIn);

    animation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {

        });
      });
  }

  @override
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expand) {
      expandedController.forward();
    } else {
      expandedController.reverse();
    }
  }

  @override
  void dispose() {
    expandedController.dispose();
    super.dispose();
  }
}