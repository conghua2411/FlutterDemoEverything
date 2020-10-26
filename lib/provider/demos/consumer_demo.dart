import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsumerDemo extends StatefulWidget {
  @override
  _ConsumerDemoState createState() => _ConsumerDemoState();
}

class _ConsumerDemoState extends State<ConsumerDemo> {
  Counter counter = Counter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Consumer Demo',
        ),
      ),
      body: ChangeNotifierProvider<Counter>.value(
        value: counter,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<Counter>(
                builder: (context, value, child) {
                  return _buildCounter(value);
                },
                child: Container(),
              ),
              Consumer<Counter>(
                builder: (context, value, child) {
                  return _buildCounter2(value);
                },
                child: Container(),
              ),
            ],
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

  Widget _buildCounter(Counter counter) {
    return Text('${counter.count}');
  }
  Widget _buildCounter2(Counter counter) {
    return Text('${counter.count * 2}');
  }
}

class Counter with ChangeNotifier{
  int count;

  Counter({
    this.count = 0,
  });

  void increase() {
    count++;
    notifyListeners();
  }
}
