import 'package:flutter/cupertino.dart';

class Event {
  DateTime time;
  String title;
  Color color;

  Event({
    this.time,
    this.title,
    this.color,
  });

  @override
  String toString() {
    return '$title';
  }
}
