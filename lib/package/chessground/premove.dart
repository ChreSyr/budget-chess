import 'package:crea_chess/package/chessground/models.dart';
import 'package:crea_chess/package/unichess/unichess.dart';

/// Returns the set of squares that the piece on [squareId] can potentially
/// premove to.
Set<SquareId> premovesOf({
  required SquareId squareId,
  required BoardSize boardSize,
  required Pieces pieces,
  bool canCastle = false,
}) {
  final piece = pieces[squareId];
  if (piece == null) return {};
  final coord = Coord.fromSquareId(squareId, boardSize: boardSize);
  final r = piece.role;

  final mobility = (() {
    switch (r) {
      case Role.pawn:
        return _pawn(piece.color);
      case Role.knight:
        return _knight;
      case Role.bishop:
        return _bishop;
      case Role.rook:
        return _rook;
      case Role.queen:
        return _queen;
      case Role.king:
        return _king(
          piece.color,
          _rookFilesOf(pieces, piece.color, boardSize),
          canCastle,
          boardSize,
        );
    }
  })();

  return Set.unmodifiable({
    for (final coord2 in Coord.allCoords(boardSize))
      if ((coord.x != coord2.x || coord.y != coord2.y) &&
          mobility(coord.x, coord.y, coord2.x, coord2.y))
        coord2.squareId,
  });
}

typedef _Mobility = bool Function(int x1, int y1, int x2, int y2);

int _diff(int a, int b) {
  return (a - b).abs();
}

_Mobility _pawn(Side color) {
  return (int x1, int y1, int x2, int y2) =>
      _diff(x1, x2) < 2 &&
      (color == Side.white
          ? y2 == y1 + 1 || (y1 <= 1 && y2 == y1 + 2 && x1 == x2)
          : y2 == y1 - 1 || (y1 >= 6 && y2 == y1 - 2 && x1 == x2));
}

bool _knight(int x1, int y1, int x2, int y2) {
  final xd = _diff(x1, x2);
  final yd = _diff(y1, y2);
  return (xd == 1 && yd == 2) || (xd == 2 && yd == 1);
}

bool _bishop(int x1, int y1, int x2, int y2) {
  return _diff(x1, x2) == _diff(y1, y2);
}

bool _rook(int x1, int y1, int x2, int y2) {
  return x1 == x2 || y1 == y2;
}

bool _queen(int x1, int y1, int x2, int y2) {
  return _bishop(x1, y1, x2, y2) || _rook(x1, y1, x2, y2);
}

/// Premovable squares of the king :
///   - all squares around it
///   - rooks if can castle
///   - castle destinations if can castle
_Mobility _king(
  Side color,
  List<int> rookFiles,
  bool canCastle,
  BoardSize boardSize,
) {
  return (int x1, int y1, int x2, int y2) =>
      (_diff(x1, x2) < 2 && _diff(y1, y2) < 2) ||
      (canCastle &&
          y1 == y2 &&
          y1 == (color == Side.white ? 0 : (boardSize.ranks - 1)) &&
          (x2 == 2 || x2 == (boardSize.files - 2) || rookFiles.contains(x2)));
}

List<int> _rookFilesOf(Pieces pieces, Side color, BoardSize boardSize) {
  final backrank = color == Side.white ? '1' : boardSize.rankIds.last;
  final files = <int>[];
  for (final entry in pieces.entries) {
    if (entry.key[1] == backrank &&
        entry.value.color == color &&
        entry.value.role == Role.rook) {
      files.add(Coord.fromSquareId(entry.key, boardSize: boardSize).x);
    }
  }
  return files;
}
