import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StreamProviderDemo extends StatefulWidget {
  @override
  _StreamProviderDemoState createState() => _StreamProviderDemoState();
}

class _StreamProviderDemoState extends State<StreamProviderDemo> {
  Stream<String> streamCounter(int n) async* {
    for (int i = 1; i <= n; i++) {
      await Future.delayed(
        Duration(seconds: 1),
      );
      yield 'n' * i;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'StreamProviderDemo',
        ),
      ),
      body: Center(
        child: StreamProvider(
          create: (context) => streamCounter(10),
          lazy: false,
          child: CounterScreen(),
        ),
      ),
    );
  }
}

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '${context.watch<String>()}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
      ),
    );
  }
}

class Counter extends ChangeNotifier {
  int count;

  Counter({
    this.count = 0,
  });

  void increase() {
    count++;
    notifyListeners();
  }
}
