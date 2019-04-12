import 'package:meta/meta.dart';

class Point {
  int x, y;

  Point({@required this.x, @required this.y});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  static Point copy(Point other) {
    return Point(x: other.x, y: other.y);
  }
}
