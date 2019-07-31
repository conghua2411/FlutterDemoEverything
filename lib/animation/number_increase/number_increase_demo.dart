import 'package:flutter/material.dart';

class NumberIncreaseScreen extends StatefulWidget {
  @override
  State createState() => NumberIncreaseState();
}

class NumberIncreaseState extends State<NumberIncreaseScreen>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  CurvedAnimation _curvedAnimation;
  Animation<int> _animation;

  String number = '0';

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeOutCirc);

    _animation = IntTween(begin: 0, end: 1000).animate(_curvedAnimation)
      ..addListener(() {
        print('value : ${_animation.value} -- time: ${DateTime.now()}');
        setState(() {
          number = _animation.value.toString();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NumberIncreaseScreen'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(number),
                  FlatButton(
                    color: Colors.blue,
                    child: Text('animation'),
                    onPressed: () {
                      if (_animation.status == AnimationStatus.completed) {
                        _animationController.reverse();
                      } else {
                        _animationController.forward();
                      }
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
