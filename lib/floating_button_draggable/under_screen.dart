import 'package:flutter/material.dart';

class UnderScreenDemo extends StatefulWidget {
  @override
  State createState() => UnderScreenDemoState();
}

class UnderScreenDemoState extends State<UnderScreenDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
//      body: Center(
//        child: FlatButton(
//            onPressed: () {
//              Navigator.of(context)
//                  .push(MaterialPageRoute(builder: (_) => UnderScreenDemo()));
//            },
//            child: Text('nextScreen')),
//      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              children: List.generate(
                20,
                (index) {
                  return FlatButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => UnderScreenDemo()));
                    },
                    child: Text('nextScreen'),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
