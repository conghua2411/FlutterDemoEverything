import 'package:flutter/material.dart';

class ColumnDemo extends StatefulWidget {
  @override
  State createState() => ColumnDemoState();
}

class ColumnDemoState extends State<ColumnDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Column Demo'),
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return _itemBuild(index);
          }),
    );
  }

  Widget _itemBuild(index) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  '$index: asdasdasdasd 1231 23123 12312',
                  maxLines: 1,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Icon(Icons.star)
          ],
        ),
      ),
    );
  }
}
