import 'package:flutter/material.dart';
import 'package:flutter_app/xiangqi_game/piece/piece.dart';
import 'package:flutter_app/xiangqi_game/pos/position.dart';

import 'flag.dart';

class Tot extends Piece {
  Tot(
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
      'Tot',
      style: TextStyle(
        fontSize: 8,
        color: flag == Flag.BLACK ? Colors.black : Colors.red,
      ),
    );
  }

  @override
  List<Position> getListPosMove() {
    List<Position> list = List();

    list.add(Position(x: posX-1, y: posY));
    list.add(Position(x: posX+1, y: posY));
    list.add(Position(x: posX, y: posY-1));
    list.add(Position(x: posX, y: posY+1));

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
          // check flag
          if (flag == Flag.BLACK) {
            // can't fall back
            if (posY - pos.y == 1) {
              return false;
            }

            // check over the river
            if (posY > 4) {
              return true;
            } else {
              // force forward
              if (pos.y - posY == 1) {
                return true;
              } else {
                return false;
              }
            }
          } else {
            // can't fall back
            if (pos.y - posY == 1) {
              return false;
            }

            // check over the river
            if (posY < 5) {
              return true;
            } else {
              // force forward
              if (posY - pos.y == 1) {
                return true;
              } else {
                return false;
              }
            }
          }
        } else {
          return false;
        }
      }
    }).toList();
  }
}
