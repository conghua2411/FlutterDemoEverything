import 'package:flutter/material.dart';
import 'package:flutter_app/xiangqi_game/piece/piece.dart';
import 'package:flutter_app/xiangqi_game/pos/position.dart';

import 'flag.dart';

class Voi extends Piece {
  Voi(
    double width,
    double height,
    int posX,
    int posY,
    Flag flag,
    Function(List<Position> posCanMove, Piece) onPieceClick,
  ) : super(
          width: width,
          height: height,
          posX: posX,
          posY: posY,
          flag: flag,
          onPieceClick: onPieceClick,
        );

  @override
  Widget buildPiece() {
    return Text(
      'Tuong',
      style: TextStyle(
        fontSize: 8,
        color: flag == Flag.BLACK ? Colors.black : Colors.red,
      ),
    );
  }

  @override
  List<Position> getListPosMove() {
    List<Position> list = List();

    list.add(Position(x: posX - 2, y: posY - 2));
    list.add(Position(x: posX - 2, y: posY + 2));
    list.add(Position(x: posX + 2, y: posY - 2));
    list.add(Position(x: posX + 2, y: posY + 2));

    return list;
  }

  @override
  List<Position> checkPosOnBoardCanMove(List<Piece> listPieces) {
    List<Position> list = getListPosMove();

    return list.where((pos) {
      if (pos.x < 0 || pos.x > 8) {
        return false;
      } else if (pos.y < 0 || pos.y > 9) {
        return false;
      } else {

        // check over the river
        if (flag == Flag.BLACK) {
          if (pos.y > 4)
            return false;
        } else {
          if (pos.y < 5)
            return false;
        }

        if (!checkCollisionOnBoardWithSameFlag(listPieces, pos)) {
          // check top_left
          return !checkCollisionOnBoard(listPieces,
              Position(x: (pos.x + posX) ~/ 2, y: (pos.y + posY) ~/ 2));
        } else {
          return false;
        }
      }
    }).toList();
  }
}
