import 'package:flutter/material.dart';

import 'board/xiangqi_board.dart';

class XiangqiGame extends StatefulWidget {

  @override
  State createState() => XiangqiGameState();
}

class XiangqiGameState extends State<XiangqiGame> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: XiangqiBoard(width: MediaQuery.of(context).size.width,),
        ),
      ),
    );
  }
}
