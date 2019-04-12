import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import 'package:image/image.dart' as imglib;
import 'package:flutter/services.dart';

enum Lang { vi, en, ko, jp }

class TestOcr extends StatefulWidget {
  @override
  State createState() {
    return TestOcrState();
  }
}

class TestOcrState extends State<TestOcr> {

  static const platform = const MethodChannel("com.example.flutter_app/main");

  CameraController _camera;

  dynamic _scanResult;

  Lang _currentLang = Lang.vi;
  bool _isDetecting = false;
  CameraLensDirection _direction = CameraLensDirection.back;

  int _imageCount = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    super.dispose();
    _camera.dispose();
  }

  void _initializeCamera() async {
    CameraDescription description = await getCamera(_direction);

    _camera = CameraController(
      description,
      ResolutionPreset.medium,
    );

    await _camera.initialize();

    _camera.startImageStream((CameraImage image) {
      
      print("image preview");
      if (_isDetecting) return;

      _isDetecting = true;

      detect(image, description.sensorOrientation).then(
        (dynamic result) {
          setState(() {

            _imageCount++;
            _scanResult = result;
          });

          _isDetecting = false;
        },
      ).catchError(
        (_) {
          _isDetecting = false;
        },
      );
    });
  }

  Future<CameraDescription> getCamera(CameraLensDirection direction) async {
    return availableCameras().then(
      (List<CameraDescription> cameras) => cameras.firstWhere(
            (CameraDescription camera) => camera.lensDirection == direction,
          ),
    );
  }

  Future<dynamic> detect(CameraImage image, int sensorOrientation) async {

//    Future<imglib.Image> imageDetect = convertYUV420toImageColor(image);
    String result;

    try {
//      result = await platform.invokeMethod("sayHello");

      result = await platform.invokeMethod("sayHello2", {"imageCount":_imageCount});

      print("native result : $result, image count : $_imageCount");
    } on PlatformException catch (e) {
      print("native error : ${e.message}");
    }
    // detect image
    return result;
  }

  Future<imglib.Image> convertYUV420toImageColor(CameraImage image) async {
    try {
      final int width = image.width;
      final int height = image.height;
      final int uvRowStride = image.planes[1].bytesPerRow;
      final int uvPixelStride = image.planes[1].bytesPerPixel;

      print("uvRowStride: " + uvRowStride.toString());
      print("uvPixelStride: " + uvPixelStride.toString());

      // imgLib -> Image package from https://pub.dartlang.org/packages/image
      var img = imglib.Image(width, height); // Create Image buffer

      // Fill image buffer with plane[0] from YUV420_888
      for(int x=0; x < width; x++) {
        for(int y=0; y < height; y++) {
          final int uvIndex = uvPixelStride * (x/2).floor() + uvRowStride*(y/2).floor();
          final int index = y * width + x;

          final yp = image.planes[0].bytes[index];
          final up = image.planes[1].bytes[uvIndex];
          final vp = image.planes[2].bytes[uvIndex];
          // Calculate pixel color
          int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
          int g = (yp - up * 46549 / 131072 + 44 -vp * 93604 / 131072 + 91).round().clamp(0, 255);
          int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
          // color: 0x FF  FF  FF  FF
          //           A   B   G   R
          img.data[index] = (0xFF << 24) | (b << 16) | (g << 8) | r;
        }
      }

      imglib.PngEncoder pngEncoder = new imglib.PngEncoder(level: 0, filter: 0);
      List<int> png = pngEncoder.encodeImage(img);
//      muteYUVProcessing = false;
      print("get image : $_imageCount");
      return imglib.Image.fromBytes(width, height, png);
//      return imglib.Image.memory(png);
    } catch (e) {
      print(">>>>>>>>>>>> ERROR:" + e.toString());
    }
    return null;
  }

  Widget _buildResult() {

    const Text noResultText = const Text('No result!');
    Text hasResultText = Text("image count : $_imageCount");

    if (_scanResult == null ||
    _camera == null ||
    !_camera.value.isInitialized) {
      return noResultText;
    } else {
      return hasResultText;
    }
  }

  Widget _buildImage() {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: _camera == null
          ? const Center(
              child: Text(
                'Initialize Camera...',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30.0,
                ),
              ),
            )
          : Stack(
              fit: StackFit.expand,
              children: <Widget>[
                CameraPreview(_camera),
                _buildResult(),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("testOcr"),
        actions: <Widget>[
          PopupMenuButton<Lang>(
            onSelected: (Lang result) {
              _currentLang = result;
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Lang>>[
                  const PopupMenuItem<Lang>(
                    child: Text("viet nam"),
                    value: Lang.vi,
                  ),
                  const PopupMenuItem<Lang>(
                    child: Text("england"),
                    value: Lang.en,
                  ),
                  const PopupMenuItem<Lang>(
                    child: Text("korean"),
                    value: Lang.ko,
                  ),
                  const PopupMenuItem<Lang>(
                    child: Text("japanese"),
                    value: Lang.jp,
                  ),
                ],
          ),
        ],
      ),
      body: _buildImage(),
    );
  }
}
