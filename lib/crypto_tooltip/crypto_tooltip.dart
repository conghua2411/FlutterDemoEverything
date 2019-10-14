import 'package:flutter/material.dart';

class CryptoTooltipDemo extends StatefulWidget {

  @override
  State createState() => CryptoTooltipDemoState();
}

class CryptoTooltipDemoState extends State<CryptoTooltipDemo> {

  GlobalKey imageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CryptoTooltipDemo'),
      ),
      body: Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'asdas asdasd asdas d asd ad asd asd asd a sddas das skjd asd ',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                ),
              ),
              WidgetSpan(
                child: GestureDetector(
                    onTap: _onTap,
                    child: Image.asset('assets/ic_loading.png', width: 24, height: 24, key: imageKey,)),
              ),
              TextSpan(
                text: ' asdqwe asd qe qwe qw',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }

  void _onTap() {
    final RenderBox renderBoxRed = imageKey.currentContext.findRenderObject();

    final positionRed = renderBoxRed.localToGlobal(Offset.zero);
    print("POSITION of Red: $positionRed ");

    final size = renderBoxRed.size;

    showDialog(context: context, builder: (context) {
      return Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: positionRed.dx,
                  top: positionRed.dy,
                  child: TooltipContent(size),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class TooltipContent extends StatefulWidget {

  final Size size;

  TooltipContent(this.size);

  @override
  State createState() => TooltipContentState();
}

class TooltipContentState extends State<TooltipContent> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      height: widget.size.height,
      color: Colors.blue,
    );
  }
}