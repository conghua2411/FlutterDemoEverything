import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'show_image.dart';

class CameraSistemDemo extends StatefulWidget {
  @override
  State createState() => CameraSistemState();
}

class CameraSistemState extends State<CameraSistemDemo> {
  List<CameraDescription> cameras;
  CameraController controller;

  @override
  void initState() {
    super.initState();

    initCamera();
  }

  void initCamera() {
    availableCameras().then((list) {
      cameras = list;
      controller = CameraController(cameras[0], ResolutionPreset.ultraHigh);

      controller.initialize().then((_) {
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 400,
              child: controller != null && controller.value.isInitialized
                  ? CameraPreview(controller)
                  : Container(),
            ),
            Container(
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.photo_camera),
                  onPressed: () {
                    takePicture().then(
                      (filePath) {
                        if (filePath != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  ShowImage(
                                    filePath,
                                  ),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String> takePicture() async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/test_image3.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      print('CameraException: $e');
      return null;
    }
    return filePath;
  }
}
