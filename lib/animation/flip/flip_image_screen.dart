import 'package:flutter/material.dart';

class FlipImageScreen extends StatefulWidget {
  @override
  State createState() => FlipImageState();
}

class FlipImageState extends State<FlipImageScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;

  Animation<double> _frontScale;
  Animation<double> _backScale;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(duration: Duration(milliseconds: 750), vsync: this);

    _frontScale = new Tween(begin: 1.0, end: 0.0).animate(new CurvedAnimation(
        parent: animationController,
        curve: new Interval(0.0, 0.5, curve: Curves.easeIn)))
    ..addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });

    _backScale = new CurvedAnimation(
        parent: animationController,
        curve: new Interval(0.5, 1.0, curve: Curves.easeOut))
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      }
    });

//    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: new AppBar(
//        title: Text('flip'),
//      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.flip_to_back),
        onPressed: () {
          setState(() {
            if (animationController.isCompleted || animationController.velocity > 0)
              animationController.reverse();
            else
              animationController.forward();
          });
        },
      ),
      body: Center(
        child: RotationTransition(
          turns: AlwaysStoppedAnimation(15 / 360),
          child: new Stack(
            children: <Widget>[
              new AnimatedBuilder(
                child: new MyCustomCard(colors: Colors.orange),
                animation: _backScale,
                builder: (BuildContext context, Widget child) {
                  final Matrix4 transform = new Matrix4.identity()
                    ..scale(-_backScale.value, 1.0, 1.0);
                  return new Transform(
                    transform: transform,
                    alignment: FractionalOffset.center,
                    child: child,
                  );
                },
              ),
              new AnimatedBuilder(
                child: new MyCustomCard(colors: Colors.blue),
                animation: _frontScale,
                builder: (BuildContext context, Widget child) {
                  final Matrix4 transform = new Matrix4.identity()
                    ..scale(_frontScale.value, 1.0, 1.0);
                  return new Transform(
                    transform: transform,
                    alignment: FractionalOffset.center,
                    child: child,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCustomCard extends StatelessWidget {
  MyCustomCard({this.colors});

  final MaterialColor colors;

  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      height: 75.0,
      width: 75.0,
//      child: Image.asset('assets/line_test.jpg'),
      child: Image.asset('assets/ic_loading_stand.png'),
    );
  }
}
