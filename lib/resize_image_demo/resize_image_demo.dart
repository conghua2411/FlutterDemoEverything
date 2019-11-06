import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as IMG;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ResizeImageDemo extends StatefulWidget {
  @override
  State createState() => ResizeImageState();
}

class ResizeImageState extends State<ResizeImageDemo> {
  File imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ResizeImageDemo'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
              child: Text('gallery'),
              onPressed: _pickImageGallery,
            ),
            imageFile != null ? Image.file(imageFile) : Container(),
          ],
        ),
      ),
    );
  }

  void _pickImageGallery() {
    ImagePicker.pickImage(source: ImageSource.gallery).then((file) {
      if (file != null) {
        print('_pickImageGallery: ${file.path}');

        IMG.Image image = IMG.decodeImage(file.readAsBytesSync());

        IMG.Image thumbnail = IMG.copyResize(image, width: 120, height: 120);

        print('_pickImageGallery: ${thumbnail.length}');

        String newPath = calculateNewPath(file.path);

        File newFile = File(newPath)
          ..writeAsBytesSync(IMG.encodePng(thumbnail));

        IMG.Image newImage = IMG.decodeImage(newFile.readAsBytesSync());

        setState(() {
          imageFile = newFile;
        });
      } else {
        print('_pickImageGallery: file is null');
      }
    }, onError: (e) {
      print('_pickImageGallery: $e');
    });
  }

  calculateNewPath(String path) {
    String imageType = path.substring(path.lastIndexOf('.'));

    String newName = path.substring(0, path.lastIndexOf('.'));

    newName += '_resize';

    return newName + imageType;
  }
}
