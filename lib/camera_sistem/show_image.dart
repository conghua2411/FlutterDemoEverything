import 'dart:io';

import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  final String path;

  ShowImage(this.path);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Image.file(
          File(path),
        ),
      ),
    );
  }
}
