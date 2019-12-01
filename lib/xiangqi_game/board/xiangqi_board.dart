import 'package:flutter/material.dart';
import 'package:flutter_app/xiangqi_game/piece/general.dart';
import 'package:flutter_app/xiangqi_game/piece/phao.dart';
import 'package:flutter_app/xiangqi_game/piece/tot.dart';
import 'package:flutter_app/xiangqi_game/piece/voi.dart';
import 'package:flutter_app/xiangqi_game/piece/flag.dart';
import 'package:flutter_app/xiangqi_game/piece/ma.dart';
import 'package:flutter_app/xiangqi_game/piece/piece.dart';
import 'package:flutter_app/xiangqi_game/piece/si.dart';
import 'package:flutter_app/xiangqi_game/piece/xe.dart';
import 'package:flutter_app/xiangqi_game/pos/position.dart';
import 'package:rxdart/rxdart.dart';

import 'board_item.dart';
import 'board_paint_path.dart';

class XiangqiBoard extends StatefulWidget {
  final double width;

  XiangqiBoard({
    @required this.width,
  });

  @override
  State createState() => XiangqiBoardState();
}

class XiangqiBoardState extends State<XiangqiBoard> {
  List<List<BoardItem>> listXiangqiPlaces;

  List<Piece> listPieceBlack;
  List<Piece> listPieceRed;

  List<Piece> listPieces;

  Piece currentPiece;

  BehaviorSubject<Piece> streamCurrentPiece = BehaviorSubject();

  BehaviorSubject<List<Position>> streamListPosCanMove = BehaviorSubject();

  BehaviorSubject<List<Piece>> streamListPiece = BehaviorSubject();

  Flag gameTurn = Flag.BLACK;

  BehaviorSubject<Flag> streamGameTurn = BehaviorSubject();

  @override
  void dispose() {
    streamCurrentPiece.close();
    streamListPosCanMove.close();
    streamListPiece.close();
    streamGameTurn.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    initBoard();
  }

  void initBoard() {
    listXiangqiPlaces = [];

    addLine1();
    addLine2();
    addLine3();
    addLine4();
    addLine5();
    addLine6();
    addLine7();
    addLine8();
    addLine9();
    addLine10();

    initBlack();
    initRed();

    listPieces = [];

    listPieces.addAll(listPieceBlack);
    listPieces.addAll(listPieceRed);

    streamListPiece.add(listPieces);

    streamListPosCanMove.add([]);

    gameTurn = Flag.BLACK;
    streamGameTurn.add(gameTurn);

    currentPiece = null;
  }

  void onPosCanMoveCallback(List<Position> posCanMove, Piece piece) {
    if (gameTurn == piece.flag) {
      if (currentPiece != null && currentPiece == piece) {
        currentPiece = null;
        streamCurrentPiece.add(currentPiece);
        streamListPosCanMove.add([]);
      } else {
        currentPiece = piece;
        streamCurrentPiece.add(currentPiece);
        streamListPosCanMove.add(piece.checkPosOnBoardCanMove(listPieces));
      }
    } else {
      _showDialogNotYourTurn(gameTurn);
    }
  }

  _showDialogNotYourTurn(Flag turn) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Not your turn'),
            content: Text('It is $turn turn'),
          );
        });
  }

  initBlack() {
    listPieceBlack = [];
    listPieceBlack.add(Xe(widget.width / 9, widget.width / 9, 0, 0, Flag.BLACK,
        onPosCanMoveCallback));
    listPieceBlack.add(Ma(widget.width / 9, widget.width / 9, 1, 0, Flag.BLACK,
        onPosCanMoveCallback));
    listPieceBlack.add(Voi(widget.width / 9, widget.width / 9, 2, 0, Flag.BLACK,
        onPosCanMoveCallback));
    listPieceBlack.add(Si(widget.width / 9, widget.width / 9, 3, 0, Flag.BLACK,
        onPosCanMoveCallback));
    listPieceBlack.add(General(widget.width / 9, widget.width / 9, 4, 0,
        Flag.BLACK, onPosCanMoveCallback));
    listPieceBlack.add(Si(widget.width / 9, widget.width / 9, 5, 0, Flag.BLACK,
        onPosCanMoveCallback));
    listPieceBlack.add(Voi(widget.width / 9, widget.width / 9, 6, 0, Flag.BLACK,
        onPosCanMoveCallback));
    listPieceBlack.add(Ma(widget.width / 9, widget.width / 9, 7, 0, Flag.BLACK,
        onPosCanMoveCallback));
    listPieceBlack.add(Xe(widget.width / 9, widget.width / 9, 8, 0, Flag.BLACK,
        onPosCanMoveCallback));
    listPieceBlack.add(Phao(widget.width / 9, widget.width / 9, 1, 2,
        Flag.BLACK, onPosCanMoveCallback));
    listPieceBlack.add(Phao(widget.width / 9, widget.width / 9, 7, 2,
        Flag.BLACK, onPosCanMoveCallback));
    listPieceBlack.add(Tot(widget.width / 9, widget.width / 9, 0, 3, Flag.BLACK,
        onPosCanMoveCallback));
    listPieceBlack.add(Tot(widget.width / 9, widget.width / 9, 2, 3, Flag.BLACK,
        onPosCanMoveCallback));
    listPieceBlack.add(Tot(widget.width / 9, widget.width / 9, 4, 3, Flag.BLACK,
        onPosCanMoveCallback));
    listPieceBlack.add(Tot(widget.width / 9, widget.width / 9, 6, 3, Flag.BLACK,
        onPosCanMoveCallback));
    listPieceBlack.add(Tot(widget.width / 9, widget.width / 9, 8, 3, Flag.BLACK,
        onPosCanMoveCallback));
  }

  initRed() {
    listPieceRed = [];
    listPieceRed.add(Xe(widget.width / 9, widget.width / 9, 0, 9, Flag.RED,
        onPosCanMoveCallback));
    listPieceRed.add(Ma(widget.width / 9, widget.width / 9, 1, 9, Flag.RED,
        onPosCanMoveCallback));
    listPieceRed.add(Voi(widget.width / 9, widget.width / 9, 2, 9, Flag.RED,
        onPosCanMoveCallback));
    listPieceRed.add(Si(widget.width / 9, widget.width / 9, 3, 9, Flag.RED,
        onPosCanMoveCallback));
    listPieceRed.add(General(widget.width / 9, widget.width / 9, 4, 9, Flag.RED,
        onPosCanMoveCallback));
    listPieceRed.add(Si(widget.width / 9, widget.width / 9, 5, 9, Flag.RED,
        onPosCanMoveCallback));
    listPieceRed.add(Voi(widget.width / 9, widget.width / 9, 6, 9, Flag.RED,
        onPosCanMoveCallback));
    listPieceRed.add(Ma(widget.width / 9, widget.width / 9, 7, 9, Flag.RED,
        onPosCanMoveCallback));
    listPieceRed.add(Xe(widget.width / 9, widget.width / 9, 8, 9, Flag.RED,
        onPosCanMoveCallback));
    listPieceRed.add(Phao(widget.width / 9, widget.width / 9, 1, 7, Flag.RED,
        onPosCanMoveCallback));
    listPieceRed.add(Phao(widget.width / 9, widget.width / 9, 7, 7, Flag.RED,
        onPosCanMoveCallback));
    listPieceRed.add(Tot(widget.width / 9, widget.width / 9, 0, 6, Flag.RED,
        onPosCanMoveCallback));
    listPieceRed.add(Tot(widget.width / 9, widget.width / 9, 2, 6, Flag.RED,
        onPosCanMoveCallback));
    listPieceRed.add(Tot(widget.width / 9, widget.width / 9, 4, 6, Flag.RED,
        onPosCanMoveCallback));
    listPieceRed.add(Tot(widget.width / 9, widget.width / 9, 6, 6, Flag.RED,
        onPosCanMoveCallback));
    listPieceRed.add(Tot(widget.width / 9, widget.width / 9, 8, 6, Flag.RED,
        onPosCanMoveCallback));
  }

  addLine1() {
    List<BoardItem> listXiangqi = [];
    // line 1
    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.BOTTOM_RIGHT,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM_LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
      ],
    ));

    listXiangqiPlaces.add(listXiangqi);
  }

  addLine2() {
    List<BoardItem> listXiangqi = [];
    // line 1
    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
        BoardPaintPath.TOP_LEFT,
        BoardPaintPath.TOP_RIGHT,
        BoardPaintPath.BOTTOM_LEFT,
        BoardPaintPath.BOTTOM_RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
      ],
    ));

    listXiangqiPlaces.add(listXiangqi);
  }

  addLine3() {
    List<BoardItem> listXiangqi = [];
    // line 1
    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.TOP_RIGHT,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.TOP_LEFT,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
      ],
    ));

    listXiangqiPlaces.add(listXiangqi);
  }

  addLine4() {
    List<BoardItem> listXiangqi = [];
    // line 1
    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
      ],
    ));

    listXiangqiPlaces.add(listXiangqi);
  }

  addLine5() {
    List<BoardItem> listXiangqi = [];
    // line 1
    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
      ],
    ));

    listXiangqiPlaces.add(listXiangqi);
  }

  addLine6() {
    List<BoardItem> listXiangqi = [];
    // line 1
    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.BOTTOM,
        BoardPaintPath.LEFT,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.BOTTOM,
        BoardPaintPath.LEFT,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.BOTTOM,
        BoardPaintPath.LEFT,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.BOTTOM,
        BoardPaintPath.LEFT,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.BOTTOM,
        BoardPaintPath.LEFT,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.BOTTOM,
        BoardPaintPath.LEFT,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
      ],
    ));

    listXiangqiPlaces.add(listXiangqi);
  }

  addLine7() {
    List<BoardItem> listXiangqi = [];
    // line 1
    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
      ],
    ));

    listXiangqiPlaces.add(listXiangqi);
  }

  addLine8() {
    List<BoardItem> listXiangqi = [];
    // line 1
    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
        BoardPaintPath.BOTTOM_RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
        BoardPaintPath.BOTTOM_LEFT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
      ],
    ));

    listXiangqiPlaces.add(listXiangqi);
  }

  addLine9() {
    List<BoardItem> listXiangqi = [];
    // line 1
    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
        BoardPaintPath.TOP_LEFT,
        BoardPaintPath.TOP_RIGHT,
        BoardPaintPath.BOTTOM_LEFT,
        BoardPaintPath.BOTTOM_RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.BOTTOM,
      ],
    ));

    listXiangqiPlaces.add(listXiangqi);
  }

  addLine10() {
    List<BoardItem> listXiangqi = [];
    // line 1
    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.RIGHT,
        BoardPaintPath.TOP_RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.RIGHT,
        BoardPaintPath.TOP_LEFT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
        BoardPaintPath.RIGHT,
      ],
    ));

    listXiangqi.add(BoardItem(
      width: widget.width / 9,
      height: widget.width / 9,
      listDirDraw: [
        BoardPaintPath.TOP,
        BoardPaintPath.LEFT,
      ],
    ));

    listXiangqiPlaces.add(listXiangqi);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: _buildPlayerTop(),
        ),
        Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 10 / 9,
              color: Color.fromRGBO(15, 189, 186, 1),
              child: Column(
                children: List.generate(
                  listXiangqiPlaces.length,
                  (iCol) {
                    return Row(
                      children: List.generate(
                        listXiangqiPlaces[iCol].length,
                        (iRow) {
                          return listXiangqiPlaces[iCol][iRow];
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            StreamBuilder<List<Piece>>(
                initialData: [],
                stream: streamListPiece,
                builder: (context, snapshot) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 10 / 9,
                    child: Column(
                      children: List.generate(
                        10,
                        (iCol) {
                          return Row(
                            children: List.generate(
                              9,
                              (iRow) {
                                Piece piece =
                                    checkPos(iRow, iCol, snapshot.data);
                                if (piece != null) {
                                  return piece.build();
                                } else {
                                  return Container(
                                    width: widget.width / 9,
                                    height: widget.width / 9,
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
            StreamBuilder<List<Position>>(
                initialData: [],
                stream: streamListPosCanMove,
                builder: (context, snapshot) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 10 / 9,
                    child: Column(
                      children: List.generate(
                        listXiangqiPlaces.length,
                        (iCol) {
                          return Row(
                            children: List.generate(
                              listXiangqiPlaces[iCol].length,
                              (iRow) {
                                if (checkPosCanMove(
                                    iRow, iCol, snapshot.data)) {
                                  return InkWell(
                                    onTap: () {
                                      gameTurn =
                                          Flag.values[(gameTurn.index + 1) % 2];

                                      streamGameTurn.add(gameTurn);

                                      // remove piece current Piece and target piece if has collision
                                      listPieces = listPieces.where((piece) {
                                        if ((piece.posX == iRow &&
                                                piece.posY == iCol) ||
                                            (piece.posX == currentPiece.posX &&
                                                piece.posY ==
                                                    currentPiece.posY)) {
                                          return false;
                                        } else {
                                          return true;
                                        }
                                      }).toList();

                                      listPieces
                                          .add(currentPiece.setPos(iRow, iCol));

                                      currentPiece = null;

                                      _checkGameWinLose(listPieces);

                                      streamListPiece.add(listPieces);

                                      streamListPosCanMove.add([]);
                                    },
                                    child: Container(
                                      width: widget.width / 9,
                                      height: widget.width / 9,
                                      child: Center(
                                        child: StreamBuilder<Piece>(
                                            initialData: null,
                                            stream: streamCurrentPiece,
                                            builder: (context, snapshot) {
                                              return Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  color: snapshot.data == null
                                                      ? Colors.transparent
                                                      : snapshot.data.flag ==
                                                              Flag.BLACK
                                                          ? Colors.black
                                                          : Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    width: widget.width / 9,
                                    height: widget.width / 9,
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
          ],
        ),
        Expanded(
          child: _buildPlayerBottom(),
        ),
      ],
    );
  }

  _buildPlayerTop() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.blue,
          child: Text(
            'Reset',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            _resetBoard();
          },
        ),
        Container(
          color: Colors.black,
          child: StreamBuilder<Flag>(
            initialData: Flag.BLACK,
            stream: streamGameTurn,
            builder: (context, snapshot) {
              return Opacity(
                opacity: snapshot.data == Flag.BLACK ? 1 : 0,
                child: Center(
                  child: Text(
                    'Your turn',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  _buildPlayerBottom() {
    return Container(
      color: Colors.red,
      child: StreamBuilder<Flag>(
        initialData: Flag.BLACK,
        stream: streamGameTurn,
        builder: (context, snapshot) {
          return Opacity(
            opacity: snapshot.data == Flag.BLACK ? 0 : 1,
            child: Center(
              child: Text(
                'Your turn',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Piece checkPos(int posX, int posY, List<Piece> lPiece) {
    for (Piece piece in lPiece) {
      if (piece.posX == posX && piece.posY == posY) {
        return piece;
      }
    }

    return null;
  }

  bool checkPosCanMove(int posX, int posY, List<Position> listPos) {
    for (Position pos in listPos) {
      if (pos.x == posX && pos.y == posY) {
        return true;
      }
    }
    return false;
  }

  void _checkGameWinLose(List<Piece> listPieces) {
    List<Piece> list = listPieces.where((piece) {
      return piece is General;
    }).toList();

    if (list.length == 1) {
      // game over
      showDialogWin(list[0].flag);
    }
  }

  void showDialogWin(Flag flag) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Text('$flag WIN'),
          actions: <Widget>[
            FlatButton(
              child: Text('Reset'),
              onPressed: () {
                Navigator.of(context).pop();
                _resetBoard();
              },
            ),
          ],
        );
      },
    );
  }

  void _resetBoard() {
    initBoard();
  }
}
