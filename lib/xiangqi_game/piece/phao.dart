import 'package:flutter/material.dart';
import 'package:flutter_app/xiangqi_game/piece/piece.dart';
import 'package:flutter_app/xiangqi_game/pos/position.dart';

import 'flag.dart';

class Phao extends Piece {
  Phao(
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
      'Phao',
      style: TextStyle(
        fontSize: 8,
        color: flag == Flag.BLACK ? Colors.black : Colors.red,
      ),
    );
  }

  @override
  List<Position> getListPosMove() {
    List<Position> list = List();
    // row
    for(int i = 0 ; i < 9 ; i++) {
      if (i != posX) {
        list.add(Position(x: i, y: posY));
      }
    }

    // col
    for(int i = 0 ; i < 10 ; i++) {
      if (i != posY) {
        list.add(Position(x: posX, y: i));
      }
    }

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

        if (posX == pos.x) {
          // row
          int start = posY > pos.y ? pos.y : posY;
          int end = posY < pos.y ? pos.y : posY;

          int pieceCount = 0;

          for (int i = start+1 ; i < end; i++) {
            if (checkCollisionOnBoard(listPieces, Position(x: posX, y: i))){
              pieceCount++;
            }
          }

          if (checkCollisionOnBoard(listPieces, pos)) {
            if (checkCollisionOnBoardWithSameFlag(listPieces, pos))
              return false;
            return pieceCount == 1;
          } else {
            return pieceCount == 0;
          }
        }

        if (posY == pos.y) {
          // col
          int start = posX > pos.x ? pos.x : posX;
          int end = posX < pos.x ? pos.x : posX;

          int pieceCount = 0;

          for (int i = start+1 ; i < end; i++) {
            if (checkCollisionOnBoard(listPieces, Position(x: i, y: posY))){
              pieceCount++;
            }
          }

          if (checkCollisionOnBoard(listPieces, pos)) {
            if (checkCollisionOnBoardWithSameFlag(listPieces, pos))
              return false;
            return pieceCount == 1;
          } else {
            return pieceCount == 0;
          }
        }

        return false;
      }
    }).toList();
  }
}
