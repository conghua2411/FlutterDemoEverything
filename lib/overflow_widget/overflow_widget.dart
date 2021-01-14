import 'package:flutter/material.dart';

class OverflowWidget extends StatefulWidget {
  @override
  _OverflowWidgetState createState() => _OverflowWidgetState();
}

class _OverflowWidgetState extends State<OverflowWidget> {

  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Overflow detection"),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height/2,
          child: Stack(
            fit: StackFit.expand,
            overflow: Overflow.clip,
            children: [
              Positioned(
                top: 0,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      color: Colors.green[200],
                      child: Text('first widget'),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 350,
                      color: Colors.yellow[200],
                      child: Text('overflowed widget'),
                    ),
                  ],
                ),
              ),
              Positioned(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Text("SHOW THIS TEXT ONLY IF CONTENT HAS OVERFLOWED."),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
