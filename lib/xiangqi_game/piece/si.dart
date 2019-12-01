import 'package:flutter/material.dart';
import 'package:flutter_app/xiangqi_game/piece/piece.dart';
import 'package:flutter_app/xiangqi_game/pos/position.dart';

import 'flag.dart';

class Si extends Piece {
  Si(
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
      'Si',
      style: TextStyle(
        fontSize: 8,
        color: flag == Flag.BLACK ? Colors.black : Colors.red,
      ),
    );
  }

  @override
  List<Position> getListPosMove() {
    List<Position> list = List();

    list.add(Position(x: posX - 1, y: posY - 1));
    list.add(Position(x: posX - 1, y: posY + 1));
    list.add(Position(x: posX + 1, y: posY - 1));
    list.add(Position(x: posX + 1, y: posY + 1));

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
        if (!checkCollisionOnBoardWithSameFlag(listPieces, pos)) {
          if (flag == Flag.BLACK) {
            if (pos.x < 3 || pos.x > 5) {
              return false;
            }

            if (pos.y < 0 || pos.y > 2) {
              return false;
            }

            return true;
          } else {
            if (pos.x < 3 || pos.x > 5) {
              return false;
            }

            if (pos.y < 7 || pos.y > 9) {
              return false;
            }

            return true;
          }
        } else {
          return false;
        }
      }
    }).toList();
  }
}
