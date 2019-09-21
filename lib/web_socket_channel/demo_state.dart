import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class DemoStateScreen extends StatefulWidget {
  @override
  State createState() => DomeState();
}

class DomeState extends State<DemoStateScreen> {
  BehaviorSubject<String> _behaviorSubject = BehaviorSubject.seeded('alo');

  @override
  void initState() {
    super.initState();

    _behaviorSubject.stream.where((e) {
      print('e = 1');
      return e == '1';
    }).listen((_) {
      print('do something when e = 1');
    });

    _behaviorSubject.stream.where((e) {
      print('e = 2');
      return e == '2';
    }).listen((_) {
      print('do something when e = 2');
    });
  }

  @override
  void dispose() {
    _behaviorSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild asdasdasd');
    return Scaffold(
      appBar: AppBar(
        title: Text('demo bobo'),
      ),
      body: Center(
        child: StreamBuilder(
          initialData: '',
          stream: _behaviorSubject.stream,
          builder: (context, snapshot) {
            return Text(snapshot.data);
          },
        ),
      ),
      floatingActionButton: FlatButton(
          onPressed: () {
            _behaviorSubject.add('1');
          },
          child: Icon(Icons.add)),
    );
  }
}
