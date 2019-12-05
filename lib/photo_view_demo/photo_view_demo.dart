import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewDemo extends StatefulWidget {
  @override
  State createState() => PhotoViewState();
}

class PhotoViewState extends State<PhotoViewDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: PhotoView(
          enableRotation: true,
          backgroundDecoration: BoxDecoration(
            color: Colors.amber,
          ),
          minScale: PhotoViewComputedScale.contained,
          maxScale: 5.0,
          imageProvider: NetworkImage(
            'https://cdnb.artstation.com/p/assets/images/images/021/993/595/large/gilles-beloeil-fh-ev-q02-premiere-vue-closeup-gbeloeil.jpg?1573703769',
          ),
        ),
      ),
    );
  }
}
