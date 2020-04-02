import 'dart:async';

import 'package:flutter/material.dart';

class ReOrderListDemo extends StatefulWidget {
  @override
  State createState() => ReOrderListState();
}

class ReOrderListState extends State<ReOrderListDemo> {
  StreamController<List<String>> _streamListOrder;

  List<String> _listOrder;

  @override
  void initState() {
    super.initState();
    _streamListOrder = StreamController();

    _listOrder = List.generate(50, (index) {
      return 'index: $index';
    });

    _streamListOrder.add(_listOrder);
  }

  @override
  void dispose() {
    _streamListOrder.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ReOrderListDemo')),
      body: Container(
        child: StreamBuilder<List<String>>(
          initialData: [],
          stream: _streamListOrder.stream,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ReorderableListView(
                children: snapshot.data.map(
                  (data) {
                    return _buildItem(data);
                  },
                ).toList(),
                onReorder: (oldIndex, newIndex) {
                  print('oldIndex: $oldIndex ---- newIndex: $newIndex');

                  if (oldIndex > newIndex) {
                    /// move up
                    String moveItem = _listOrder.removeAt(oldIndex);

                    _listOrder.insert(newIndex, moveItem);

                    _streamListOrder.add(_listOrder);
                  } else if (oldIndex < newIndex) {
                    /// move down
                    String moveItem = _listOrder.removeAt(oldIndex);

                    _listOrder.insert(newIndex-1, moveItem);

                    _streamListOrder.add(_listOrder);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildItem(String data) {
    return Padding(
      key: ValueKey(data),
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Text(
            data,
            style: TextStyle(
              color: Colors.amber,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        height: 50,
      ),
    );
  }
}
