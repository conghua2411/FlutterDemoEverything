import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import 'AlbumModel.dart';
import 'ImageModel.dart';

class ChallengeGallery extends StatefulWidget {
  @override
  State createState() => ChallengeGalleryState();
}

class ChallengeGalleryState extends State<ChallengeGallery> {
  List<Uint8List> imageListThumb = [];

  StreamController<List<Uint8List>> imageThumbStream;

  List<AlbumModel> listAlbum = [];

  StreamController<List<AlbumModel>> listAlbumStream;

  List<AssetPathEntity> listAssetPathEntity = [];

  int currentPage = 0;

  int currentImageSelect = -1;

  List<ImageModel> listImage = [];

  @override
  void initState() {
    super.initState();

    imageThumbStream = StreamController();

    listAlbumStream = StreamController();

    PhotoManager.requestPermission().then((hasPermission) async {
      if (hasPermission) {
        // success
        print('PhotoManager.requestPermission has permission');

        try {
          listAssetPathEntity = await PhotoManager.getImageAsset();

          _getListImage(currentPage);
        } catch (e) {
          print('Setup PhotoManager error - $e');
        }
      } else {
        // fail
        print('PhotoManager.requestPermission has not permission');
      }
    }, onError: (e) {
      print('PhotoManager.requestPermission error');
    });
  }

  @override
  void dispose() {
    imageThumbStream.close();

    listAlbumStream.close();

    super.dispose();
  }

  _getListImage(int page, {int limit = 9}) async {
    if (listAssetPathEntity != null || listAssetPathEntity.isNotEmpty) {
      List<AssetEntity> listAsset =
          await listAssetPathEntity[0].getAssetListPaged(page, limit);

      for (int i = 0; i < listAsset.length; i++) {
        Uint8List thumb = await listAsset[i].thumbDataWithSize(120, 120);
        listImage.add(ImageModel(imageEntity: listAsset[i], thumb: thumb));

        imageListThumb.add(thumb);

        if (i == listAsset.length - 1) {
          imageThumbStream.add(imageListThumb);
        }
      }
    }
  }

  _loadMore() {
    currentPage++;
    _getListImage(currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            onPressed: currentImageSelect != -1
                ? () {
                    Navigator.of(context)
                        .pop(listImage[currentImageSelect].thumb);
                  }
                : null,
            child: Text(
              'OK',
              style: TextStyle(
                color: currentImageSelect != -1 ? Colors.black : Colors.grey,
                fontWeight: currentImageSelect != -1
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: StreamBuilder<List<Uint8List>>(
          initialData: [],
          stream: imageThumbStream.stream,
          builder: (context, snapshot) {
            print('ChallengeGallery: grid build - ${snapshot.data.length}');
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                if (index == snapshot.data.length - 1) {
                  print('load more $index');
                  _loadMore();
                }

                return InkWell(
                  onTap: () {
                    setState(() {
                      currentImageSelect = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 4,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Image.memory(
                            snapshot.data[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Opacity(
                          opacity: index == currentImageSelect ? 1 : 0,
                          child: Container(
                            color: Color.fromRGBO(0, 0, 0, 0.6),
                            child: Center(
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: snapshot.data.length,
            );
          },
        ),
      ),
    );
  }
}
