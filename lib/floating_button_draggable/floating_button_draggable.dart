import 'package:flutter/material.dart';
import 'package:flutter_app/floating_button_draggable/under_screen.dart';

class FloatButtonDraggable extends StatefulWidget {
  @override
  State createState() => FloatButtonDraggableState();
}

class FloatButtonDraggableState extends State<FloatButtonDraggable> {
  Offset pos = Offset(0, 0);

  double iconSize = 48;

  AppBar appBar = AppBar(
    title: Text('FloatButtonDraggable'),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
//      appBar: appBar,
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            MaterialApp(home: UnderScreenDemo()),
            Positioned(
              left: pos.dx,
              top: pos.dy,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Draggable(
                  feedback: Container(
                    width: iconSize,
                    height: iconSize,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Icon(
                      Icons.drag_handle,
                    ),
                  ),
                  child: Container(
                    width: iconSize,
                    height: iconSize,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Icon(
                      Icons.drag_handle,
                    ),
                  ),
                  childWhenDragging: Container(),
                  onDragEnd: (details) {
                    print(details.offset);

                    Offset offset = details.offset;

                    setState(() {
                      double appBarHeight = 0;
//                  if (appBar != null) {
//                    appBarHeight = appBar.preferredSize.height;
//                  }

                      var dy = offset.dy -
                          appBarHeight -
                          MediaQuery.of(context).padding.top;

                      var maxDy = MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.bottom -
                          appBarHeight -
                          MediaQuery.of(context).padding.top;

//                  print('maxDy : $maxDy --- dy : $dy \n'
//                      '--- offset.dy : ${offset.dy} \n'
//                      '--- appBarHeight : $appBarHeight \n'
//                      '--- MediaQuery.of(context).padding.top: ${MediaQuery.of(context).padding.top}');

                      // top
                      if (dy < 0) {
                        dy = 0;
                      }

                      // bottom
                      if (offset.dy >
                          MediaQuery.of(context).size.height -
                              MediaQuery.of(context).padding.bottom -
                              iconSize) {
                        dy = maxDy - iconSize;
                      }

                      double dx = offset.dx;

                      // left
                      if (dx < 0) {
                        dx = 0;
                      }

                      // right
                      if (dx > MediaQuery.of(context).size.width - iconSize) {
                        dx = MediaQuery.of(context).size.width - iconSize;
                      }

                      Offset newOffset = new Offset(dx, dy);
                      pos = newOffset;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
