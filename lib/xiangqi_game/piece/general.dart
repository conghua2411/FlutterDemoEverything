import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/xiangqi_game/piece/piece.dart';
import 'package:flutter_app/xiangqi_game/pos/position.dart';

import 'flag.dart';

class General extends Piece {
  General(
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
      'General',
      style: TextStyle(
        fontSize: 8,
        color: flag == Flag.BLACK ? Colors.black : Colors.red,
      ),
    );
  }

  @override
  List<Position> getListPosMove() {
    List<Position> list = List();

    // top
    list.add(Position(
      x: posX,
      y: posY - 1,
    ));
    // right
    list.add(Position(
      x: posX + 1,
      y: posY,
    ));
    // bot
    list.add(Position(
      x: posX,
      y: posY + 1,
    ));
    // left
    list.add(Position(
      x: posX - 1,
      y: posY,
    ));

    return list;
  }

  Piece findAnotherGeneral(List<Piece> listPieces, Flag generalFlag) {
    return listPieces.firstWhere((piece) {
      return piece is General && piece.flag == generalFlag;
    });
  }

  @override
  List<Position> checkPosOnBoardCanMove(List<Piece> listPieces) {
    List<Position> list = getListPosMove();

    list = list.where((pos) {
      if (this.flag == Flag.BLACK) {
        // black is on top
        // check out of bound
        if (pos.x < 3 || pos.x > 5) {
          return false;
        } else if (pos.y < 0 || pos.y > 2) {
          return false;
        } else {
          // check collision
          return !checkCollisionOnBoardWithSameFlag(listPieces, pos);
        }
      } else {
        // red is bottom
        // check out of bound
        if (pos.x < 3 || pos.x > 5) {
          return false;
        } else if (pos.y < 7 || pos.y > 9) {
          return false;
        } else {
          // check collision
          return !checkCollisionOnBoardWithSameFlag(listPieces, pos);
        }
      }
    }).toList();

    // check if 2 general review face
    Piece anotherGeneral =
    findAnotherGeneral(listPieces, Flag.values[(flag.index + 1) % 2]);
    if (posX == anotherGeneral.posX) {
      // check path from 2 general

      int start = min(posY, anotherGeneral.posY);
      int end = max(posY, anotherGeneral.posY);

      int pieceCount = 0;

      for (int i = start+1 ; i < end ; i++) {
        if (checkCollisionOnBoard(listPieces, Position(x: posX, y: i))) {
          pieceCount++;
        }
      }

      if (pieceCount == 0) {
        list.add(Position(x: anotherGeneral.posX, y: anotherGeneral.posY));
      }
    }

    return list;
  }
}
