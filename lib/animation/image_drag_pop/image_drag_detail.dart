import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:math';

class ImageDragDetail extends StatefulWidget {
  final String imageUrl;
  final String heroImageTag;

  ImageDragDetail({
    @required this.heroImageTag,
    @required this.imageUrl,
  });

  @override
  State createState() => ImageDragDetailState();
}

class ImageDragDetailState extends State<ImageDragDetail>
    with SingleTickerProviderStateMixin {
  Offset startDragOffset;

  BehaviorSubject<Offset> currentDragOffsetStream;

  // animation back
  AnimationController backAnimationController;
  Animation<Offset> backAnimation;

  @override
  void initState() {
    super.initState();
    currentDragOffsetStream = BehaviorSubject();

    backAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            currentDragOffsetStream?.add(backAnimation.value);
          });
  }

  @override
  void dispose() {
    currentDragOffsetStream.close();
    backAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Hero(
            tag: widget.heroImageTag,
            child: GestureDetector(
              onPanStart: (detail) {
                print(
                    'onPanStart: ${detail.localPosition} --- ${detail.globalPosition}');

                startDragOffset = detail.globalPosition;
              },
              onPanUpdate: (update) {
                print(
                    'onPanUpdate: ${update.delta} --- ${update.localPosition} --- ${update.globalPosition} -- ${update.primaryDelta} --- ${update.sourceTimeStamp}');
                currentDragOffsetStream.add(Offset(
                    update.globalPosition.dx - startDragOffset.dx,
                    update.globalPosition.dy - startDragOffset.dy));
              },
              onPanCancel: () {
                print('onPanCancel');
              },
              onPanDown: (detail) {
                print(
                    'onPanDown: ${detail.localPosition} --- ${detail.globalPosition}');
              },
              onPanEnd: (detail) {
                print(
                    'onPanEnd: ${detail.velocity} --- ${detail.primaryVelocity}');

                if (detail.velocity.pixelsPerSecond.dx.abs() +
                        detail.velocity.pixelsPerSecond.dy.abs() >
                    200) {
                  Navigator.of(context).pop();
                } else {
                  backAnimation = Tween<Offset>(
                          begin: currentDragOffsetStream.value,
                          end: Offset(0, 0))
                      .animate(
                    CurvedAnimation(
                      parent: backAnimationController,
                      curve: Curves.easeOutExpo,
                    ),
                  );
                  backAnimationController.forward(from: 0);
                }
              },
              child: StreamBuilder<Offset>(
                initialData: Offset(0, 0),
                stream: currentDragOffsetStream,
                builder: (context, snapshot) {
                  print('new Offset : ${snapshot.data}');
                  return Transform.translate(
                    offset: calculateTranslate(snapshot.data),
//                    offset: Offset(0, 0),
                    child: Transform.rotate(
                      angle: calculateAngle(snapshot.data),
//                      angle: 0,
//                      origin: startDragOffset,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.network(widget.imageUrl),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Offset calculateTranslate(Offset newOffset) {
    print(
        'angle : ${(newOffset.dy / MediaQuery.of(context).size.height) * 360}');
    print(
        'tan : ${tan((newOffset.dy / MediaQuery.of(context).size.height) * 360)}');
    print('tan123 : ${tan(newOffset.dy / MediaQuery.of(context).size.height)}');

    double tan123 = tan(newOffset.dy / MediaQuery.of(context).size.height);

//    Offset currentOffset = Offset(
//        newOffset.dx + startDragOffset.dx, newOffset.dy - startDragOffset.dy);
//
//    print(' 213 1231 23: ${newOffset.dx - newOffset.dy*tan123}');

//    return Offset(newOffset.dx - newOffset.dx*tan123, newOffset.dy);

    return newOffset;
  }

  double calculateAngle(Offset newOffset) {
    if (startDragOffset != null) {
      Offset currentOffset = Offset(
          newOffset.dx + startDragOffset.dx, newOffset.dy + startDragOffset.dy);

      print('------------------- start dx: ${startDragOffset.dx}');
      print('------------------- newOffset dx: ${newOffset.dx}');
      print('------------------- current dx: ${currentOffset.dx}');

      print(
          '------------------- width screen: ${MediaQuery.of(context).size.width}');

      print('------------------- start dy: ${startDragOffset.dy}');
      print('------------------- newOffset dy: ${newOffset.dy}');
      print('------------------- current dy: ${currentOffset.dy}');

      print(
          '------------------- height screen: ${MediaQuery.of(context).size.height}');

      print('------------------------------------------------------');

      print('alo1234 ${currentOffset.dy - startDragOffset.dy}');
      print(
          '--------- ${-newOffset.dy / MediaQuery.of(context).size.height} :::::: ${-newOffset.dx / MediaQuery.of(context).size.height} --------');

      print(
          '--------- ${(currentOffset.dx - MediaQuery.of(context).size.width / 2) / MediaQuery.of(context).size.width / 2} :::::: ${(currentOffset.dy - MediaQuery.of(context).size.height / 2) / MediaQuery.of(context).size.height / 2} --------');

//      return (newOffset.dy / MediaQuery.of(context).size.height) * (pi / 3);
      return ((currentOffset.dx - MediaQuery.of(context).size.width / 2) /
              MediaQuery.of(context).size.width /
              2) *
          ((currentOffset.dy - MediaQuery.of(context).size.height / 2) /
              MediaQuery.of(context).size.height /
              2) *
          pi;

//      if (currentOffset.dx < MediaQuery.of(context).size.width / 2) {
//        return newOffset.dy / MediaQuery.of(context).size.height;
//      } else {
//        return -newOffset.dy / MediaQuery.of(context).size.height;
//      }
    } else {
      return 0;
    }
  }
}
