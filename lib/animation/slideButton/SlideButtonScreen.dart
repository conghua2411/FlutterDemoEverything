import 'package:flutter/material.dart';
import 'package:flutter_amazon_s3/flutter_amazon_s3.dart';

class SlideButtonScreen extends StatefulWidget {
  @override
  State createState() => SlideButtonState();
}

class SlideButtonState extends State<SlideButtonScreen>
    with TickerProviderStateMixin {
  double btnSize = 200;
  double btnSize2 = 250;
  double btnSize3 = 300;
  double btnSize4 = 350;
  Color color = Colors.amber[500];

  double positionRight = 0;

  AnimationController animationController;
  Animation<double> animation;

  AnimationController animationController2;
  Animation<double> animation2;

  AnimationController animationController3;
  Animation<double> animation3;

  AnimationController animationController4;
  Animation<double> animation4;

  bool animationState = true;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(duration: Duration(milliseconds: 1000), vsync: this);

    animation =
        Tween<double>(begin: -btnSize, end: 0).animate(animationController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              // start a new one
              animationController2.forward();
            } else if (status == AnimationStatus.dismissed) {
              animationController2.reverse();
            }
          });

    animationController2 =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);

    animation2 =
        Tween<double>(begin: -btnSize2, end: 0).animate(animationController2)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              // start a new one
              animationController3.forward();
            } else if (status == AnimationStatus.dismissed) {
              animationController3.reverse();
            }
          });

    animationController3 =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);

    animation3 =
        Tween<double>(begin: -btnSize3, end: 0).animate(animationController3)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              // start a new one
              animationController4.forward();
            } else if (status == AnimationStatus.dismissed) {
              animationController4.reverse();
            }
          });

    animationController4 =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);

    animation4 =
        Tween<double>(begin: -btnSize4, end: 0).animate(animationController4)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              // start a new one
              animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              animationController.forward();
            }
          });
  }

  @override
  void dispose() {

    animationController.dispose();
    animationController2.dispose();
    animationController3.dispose();
    animationController4.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(
      children: <Widget>[
        Positioned(
          top: 100,
          right: 200,
          child: FlatButton(
              color: Colors.lightBlueAccent[100],
              onPressed: () => showAnimation(),
              child: Text('animation')),
        ),
        Positioned(
          top: 200,
          right: animation.value,
          child: Center(
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              width: btnSize,
              color: color,
              curve: Curves.bounceIn,
              child: SizedBox(
                child: FlatButton(
                    onPressed: () => showToast(context, "hello"),
                    child: Text('hello')),
              ),
            ),
          ),
        ),
        Positioned(
          top: 300,
          width: btnSize2,
          right: animation2.value,
          child: FlatButton(
              color: Colors.lightBlueAccent[100],
              onPressed: () => showAnimation(),
              child: Text('animation')),
        ),
        Positioned(
          top: 400,
          width: btnSize3,
          right: animation3.value,
          child: FlatButton(
              color: Colors.lightBlueAccent[100],
              onPressed: () => showAnimation(),
              child: Text('animation')),
        ),
        Positioned(
          top: 500,
          width: btnSize4,
          right: animation4.value,
          child: FlatButton(
              color: Colors.lightBlueAccent[100],
              onPressed: () => showAnimation(),
              child: Text('animation')),
        ),
      ],
    )));
  }

  showToast(BuildContext context, String msg) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(SnackBar(content: Text(msg)));
  }

  showAnimation() async {

    String path = '/data/user/0/can.app.cryptobadge/cache/image_picker4874775931364902453.jpg';

    String uploadedImageUrl = await FlutterAmazonS3.uploadImage(
        path, 'crypto-badge-static-m1', 'ap-southeast-1:31a7fecb-a07e-4ce3-90da-6931779e72a4', 'ap-southeast-1');

    print("_uploadImageToAWS uploadedImageUrl ::" + uploadedImageUrl);

    setState(() {
//      btnSize = btnSize == 100 ? 200 : 100;
      color =
          color == Colors.amber[500] ? Colors.amber[100] : Colors.amber[500];
      if (animationState) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
      animationState = !animationState;
    });
  }
}
