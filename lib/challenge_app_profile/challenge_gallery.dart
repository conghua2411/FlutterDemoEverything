import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import 'AlbumModel.dart';

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

  _getListImage(int page, {int limit = 24}) async {
    if (listAssetPathEntity != null || listAssetPathEntity.isNotEmpty) {
      List<AssetEntity> listAsset =
          await listAssetPathEntity[0].getAssetListPaged(page, limit);
      listAsset.forEach((image) async {
        imageListThumb.add(await image.thumbData);
        imageThumbStream.add(imageListThumb);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              print('it is ok load more');
              currentPage++;
              _getListImage(currentPage);
            },
            child: Text(
              'OK',
            ),
          ),
        ],
      ),
      body: Container(
        child: StreamBuilder<List<Uint8List>>(
          initialData: [],
          stream: imageThumbStream.stream,
          builder: (context, snapshot) {
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 4,
                  ),
                  child: Image.memory(
                    snapshot.data[index],
                    fit: BoxFit.cover,
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
