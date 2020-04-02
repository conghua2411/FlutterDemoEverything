import 'dart:math';

import 'package:flutter/material.dart';

class SistemScheduleView extends StatefulWidget {
  @override
  _SistemScheduleState createState() => _SistemScheduleState();
}

class _SistemScheduleState extends State<SistemScheduleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: PageView.builder(
            itemBuilder: (context, index) {
              print('index: $index');
              return Container(
                color: Colors.primaries[index%10],
              );
            },
//            itemCount: 10,
          ),
        ),
      ),
    );
  }
}
