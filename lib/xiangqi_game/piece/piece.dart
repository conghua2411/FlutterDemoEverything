import 'package:flutter/material.dart';
import 'package:flutter_app/xiangqi_game/pos/position.dart';

import 'flag.dart';

abstract class Piece {
  double width, height;
  int posX, posY;
  Flag flag;

  Function(List<Position> posCanMove, Piece) onPieceClick;

  Piece({
    @required this.width,
    @required this.height,
    @required this.posX,
    @required this.posY,
    @required this.flag,
    @required this.onPieceClick,
  });

  Widget build() {
    return GestureDetector(
      onTap: onTapPiece,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(width),
        ),
        child: Center(
          child: Container(
            width: width - 8,
            height: height - 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width),
              border: Border.all(
                color: flag == Flag.BLACK ? Colors.black : Colors.red,
                width: 2,
              ),
            ),
            child: Center(child: buildPiece()),
          ),
        ),
      ),
    );
  }

  Widget buildPiece();

  void onTapPiece() {
    onPieceClick(getListPosMove(), this);
  }

  List<Position> getListPosMove();

  List<Position> checkPosOnBoardCanMove(List<Piece> listPieces);

  bool checkCollisionOnBoard(List<Piece> listPieces, Position pos) {
    for (Piece piece in listPieces) {
      if (piece.posX == pos.x && piece.posY == pos.y) return true;
    }
    return false;
  }

  bool checkCollisionOnBoardWithSameFlag(List<Piece> listPieces, Position pos) {
    for (Piece piece in listPieces) {
      if (piece.posX == pos.x && piece.posY == pos.y) {
        if (flag == piece.flag) {
          return true;
        } else {
          return false;
        }
      }
    }
    return false;
  }

  @override
  bool operator ==(other) {
    return other is Piece && posX == other.posX && posY == other.posY;
  }

  @override
  int get hashCode {
    return (posX.hashCode) * (posY.hashCode);
  }

  Piece setPos(int x, int y) {
    this.posX = x;
    this.posY = y;
    return this;
  }
}
