import 'package:flutter/material.dart';
import 'package:flutter_app/animation/paint/painter/my_painter.dart';

import 'draw_item/line.dart';

class PaintDemo extends StatefulWidget {
  @override
  _PaintDemoState createState() => _PaintDemoState();
}

class _PaintDemoState extends State<PaintDemo> {
  List<Line> drawingLine;

  Color canvasBackground = Colors.white;

  Color penColor = Colors.primaries[0];
  double penSize = 1;

  @override
  void initState() {
    super.initState();
    drawingLine = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Paint demo'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.undo,
            ),
            onPressed: () {
              setState(() {
                setState(() {
                  drawingLine.removeLast();
                });
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onPanStart: (details) {
                  print(
                      'onPanStart: ${details.localPosition} ---- ${details.globalPosition}\n --- ${drawingLine.length}');
                  drawingLine.add(
                    SmoothLine(
                      points: [],
                      penColor: penColor,
                      penSize: penSize,
                    ),
                  );
                },
                onPanCancel: () {
                  print('onPanCancel');
                },
                onPanDown: (details) {
                  print(
                      'onPanDown: ${details.localPosition} ---- ${details.globalPosition}');
                },
                onPanEnd: (details) {
                  print(
                      'onPanEnd: ${details.velocity} ---- ${details.primaryVelocity}');
                  setState(() {});
                },
                onPanUpdate: (details) {
                  print(
                      'onPanUpdate: ${details.localPosition} ---- ${details.globalPosition}');
                  setState(() {
                    drawingLine[drawingLine.length - 1].addPoint(
                      point: details.localPosition,
                    );
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: canvasBackground,
                  child: CustomPaint(
                    foregroundPainter: MyPainter(
                      list: drawingLine,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.amberAccent,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.palette),
                            onPressed: () {
                              _showColorPicker(
                                currentColor: penColor,
                              ).then((color) {
                                if (color != null) {
                                  penColor = color;
                                }
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.adjust),
                            onPressed: () {
                              _adjustPenSize(
                                currentPenSize: penSize,
                              ).then((value) {
                                if (value != null) {
                                  penSize = value;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Color> _showColorPicker({Color currentColor}) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop(Colors.primaries[index]);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: currentColor != null &&
                            currentColor.value == Colors.primaries[index].value
                        ? Border.all(
                            width: 2,
                            color: Colors.blue,
                          )
                        : null,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.primaries[index],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: Colors.primaries.length,
        );
      },
    );
  }

  Future<double> _adjustPenSize({double currentPenSize}) {
    double penSize = currentPenSize;

    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Adjust Pen Size',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    child: Text(
                      'OK',
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(penSize);
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16,
              ),
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Slider(
                    min: 0.5,
                    max: 10,
                    value: penSize ?? 1,
                    onChanged: (selection) {
                      setState(() {
                        penSize = selection;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        );
      },
    );
  }
}
