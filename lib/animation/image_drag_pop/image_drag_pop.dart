import 'package:flutter/material.dart';

import 'image_drag_detail.dart';

class ImageDragPop extends StatefulWidget {
  @override
  State createState() => ImageDragPopState();
}

class ImageDragPopState extends State<ImageDragPop> {
  List<String> imageList;

  @override
  void initState() {
    super.initState();

    imageList = List();

    imageList.add(
        'https://cdnb.artstation.com/p/assets/images/images/020/070/571/large/alena-aenami-comet-c.jpg?1566266122');
    imageList.add(
        'https://cdnb.artstation.com/p/assets/images/images/019/037/631/large/alena-aenami-1.jpg?1561730395');
    imageList.add(
        'https://cdnb.artstation.com/p/assets/images/images/018/779/611/large/alena-aenami-away-1k.jpg?1560704311');
    imageList.add(
        'https://cdna.artstation.com/p/assets/images/images/018/357/216/large/alena-aenami-horizon-1k.jpg?1559071156');
    imageList.add(
        'https://cdnb.artstation.com/p/assets/images/images/016/297/033/large/alena-aenami-you-1k-2.jpg?1551647925');
    imageList.add(
        'https://cdnb.artstation.com/p/assets/images/images/014/327/751/large/alena-aenami-endless-1k.jpg?1543505168');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ImageDragDetail(
                        heroImageTag: imageList[index],
                        imageUrl: imageList[index],
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: imageList[index],
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(imageList[index]),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: imageList.length,
        ),
      ),
    );
  }
}
