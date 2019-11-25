import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ListBuilderAnimatedDemo extends StatefulWidget {
  @override
  State createState() => ListBuilderAnimatedState();
}

class ListBuilderAnimatedState extends State<ListBuilderAnimatedDemo> {
  List<String> list = [];

  int count = 0;

  ScrollController listController;

  Random random = Random();

  StreamController<List<String>> listItemStream = StreamController();

  @override
  void initState() {
    super.initState();

    listController = ScrollController();

//    randomAddItem();
  }

  @override
  void dispose() {
    listItemStream.close();
    listController.dispose();
    super.dispose();
  }

  void randomAddItem() {
    int time = random.nextInt(2000);

    print('new random message time: $time');

    Future.delayed(Duration(milliseconds: time), () {
      if (!listItemStream.isClosed) {
        list.add('alo${count++}');

        print('randomAddItem: item: $count');

        listItemStream.add(list);

        WidgetsBinding.instance.addPostFrameCallback((duration) {

          print('addPostFrameCallback: item: $count');

          print('listController: offset - ${listController.offset}\n'
              'position.pixels - ${listController.position.pixels}\n'
              'position.maxScrollExtent - ${listController.position.maxScrollExtent}');

          listController.animateTo(
            listController.position.maxScrollExtent,
            duration: Duration(milliseconds: 200),
            curve: Curves.linear,
          );
        });

        randomAddItem();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            title: Text('ListBuilderAnimatedDemo'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {

                  list.add('alo${count++}');

                  listItemStream.add(list);

                  WidgetsBinding.instance.addPostFrameCallback((duration) {

                    print('alo 1234 duration: $duration');

                    print('listController: offset - ${listController.offset}\n'
                        'position.pixels - ${listController.position.pixels}\n'
                        'position.maxScrollExtent - ${listController.position.maxScrollExtent}');

                    listController.animateTo(
                      listController.position.maxScrollExtent,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.linear,
                    );
                  });
                },
              ),
            ],
          ),
          body: StreamBuilder<List<String>>(
              initialData: [],
              stream: listItemStream.stream,
              builder: (context, snapshot) {
                return ListView.builder(
                  controller: listController,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 200.0,
                      width: double.infinity,
                      color: Colors.amber[((index % 9) + 1) * 100],
                      child: Center(
                        child: Text('${snapshot.data[index]}: $index'),
                      ),
                    );
                  },
                  itemCount: snapshot.data.length,
                );
              }),
        ),
      ),
    );
  }
}
