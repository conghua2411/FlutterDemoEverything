import 'package:flutter/material.dart';

import 'board_paint_path.dart';
import 'board_painter.dart';

class BoardItem extends StatefulWidget {

  final double width, height;

  final List<BoardPaintPath> listDirDraw;

  BoardItem({
    @required this.width,
    @required this.height,
    @required this.listDirDraw,
  });

  @override
  State createState() => BoardItemState();
}

class BoardItemState extends State<BoardItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: CustomPaint(
        painter: BoardPainter(
          listDirDraw: widget.listDirDraw,
        ),
        child: Center(
          child: Container(
            width: widget.width - 10,
            height: widget.height - 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}