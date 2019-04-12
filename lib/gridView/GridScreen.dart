import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;


class GridScreen extends StatefulWidget {
  @override
  State createState() => GridState();
}

class GridState extends State<GridScreen> {
  List<String> urls;
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('grid view'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    onChanged: (text) {
                      searchText = text;
                    },
                  ),
                ),
                RaisedButton(
                  child: Text('search'),
                  onPressed: () => _searchImage(searchText),
                )
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(4, (index) {
                return Center(
                  child: Image.network(
                    'https://picsum.photos/250?image=$index',
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Future _searchImage(String searchText) async {
    // search image

    // https://www.google.com/search?tbm=isch&q=findSomeImage

    String url = 'https://www.google.com/search?tbm=isch&q=$searchText';
//
    http.Response response = await http.get(url);
//
//    print(response.toString());

    var document = parser.parse(response.body);

    print(document.outerHtml);
  }
}
