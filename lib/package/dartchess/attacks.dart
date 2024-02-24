import 'package:crea_chess/package/dartchess/models.dart';
import 'package:crea_chess/package/dartchess/size.dart';
import 'package:crea_chess/package/dartchess/square_set.dart';

class Attacks {
  Attacks(
    SquareSetSize size,
  )   : _size = size,
        _antiDiagRange = Attacks._getAntiDiagRange(size),
        _diagRange = Attacks._getDiagRange(size),
        _fileRange = Attacks._getFileRange(size),
        _rankRange = Attacks._getRankRange(size),
        _kingAttacks = Attacks._getKingAttacks(size),
        _knightAttacks = Attacks._getKnightAttacks(size),
        _pawnAttacks = Attacks._getPawnAttacks(size);

  final SquareSetSize _size;
  final List<SquareSet> _antiDiagRange;
  final List<SquareSet> _diagRange;
  final List<SquareSet> _fileRange;
  final List<SquareSet> _rankRange;
  final List<SquareSet> _kingAttacks;
  final List<SquareSet> _knightAttacks;
  final Map<Side, List<SquareSet>> _pawnAttacks;

  static List<SquareSet> _getAntiDiagRange(SquareSetSize size) => _tabulate(
        (sq) {
          // shift is the lower square in the same antidiagonal as sq
          final shift = size.files *
              (size.rankOf(sq) + size.fileOf(sq) - (size.files - 1));
          final antidiagonal = size.antidiagonal;
          return SquareSet(
            shift >= 0 ? antidiagonal << shift : antidiagonal >> -shift,
            size,
          ).withoutSquare(sq);
        },
        size,
      );

  static List<SquareSet> _getDiagRange(SquareSetSize size) => _tabulate(
        (sq) {
          // shift is the lower square in the same diagonal as sq
          final shift = size.files * (size.rankOf(sq) - size.fileOf(sq));
          final diagonal = size.diagonal;
          return SquareSet(
            shift >= 0 ? diagonal << shift : diagonal >> -shift,
            size,
          ).withoutSquare(sq);
        },
        size,
      );

  static List<SquareSet> _getFileRange(SquareSetSize size) => _tabulate(
        (sq) => SquareSet.fromFile(size.fileOf(sq), size).withoutSquare(sq),
        size,
      );

  static List<SquareSet> _getRankRange(SquareSetSize size) => _tabulate(
        (sq) => SquareSet.fromRank(size.rankOf(sq), size).withoutSquare(sq),
        size,
      );

  static List<SquareSet> _getKingAttacks(SquareSetSize size) => _tabulate(
        (sq) => _computeRange(
          sq,
          [
            [-1, -1],
            [-1, 0],
            [-1, 1],
            [0, -1],
            [0, 1],
            [1, -1],
            [1, 0],
            [1, 1],
          ],
          size,
        ),
        size,
      );

  static List<SquareSet> _getKnightAttacks(SquareSetSize size) => _tabulate(
        (sq) => _computeRange(
          sq,
          [
            [-2, -1],
            [-2, 1],
            [-1, -2],
            [-1, 2],
            [1, -2],
            [1, 2],
            [2, -1],
            [2, 1],
          ],
          size,
        ),
        size,
      );

  static Map<Side, List<SquareSet>> _getPawnAttacks(SquareSetSize size) => {
        Side.white: _tabulate(
          (sq) => _computeRange(
            sq,
            [
              [1, -1],
              [1, 1],
            ],
            size,
          ),
          size,
        ),
        Side.black: _tabulate(
          (sq) => _computeRange(
            sq,
            [
              [-1, -1],
              [-1, 1],
            ],
            size,
          ),
          size,
        ),
      };

  SquareSet _fileAttacks(Square square, SquareSet occupied) => _hyperbola(
        SquareSet.fromSquare(square, _size),
        _fileRange[square],
        occupied,
      );

  SquareSet _rankAttacks(Square square, SquareSet occupied) {
    final range = _rankRange[square];
    final bit = SquareSet.fromSquare(square, _size);
    var forward = occupied & range;
    var reverse = forward.mirrorHorizontal();
    forward = forward - bit;
    reverse = reverse - bit.mirrorHorizontal();
    return (forward ^ reverse.mirrorHorizontal()) & range;
  }

  /// Gets squares attacked or defended by a `piece` on `square`, given
  /// `occupied` squares.
  SquareSet of(Piece piece, Square square, SquareSet occupied) {
    switch (piece.role) {
      case Role.bishop:
        return ofBishop(square, occupied);
      case Role.king:
        return ofKing(square);
      case Role.knight:
        return ofKnight(square);
      case Role.pawn:
        return ofPawn(piece.color, square);
      case Role.queen:
        return ofQueen(square, occupied);
      case Role.rook:
        return ofRook(square, occupied);
    }
  }

  /// Return a [SquareSet] with all the square a bishop attacks from this square
  SquareSet ofBishop(Square square, SquareSet occupied) {
    final bit = SquareSet.fromSquare(square, _size);
    return _hyperbola(bit, _diagRange[square], occupied) ^
        _hyperbola(bit, _antiDiagRange[square], occupied);
  }

  /// Return a [SquareSet] with all the square a king attacks from this square
  SquareSet ofKing(Square square) => _kingAttacks[square];

  /// Return a [SquareSet] with all the square a knight attacks from this square
  SquareSet ofKnight(Square square) => _knightAttacks[square];

  /// Return a [SquareSet] with all the square a pawn attacks from this square
  SquareSet ofPawn(Side side, Square square) => _pawnAttacks[side]![square];

  /// Return a [SquareSet] with all the square a pawn attacks from this square
  SquareSet ofQueen(Square square, SquareSet occupied) =>
      ofBishop(square, occupied) ^ ofRook(square, occupied);

  /// Return a [SquareSet] with all the square a rook attacks from this square
  SquareSet ofRook(Square square, SquareSet occupied) =>
      _fileAttacks(square, occupied) ^ _rankAttacks(square, occupied);
      
  /// Gets all squares of the rank, file or diagonal with the two squares
  /// `a` and `b`, or an empty set if they are not aligned.
  SquareSet ray(Square a, Square b) {
    final other = SquareSet.fromSquare(b, _size);
    if (_rankRange[a].isIntersected(other)) {
      return _rankRange[a].withSquare(a);
    }
    if (_antiDiagRange[a].isIntersected(other)) {
      return _antiDiagRange[a].withSquare(a);
    }
    if (_diagRange[a].isIntersected(other)) {
      return _diagRange[a].withSquare(a);
    }
    if (_fileRange[a].isIntersected(other)) {
      return _fileRange[a].withSquare(a);
    }
    return SquareSet.empty(_size);
  }

  /// Gets all squares between `a` and `b` (bounds not included), or an empty set
  /// if they are not on the same rank, file or diagonal.
  SquareSet between(Square a, Square b) {
    final full = SquareSet.full(_size);
    return ray(a, b).intersect(full.shl(a).xor(full.shl(b))).withoutFirst();
  }
}

// --

SquareSet _computeRange(
  Square square,
  List<List<int>> deltas,
  SquareSetSize size,
) {
  final x = size.fileOf(square);
  final y = size.rankOf(square);
  var range = SquareSet.empty(size);
  for (final [dx, dy] in deltas) {
    final sqX = x + dx;
    if (sqX < 0 || size.files <= sqX) continue;
    final sqY = y + dy;
    if (sqY < 0 || size.ranks <= sqY) continue;
    range = range.withSquare(sqY * size.files + sqX);
  }
  return range;
}

List<T> _tabulate<T>(T Function(Square square) f, SquareSetSize size) {
  final table = <T>[];
  for (var square = 0; square < size.squaresCount; square++) {
    table.insert(square, f(square));
  }
  return table;
}

SquareSet _hyperbola(SquareSet bit, SquareSet range, SquareSet occupied) {
  var forward = occupied & range;
  var reverse = forward.flipVertical(); // Assumes no more than 1 bit per rank
  forward = forward - bit;
  reverse = reverse - bit.flipVertical();
  return (forward ^ reverse.flipVertical()) & range;
}
