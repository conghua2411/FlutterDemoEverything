import 'package:flutter/material.dart';

class BottomBarDemo extends StatefulWidget {
  @override
  State createState() => BottomBarState();
}

class BottomBarState extends State<BottomBarDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BottomBarDemo'),
      ),
      body: Center(
        child: Text('BottomBarDemo'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.amber,
        items: [
          BottomNavigationBarItem(
            title: Container(),
            icon: Icon(
              Icons.add,
            ),
          ),
          BottomNavigationBarItem(
            title: Container(),
            icon: Icon(
              Icons.play_arrow,
            ),
          ),
//          BottomNavigationBarItem(
//            title: Container(),
//            icon: Icon(
//              Icons.settings,
//            ),
//          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.close),
        ),
        onPressed: () {
          print('alo');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('alo1234'),
                content: Text('asdlo1234'),
              );
            },
          );
        },
      ),
    );
  }
}
