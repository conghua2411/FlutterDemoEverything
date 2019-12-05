import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as IMG;

class ImageCropCircleDemo extends StatefulWidget {
  @override
  State createState() => ImageCropCircleState();
}

class ImageCropCircleState extends State<ImageCropCircleDemo> {
  File fileImage;

  IMG.Image image;

  int imageWidth;
  int imageheight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ImageCropCircleDemo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_album),
            onPressed: () {
              ImagePicker.pickImage(source: ImageSource.gallery).then((file) {
                if (file != null) {
                  print('ImagePicker: ${file.path}');
                  setState(() {
                    fileImage = file;

                    image = IMG.decodeImage(file.readAsBytesSync());

                    print('image --- width: ${image.width} === height: ${image.height}');

                    imageWidth = image.width;
                    imageheight = image.height;
                  });
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.crop),
            onPressed: () {

              IMG.Image croppedImage;

              croppedImage = IMG.copyCrop(image, 0, (imageheight-imageWidth)~/2, imageWidth, imageWidth);

              String newPath = calculateNewPath(fileImage.path);

              File newFile = File(newPath)
                ..writeAsBytesSync(IMG.encodePng(croppedImage));

              setState(() {
                fileImage = newFile;
              });
            },
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.red,
        child: fileImage != null ? Image.file(fileImage, fit: BoxFit.fitWidth,) : Container(),
      ),
    );
  }

  calculateNewPath(String path) {
    String imageType = path.substring(path.lastIndexOf('.'));

    String newName = path.substring(0, path.lastIndexOf('.'));

    newName += '_resize';

    return newName + imageType;
  }
}
