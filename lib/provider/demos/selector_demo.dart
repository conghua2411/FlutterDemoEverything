import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectorDemo extends StatefulWidget {
  @override
  _SelectorDemoState createState() => _SelectorDemoState();
}

class _SelectorDemoState extends State<SelectorDemo> {

  Counter counter = Counter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SelectorDemo',
        ),
      ),
      body: Scaffold(
        body: ChangeNotifierProvider.value(
          value: counter,
          child: Center(
            child: _buildCounter(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          counter.increase();
        },
      ),
    );
  }

  Widget _buildCounter() {
    return Selector<Counter, String>(
      builder: (context, value, child) {
        return Text(value);
      },
      selector: (ctx, n) {
        if (n.count % 2 == 0) {
          return 'HELLO';
        } else {
          return n.count.toString();
        }
      },
    );
  }
}

class Counter with ChangeNotifier {
  int count;

  Counter({this.count = 0});

  void increase() {
    count++;
    notifyListeners();
  }
}
