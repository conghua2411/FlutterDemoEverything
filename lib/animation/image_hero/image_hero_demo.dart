import 'package:flutter/material.dart';

import 'image_hero_detail.dart';

class ImageHeroDemo extends StatefulWidget {
  @override
  State createState() => ImageHeroState();
}

class ImageHeroState extends State<ImageHeroDemo> {
  List images = List();

  @override
  void initState() {
    super.initState();

    images.add(
        'https://cdnb.artstation.com/p/assets/images/images/021/041/441/large/ruiz-burgos-joker-2019-ig.jpg?1570145026');
    images.add(
        'https://cdnb.artstation.com/p/assets/images/images/018/301/033/large/armando-savoia-16-4-2a.jpg?1558882088');
    images.add(
        'https://cdnb.artstation.com/p/assets/images/images/018/724/051/large/bo-chen-dark-cosmic-jhin-final-splash-1920.jpg?1560454527');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(
          color: Colors.black,
        ),
        title: Hero(
            tag: 'heroTest-9',
            child: Material(
              color: Colors.transparent,
              child: Text(
                'ImageHeroDemo',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            )),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 100, right: 100, top: 8, bottom: 8),
            child: GestureDetector(
              onTap: () {
                print('asdasdasd $index');
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ImageHeroDetail(
                      imageUrl: images[index],
                      heroTag: 'imageHeroTag$index',
                    ),
                  ),
                );
              },
              child: Hero(
                tag: 'imageHeroTag$index',
                child: Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red,
                    image: DecorationImage(
                      image: NetworkImage(images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: images.length,
      ),
    );
  }
}
