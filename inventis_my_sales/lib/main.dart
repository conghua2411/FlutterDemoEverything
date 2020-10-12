import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class InventisMySale extends StatefulWidget {
  @override
  _InventisMySaleState createState() => _InventisMySaleState();
}

class _InventisMySaleState extends State<InventisMySale> {
  BehaviorSubject<bool> _bsInitWidget = BehaviorSubject();

  Future<bool> initTime() {
    return Future.delayed(Duration(seconds: 1), () {
      return true;
    });
  }

  @override
  void initState() {
    super.initState();
    initTime().then((value) {
      _bsInitWidget.add(value);
    });
  }

  @override
  void dispose() {
    _bsInitWidget.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'My Sales',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<bool>(
                initialData: false,
                stream: _bsInitWidget,
                builder: (context, snapshot) {
                  if (snapshot.data) {
                    return Container(
                      color: Colors.amberAccent,
                    );
                  } else {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
