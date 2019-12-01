import 'package:flutter/material.dart';
import 'package:flutter_app/xiangqi_game/piece/piece.dart';
import 'package:flutter_app/xiangqi_game/pos/position.dart';

import 'flag.dart';

class Ma extends Piece {
  Ma(
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
  List<Position> getListPosMove() {
    List<Position> list = List();

    // top_left
    list.add(Position(
      x: posX - 1,
      y: posY - 2,
    ));
    // top_right
    list.add(Position(
      x: posX + 1,
      y: posY - 2,
    ));
    // right_top
    list.add(Position(
      x: posX + 2,
      y: posY - 1,
    ));
    // right_bot
    list.add(Position(
      x: posX + 2,
      y: posY + 1,
    ));

    // bot_right
    list.add(Position(
      x: posX + 1,
      y: posY + 2,
    ));
    // bot_left
    list.add(Position(
      x: posX - 1,
      y: posY + 2,
    ));
    // left_bot
    list.add(Position(
      x: posX - 2,
      y: posY + 1,
    ));
    // left_top
    list.add(Position(
      x: posX - 2,
      y: posY - 1,
    ));

    return list;
  }

  @override
  Widget buildPiece() {
    return Text(
      'Ma',
      style: TextStyle(
        fontSize: 8,
        color: flag == Flag.BLACK ? Colors.black : Colors.red,
      ),
    );
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
          // check left
          if (posX - pos.x == 2) {
            return !checkCollisionOnBoard(
                listPieces, Position(x: posX - 1, y: posY));
          }

          // check right
          if (pos.x - posX == 2) {
            return !checkCollisionOnBoard(
                listPieces, Position(x: posX + 1, y: posY));
          }

          // check top
          if (posY - pos.y == 2) {
            return !checkCollisionOnBoard(
                listPieces, Position(x: posX, y: posY - 1));
          }

          // check bot
          if (pos.y - posY == 2) {
            return !checkCollisionOnBoard(
                listPieces, Position(x: posX, y: posY + 1));
          }
          return false;
        } else {
          return false;
        }
      }
    }).toList();
  }
}
