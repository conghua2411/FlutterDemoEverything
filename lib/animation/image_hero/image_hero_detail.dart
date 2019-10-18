import 'package:flutter/material.dart';

class ImageHeroDetail extends StatefulWidget {
  final String imageUrl;
  final String heroTag;

  ImageHeroDetail({
    this.imageUrl,
    this.heroTag,
  });

  @override
  State createState() => ImageHeroDetailState();
}

class ImageHeroDetailState extends State<ImageHeroDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ImageHeroDetail'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Hero(
              tag: widget.heroTag,
              child: Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.red,
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${widget.imageUrl}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
