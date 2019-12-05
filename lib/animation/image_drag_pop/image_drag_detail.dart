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

  BehaviorSubject<Offset> bsOffsetRotate;

  Size imageSize;

  GlobalKey _keyImage = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBoxImage =
          _keyImage.currentContext.findRenderObject();
      imageSize = renderBoxImage.size;
    });

    super.initState();
    currentDragOffsetStream = BehaviorSubject();

    backAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            currentDragOffsetStream?.add(backAnimation.value);
          });

    bsOffsetRotate = BehaviorSubject();
  }

  @override
  void dispose() {
    currentDragOffsetStream.close();
    backAnimationController.dispose();
    bsOffsetRotate.close();
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
                bsOffsetRotate.add(detail.localPosition);
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

//                  for (int i = 0 ; i < 10 ; i++) {
//                    currentDragOffsetStream.add(Offset(
//                        detail.velocity.pixelsPerSecond.dx*i/10,
//                        detail.velocity.pixelsPerSecond.dy*i/10));
//                  }

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
                  bsOffsetRotate.add(null);
                }
              },
              child: StreamBuilder<Offset>(
                initialData: Offset(0, 0),
                stream: currentDragOffsetStream,
                builder: (context, snapshot) {
                  print('new Offset : ${snapshot.data}');
                  return Transform.translate(
                    offset: calculateTranslate(snapshot.data),
                    child: StreamBuilder<Offset>(
                        initialData: null,
                        stream: bsOffsetRotate,
                        builder: (context, snapshotRotate) {
                          return Transform.rotate(
                            alignment: snapshotRotate.data == null ||
                                    imageSize == null
                                ? Alignment.center
                                : Alignment(
                                    (snapshotRotate.data.dx / imageSize.width) *
                                            2 -
                                        1,
                                    (snapshotRotate.data.dy /
                                                imageSize.height) *
                                            2 -
                                        1),
                            angle: calculateAngle(snapshot.data),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.network(
                                widget.imageUrl,
                                key: _keyImage,
                              ),
                            ),
                          );
                        }),
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

      print(
          'angle: ${((currentOffset.dx - MediaQuery.of(context).size.width / 2) / (MediaQuery.of(context).size.width / 2)) * ((currentOffset.dy - MediaQuery.of(context).size.height / 2) / (MediaQuery.of(context).size.height / 2))}');

//      return ((currentOffset.dx - MediaQuery.of(context).size.width / 2) /
//              MediaQuery.of(context).size.width /
//              2) *
//          ((currentOffset.dy - MediaQuery.of(context).size.height / 2) /
//              MediaQuery.of(context).size.height /
//              2) *
//          pi;

//      if (currentOffset.dx < MediaQuery.of(context).size.width / 2) {
//        return newOffset.dy / MediaQuery.of(context).size.height;
//      } else {
//        return -newOffset.dy / MediaQuery.of(context).size.height;
//      }

//      return (newOffset.dx/MediaQuery.of(context).size.width * (pi/4));

      if (imageSize == null) {
        print('---------------------------------------------- imageSize ----');
        return 0;
      }

      double angleWidth = (startDragOffset.dy < MediaQuery.of(context).size.height / 2
          ? 1
          : -1) *
          newOffset.dx /
          imageSize.width;

      print('angleWidth: $angleWidth');

      double angleHeight = (startDragOffset.dx < MediaQuery.of(context).size.width / 2
          ? -1
          : 1) *
          newOffset.dy /
          imageSize.height;

      print('angleHeight: $angleHeight');

      return ((angleHeight + angleWidth) *
          (pi / 4));

//      return (newOffset.dy/MediaQuery.of(context).size.height * (pi/4));
//      return (-newOffset.dy/MediaQuery.of(context).size.height * (pi/4));

    } else {
      return 0;
    }
  }
}
