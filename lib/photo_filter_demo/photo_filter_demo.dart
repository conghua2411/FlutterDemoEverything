import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:image/image.dart' as imageLib;
import 'package:photofilters/photofilters.dart';
import 'package:path/path.dart';

class PhotoFilterDemo extends StatefulWidget {
  @override
  State createState() => PhotoFilterState();
}

class PhotoFilterState extends State<PhotoFilterDemo> {
  imageLib.Image _image;
  String fileName;

  BehaviorSubject<imageLib.Image> _bsImageFilter;

  List<Filter> filters = presetFiltersList;

  @override
  void initState() {
    super.initState();
    _bsImageFilter = BehaviorSubject();
  }

  @override
  void dispose() {
    _bsImageFilter.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PhotoFilterDemo'),
      ),
      body: Center(
        child: StreamBuilder<imageLib.Image>(
            initialData: null,
            stream: _bsImageFilter,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return PhotoFilterSelector(
                  title: Container(),
                  image: snapshot.data,
                  filename: fileName,
                  filters: presetFiltersList,
                  loader: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Text('alo 1234');
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.camera_enhance,
        ),
        onPressed: () {
          ImagePicker.pickImage(source: ImageSource.gallery).then((file) {
            if (file != null) {
              print('file path: ${file.path}');
              fileName = basename(file.path);
              imageLib.Image image =
                  imageLib.decodeImage(file.readAsBytesSync());
//              image = imageLib.copyCrop(
//                image,
//                image.width ~/ 4,
//                image.height ~/ 4,
//                image.width ~/ 2,
//                image.height ~/ 2,
//              );

              image = imageLib.copyResize(
                image,
                width: image.width ~/ 2,
                height: image.height ~/ 2,
              );

              _image = image;
              _bsImageFilter.add(image);
            }
          });
        },
      ),
    );
  }
}
