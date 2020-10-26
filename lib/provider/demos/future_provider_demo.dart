import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class FutureProviderDemo extends StatefulWidget {
  @override
  _FutureProviderDemoState createState() => _FutureProviderDemoState();
}

class _FutureProviderDemoState extends State<FutureProviderDemo> {
  Future<String> getListTodo() {
    return Future.delayed(Duration(seconds: 2), () {
      return http
          .get('https://jsonplaceholder.typicode.com/todos')
          .then((response) {
        if (response.statusCode / 100 == 2) {
          return response.body;
        } else {
          return 'Error: ${response.statusCode}';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FutureProviderDemo'),
      ),
      body: SafeArea(
        child: FutureProvider(
          lazy: false,
          create: (_) async {
            return getListTodo();
          },
          child: _Demo(),
        ),
      ),
    );
  }
}

class _Demo extends StatefulWidget {
  @override
  __DemoState createState() => __DemoState();
}

class __DemoState extends State<_Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Text(
            '${context.watch<String>()}',
          ),
        ),
      ),
    );
  }
}
