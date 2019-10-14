import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';

class SuperTooltipDemo extends StatefulWidget {

  @override
  State createState() => SuperTooltipDemoState();
}

class SuperTooltipDemoState extends State<SuperTooltipDemo> {

  SuperTooltip tooltip;

  Future<bool> _willPopCallback() async {
    // If the tooltip is open we don't pop the page on a backbutton press
    // but close the ToolTip
    if (tooltip.isOpen) {
      tooltip.close();
      return false;
    }
    return true;
  }

  void _onTap() {
    if (tooltip != null && tooltip.isOpen) {
      tooltip.close();
      return;
    }

    RenderBox renderBox = context.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    var targetGlobalCenter =
    renderBox.localToGlobal(renderBox.size.center(Offset.zero), ancestor: overlay);

    // We create the tooltip on the first use
    tooltip = SuperTooltip(
      popupDirection: TooltipDirection.left,
      arrowTipDistance: 1.0,
      arrowBaseWidth: 5.0,
      arrowLength: 10.0,
      borderColor: Colors.green,
      borderWidth: 2.0,
      snapsFarAwayVertically: true,
      showCloseButton: ShowCloseButton.inside,
      hasShadow: false,
      touchThrougArea: new Rect.fromLTWH(targetGlobalCenter.dx-100, targetGlobalCenter.dy-100, 200.0, 160.0),
      touchThroughAreaShape: ClipAreaShape.rectangle,

      content: new Material(
          child: Padding(
            padding: const EdgeInsets.only(top:20.0),
            child: Text(
              "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, "
                  "sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, "
                  "sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. ",
              softWrap: true,
            ),
          )),
    );

    tooltip.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text('SuperTooltipDemo'),
        ),
        body: Container(
          color: Colors.red,
          child: Center(
            child: GestureDetector(
              onTap: _onTap,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.red
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}