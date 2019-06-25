import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:io';

class SocketDemo extends StatefulWidget {
  @override
  State createState() => SocketDemoState();
}

class SocketDemoState extends State<SocketDemo> {
  TextEditingController _controller = TextEditingController();

  String textSend = "";

  // socket
  Socket socket;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      textSend = _controller.text;
    });

    Socket.connect("127.0.0.1", 12345).then((Socket sock) {
      socket = sock;
      socket.listen(dataHandler,
          onError: errorHandler,
          onDone: doneHandler,
          cancelOnError: false);
    }).catchError((Object e) {
      print("Unable to connect: $e");
    });

//    socket.listen((data) => socket.write(new String.fromCharCode(data).trim() + '\n'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(hintText: 'input here'),
                ),
              ),
              RaisedButton(
                child: Text('send'),
                onPressed: () => sendDataToSocket(),
              )
            ],
          ),
        ),
      ),
    );
  }

  sendDataToSocket() {}

  void dataHandler(data){
    print(new String.fromCharCodes(data).trim());
  }

  void errorHandler(error, StackTrace trace){
    print(error);
  }

  void doneHandler(){
    socket.destroy();
  }
}
