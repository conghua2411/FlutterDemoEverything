import 'dart:math';

import 'package:flutter/material.dart';

class PlaceQueensPuzzle extends StatefulWidget {
  @override
  _PlaceQueensPuzzleState createState() => _PlaceQueensPuzzleState();
}

class _PlaceQueensPuzzleState extends State<PlaceQueensPuzzle> {
  List<Queen> listQueen = [];

  int current = 0;

  List<List<Queen>> list8Queen = [];

  @override
  void initState() {
    super.initState();

    Calculate8Queen.cal2(listQueen, r: list8Queen);

    print('r: ${list8Queen.length}');

    listQueen = list8Queen[current];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('PlaceQueensPuzzle'),
      ),
      body: Column(
        children: [
          _board(),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            color: Colors.blueAccent,
            child: Text(
              'Clear',
            ),
            onPressed: () {
              setState(() {
                listQueen = [];
              });
            },
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            color: Colors.blueAccent,
            child: Text(
              'Change',
            ),
            onPressed: () {
              setState(() {
                listQueen = _changeList8Queen();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _board() {
    double boardSize = min(
      MediaQuery.of(context).size.width / 8,
      MediaQuery.of(context).size.height / 8,
    );

    List<Widget> board = List.generate(8, (index) {
      return _buildRowBoard(index, boardSize);
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: board,
    );
  }

  Widget _buildRowBoard(int colIndex, double size) {
    List<Widget> widgets = [];

    widgets = List.generate(8, (rowIndex) {
      return Container(
        width: size,
        height: size,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () {
              setState(() {
                if (isQueenHere(
                  colIndex,
                  rowIndex,
                  listQueen,
                )) {
                  _removeQueen(colIndex, rowIndex);
                } else {
                  if (!isOnTheQueenWay(colIndex, rowIndex, listQueen)) {
                    listQueen.add(
                      Queen(
                        x: colIndex,
                        y: rowIndex,
                      ),
                    );
                  }
                }
              });
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: isQueenHere(
                  colIndex,
                  rowIndex,
                  listQueen,
                )
                    ? Colors.red
                    : isOnTheQueenWay(colIndex, rowIndex, listQueen)
                        ? Colors.amberAccent
                        : Colors.white,
              ),
              child: Center(
                child: Text(
                  '${isQueenHere(
                    colIndex,
                    rowIndex,
                    listQueen,
                  ) ? '${Queen(x: colIndex, y: rowIndex)}' : ''}',
                ),
              ),
            ),
          ),
        ),
      );
    });

    return Row(
      children: widgets,
    );
  }

  bool isQueenHere(int x, int y, List<Queen> list) {
    return list.contains(Queen(x: x, y: y));
  }

  bool isOnTheQueenWay(int x, int y, List<Queen> list) {
    bool isOnTheQueenWay = false;
    for (int i = 0; i < list.length; i++) {
      isOnTheQueenWay |= list[i].isOnMyWay(x, y);
    }
    return isOnTheQueenWay;
  }

  void _removeQueen(int x, int y) {
    listQueen = listQueen.where((q) {
      return q.x != x && q.y != y;
    }).toList();
  }

  List<Queen> _changeList8Queen() {
    return list8Queen[(++current)%list8Queen.length];
  }
}

class Calculate8Queen {
  static void cal2(
    List<Queen> list, {
    int index = 0,
    List<List<Queen>> r,
  }) {
    if (index > 7) {
      if (list.length == 8) {
        r.add(list);
      }
      return;
    }

    for (int i = 0; i < 8; i++) {
      if (!isInListQueenWay(index, i, list)) {
        List<Queen> l = Queen.cloneList(list);

        l.add(Queen(x: index, y: i));

        cal2(
          l,
          index: index + 1,
          r: r,
        );
      }
    }
  }

  static List<Queen> cal(
    List<Queen> list, {
    int index = 0,
  }) {
    print('list: ${list.length} --- index: $index');
    if (index == 7) {
      return list;
    }

    for (int i = 0; i < 8; i++) {
      if (index == 0) {
        print('index: $index --- i: $i --- ${list.length}');
      }
      if (!isInListQueenWay(index, i, list)) {
        print('choose index: $index --- i: $i');

        List<Queen> l = Queen.cloneList(list);

        l.add(Queen(x: index, y: i));
        if (cal(list, index: index + 1).length == 8) {
          return list;
        }
      }
    }

    return list;
  }

  static bool isInListQueenWay(int x, int y, List<Queen> list) {
    bool isOnTheQueenWay = false;
    for (int i = 0; i < list.length; i++) {
      isOnTheQueenWay |= list[i].isOnMyWay(x, y);
    }
    return isOnTheQueenWay;
  }
}

class Queen {
  int x, y;

  Queen({
    this.x,
    this.y,
  });

  bool isOnMyWay(int x, int y) {
    if (x == this.x) return true;
    if (y == this.y) return true;
    if ((x - this.x).abs() == (y - this.y).abs()) return true;
    return false;
  }

  static Queen clone(Queen q) {
    return Queen(
      x: q.x,
      y: q.y,
    );
  }

  static List<Queen> cloneList(List<Queen> list) {
    return list.map((e) => Queen.clone(e)).toList();
  }

  @override
  bool operator ==(Object other) {
    return other is Queen && this.x == other.x && this.y == other.y;
  }

  @override
  String toString() {
    return 'Q(${x + 1}, ${y + 1})';
  }

  @override
  int get hashCode {
    return this.x.hashCode * this.y.hashCode;
  }
}
