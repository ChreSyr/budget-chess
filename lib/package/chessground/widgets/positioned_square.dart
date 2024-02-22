import 'package:crea_chess/package/chessground/models.dart';
import 'package:crea_chess/package/dartchess/export.dart';
import 'package:flutter/widgets.dart';

/// BoardWidget aware Positioned widget
///
/// Use to position things, such as [CGPiece], [Highlight] on the board.
/// Since it's a wrapper over a [Positioned] widget it must be a descendant of a
/// [Stack].
class PositionedSquare extends StatelessWidget {
  const PositionedSquare({
    required this.child,
    required this.size,
    required this.orientation,
    required this.coord,
    super.key,
  });

  final Widget child;
  final double size;
  final Side orientation;
  final Coord coord;

  @override
  Widget build(BuildContext context) {
    final offset = coord.offset(orientation, size);
    return Positioned(
      width: size,
      height: size,
      left: offset.dx,
      top: offset.dy,
      child: child,
    );
  }
}
