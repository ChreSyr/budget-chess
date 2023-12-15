import 'dart:ui';

class BoardSize extends Size {
  const BoardSize(super.width, super.height);

  // String get display => '${width.toInt()} x ${height.toInt()}';

  @override
  String toString() => '${width.toInt()} x ${height.toInt()}';
}
