import 'package:flutter/material.dart';

class DeepLinkNativeDemo extends StatefulWidget {
  final String url;

  DeepLinkNativeDemo({this.url});

  @override
  State createState() => DeepLinkNativeState();
}

class DeepLinkNativeState extends State<DeepLinkNativeDemo> {

  String data = '';

  @override
  void initState() {
    super.initState();

    Uri uri = Uri.parse(widget.url);

    print('${uri.queryParameters}');

    data = uri.queryParameters.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DeepLinkNativeDemo'),
      ),
      body: Center(
        child: Text(
          '$data',
        ),
      ),
    );
  }
}
