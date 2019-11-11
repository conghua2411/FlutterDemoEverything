import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageModel {
  AssetEntity imageEntity;
  Uint8List thumb;

  ImageModel({
    @required this.imageEntity,
    @required this.thumb,
  });
}
