import 'dart:typed_data';
import 'dart:ui' as UI;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

class CustomPainterImage extends StatefulWidget {
  @override
  State createState() => CustomPainterImageState();
}

class CustomPainterImageState extends State<CustomPainterImage> {
  UI.Image image;

  @override
  void initState() {
    super.initState();

    rootBundle.load('assets/ic_loading.png').then((byteData) {
      img.Image image = img.decodeImage(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

      img.Image image2 = img.copyResize(image, width: 100, height: 100);

      UI.decodeImageFromPixels(
          image2.getBytes(), 100, 100, UI.PixelFormat.rgba8888, (imageResize) {
        setState(() {
          this.image = imageResize;
        });
      });

//      UI.decodeImageFromList(
//          image2.getBytes(format: img.Format.rgb), (imageResize) {
//        setState(() {
//          this.image = imageResize;
//        });
//      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom painter image'),
      ),
      body: Center(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.red,
          child: CustomPaint(
            foregroundPainter: PainterImage(image: image),
            child: Container(
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}

class PainterImage extends CustomPainter {
  UI.Image image;

  PainterImage({
    @required this.image,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (image != null) {
      Paint paint = Paint()
        ..color = Colors.amber
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke;

      canvas.drawImage(image, Offset(0, 0), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
