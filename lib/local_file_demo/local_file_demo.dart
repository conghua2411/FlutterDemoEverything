import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class LocalFileDemo extends StatefulWidget {
  @override
  State createState() => LocalFileState();
}

class LocalFileState extends State<LocalFileDemo> {
  StreamController<String> imageUrlStream = StreamController();
  StreamController<String> usernameStream = StreamController();
  StreamController<String> descriptionStream = StreamController();

  _readFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      final file = File('${directory.path}/my_file.txt');

      print('_readFile path: ${file.path}');

      String text = await file.readAsString();
      print('_readFile Success : $text');
    } catch (e) {
      print('_readFile Error: $e');
    }
  }

  _writeFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      final file = File('${directory.path}/my_file.txt');

      final text = 'Hello TXT';

      await file.writeAsString(text);
      print('_writeFile success');
    } catch (e) {
      print('_writeFile error: $e');
    }
  }

  _readFileJSON() async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      final file = File('${directory.path}/profile_local.json');

      print('_readFile path: ${file.path}');

      String strData = await file.readAsString();

      Map<String, dynamic> mapData = jsonDecode(strData);

      imageUrlStream.add(mapData['imageUrl']);

      usernameStream.add(mapData['name']);

      descriptionStream.add(mapData['description']);

      print('_readFile Success');
    } catch (e) {
      print('_readFile Error: $e');
    }
  }

  _writeFileJSON() async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      final file = File('${directory.path}/profile_local.json');

      final mapData = {
        'name': 'aloha1234',
        'description': 'this is description',
        'imageUrl':
            'https://cdnb.artstation.com/p/assets/images/images/021/041/441/large/ruiz-burgos-joker-2019-ig.jpg?1570145026'
      };

      final text = jsonEncode(mapData);

      await file.writeAsString(text);
      print('_writeFile success');
    } catch (e) {
      print('_writeFile error: $e');
    }
  }

  @override
  void dispose() {
    imageUrlStream.close();
    usernameStream.close();
    descriptionStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LocalFileDemo'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
              child: Text('Read File'),
              onPressed: _readFileJSON,
            ),
            FlatButton(
              child: Text('Write File'),
              onPressed: _writeFileJSON,
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<String>(
              initialData: '',
              stream: usernameStream.stream,
              builder: (context, snapshot) {
                return Text(
                  snapshot.data,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            StreamBuilder<String>(
              initialData: '',
              stream: descriptionStream.stream,
              builder: (context, snapshot) {
                return Text(
                  snapshot.data,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                );
              },
            ),
            StreamBuilder<String>(
              initialData: null,
              stream: imageUrlStream.stream,
              builder: (context, snapshot) {
                if (snapshot.data == null || snapshot.data.isEmpty) {
                  return Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.error,
                        size: 40,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey,
                      image: DecorationImage(
                        image: NetworkImage(snapshot.data),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
