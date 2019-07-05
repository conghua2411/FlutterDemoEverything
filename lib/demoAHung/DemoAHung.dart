import 'package:flutter/material.dart';

class DemoAHung extends StatefulWidget {
  @override
  State createState() => DemoAHungState();
}

class DemoAHungState extends State<DemoAHung> with TickerProviderStateMixin {
  List<double> itemHeight = List();

  List<Animation> animations = List();

  List<AnimationController> animationControllers = List();

  List<bool> itemState = List();

  @override
  void initState() {
    super.initState();
    itemHeight.add(0);
    itemHeight.add(0);
    itemHeight.add(0);
    itemHeight.add(0);
    itemHeight.add(0);

    itemState.add(false);
    itemState.add(false);
    itemState.add(false);
    itemState.add(false);
    itemState.add(false);

    animationControllers.add(AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this));
    animationControllers.add(AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this));
    animationControllers.add(AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this));
    animationControllers.add(AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this));
    animationControllers.add(AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this));

    animations
        .add(Tween<double>(begin: 0, end: 200).animate(animationControllers[0])
          ..addListener(() {
            setState(() {});
          }));
    animations
        .add(Tween<double>(begin: 0, end: 200).animate(animationControllers[1])
          ..addListener(() {
            setState(() {});
          }));
    animations
        .add(Tween<double>(begin: 0, end: 200).animate(animationControllers[2])
          ..addListener(() {
            setState(() {});
          }));
    animations
        .add(Tween<double>(begin: 0, end: 200).animate(animationControllers[3])
          ..addListener(() {
            setState(() {});
          }));
    animations
        .add(Tween<double>(begin: 0, end: 200).animate(animationControllers[4])
          ..addListener(() {
            setState(() {});
          }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('aloooo'),
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  if (itemState[index]) {
                    animationControllers[index].reverse();
                  } else {
                    animationControllers[index].forward();
                  }
                  itemState[index] = !itemState[index];
                },
                child: Container(
                  color: Colors.primaries[index % 5],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text('item : $index'),
                        AnimatedContainer(
                          duration: Duration(seconds: 1),
                          child: Container(
                            height: animations[index].value,
                            child: PageView(
                              children: <Widget>[
                                Container(
                                  color: Colors.white,
                                  child: Center(
                                    child: Text('player'),
                                  ),
                                ),
                                Container(
                                  color: Colors.red,
                                  child: ListView.builder(
                                      itemCount: 10,
                                      itemBuilder:
                                          (BuildContext context, int index2) {
                                        return Padding(
                                          padding: EdgeInsets.all(20.0),
                                          child: Text('item : $index2'),
                                        );
                                          }),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
