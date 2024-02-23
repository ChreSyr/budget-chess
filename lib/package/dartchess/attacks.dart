import 'package:crea_chess/package/dartchess/models.dart';
import 'package:crea_chess/package/dartchess/square_set.dart';

/// Gets squares attacked or defended by a king on [Square].
SquareSet kingAttacks(Square square, SquareSetSize size) {
  assert(square >= 0 && square < size.squaresCount);
  return _kingAttacks[square];
}

/// Gets squares attacked or defended by a knight on [Square].
SquareSet knightAttacks(Square square, SquareSetSize size) {
  assert(square >= 0 && square < size.squaresCount);
  return _knightAttacks[square];
}

/// Gets squares attacked or defended by a pawn of the given [Side] on [Square].
SquareSet pawnAttacks(Side side, Square square, SquareSetSize size) {
  assert(square >= 0 && square < size.squaresCount);
  return _pawnAttacks[side]![square];
}

/// Gets squares attacked or defended by a bishop on [Square], given `occupied`
/// squares.
SquareSet bishopAttacks(Square square, SquareSet occupied) {
  final bit = SquareSet.fromSquare(square, occupied.size);
  return _hyperbola(bit, _diagRange[square], occupied) ^
      _hyperbola(bit, _antiDiagRange[square], occupied);
}

/// Gets squares attacked or defended by a rook on [Square], given `occupied`
/// squares.
SquareSet rookAttacks(Square square, SquareSet occupied) {
  return _fileAttacks(square, occupied) ^ _rankAttacks(square, occupied);
}

/// Gets squares attacked or defended by a queen on [Square], given `occupied`
/// squares.
SquareSet queenAttacks(Square square, SquareSet occupied) =>
    bishopAttacks(square, occupied) ^ rookAttacks(square, occupied);

/// Gets squares attacked or defended by a `piece` on `square`, given
/// `occupied` squares.
SquareSet attacks(Piece piece, Square square, SquareSet occupied) {
  switch (piece.role) {
    case Role.pawn:
      return pawnAttacks(piece.color, square, occupied.size);
    case Role.knight:
      return knightAttacks(square, occupied.size);
    case Role.bishop:
      return bishopAttacks(square, occupied);
    case Role.rook:
      return rookAttacks(square, occupied);
    case Role.queen:
      return queenAttacks(square, occupied);
    case Role.king:
      return kingAttacks(square, occupied.size);
  }
}

/// Gets all squares of the rank, file or diagonal with the two squares
/// `a` and `b`, or an empty set if they are not aligned.
SquareSet ray(Square a, Square b, SquareSetSize size) {
  final other = SquareSet.fromSquare(b, size);
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
  return SquareSet.empty(size);
}

/// Gets all squares between `a` and `b` (bounds not included), or an empty set
/// if they are not on the same rank, file or diagonal.
SquareSet between(Square a, Square b, SquareSetSize size) {
  final full = SquareSet.full(size);
  return ray(a, b, size).intersect(full.shl(a).xor(full.shl(b))).withoutFirst();
}

// --

SquareSet _computeRange(Square square, List<int> deltas, SquareSetSize size) {
  var range = SquareSet.empty(size);
  for (final delta in deltas) {
    final sq = square + delta;
    if (0 <= sq &&
        sq < size.squaresCount &&
        (size.fileOf(square) - size.fileOf(sq)).abs() <= 2) {
      range = range.withSquare(sq);
    }
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

final _kingAttacks =
    _tabulate((sq) => _computeRange(sq, [-9, -8, -7, -1, 1, 7, 8, 9]));
final _knightAttacks =
    _tabulate((sq) => _computeRange(sq, [-17, -15, -10, -6, 6, 10, 15, 17]));
final _pawnAttacks = {
  Side.white: _tabulate((sq) => _computeRange(sq, [7, 9])),
  Side.black: _tabulate((sq) => _computeRange(sq, [-7, -9])),
};

final _fileRange =
    _tabulate((sq) => SquareSet.fromFile(squareFile(sq)).withoutSquare(sq));
final _rankRange =
    _tabulate((sq) => SquareSet.fromRank(squareRank(sq)).withoutSquare(sq));
final _diagRange = _tabulate((sq) {
  final shift = 8 * (squareRank(sq) - squareFile(sq));
  return (shift >= 0
          ? SquareSet.diagonal.shl(shift)
          : SquareSet.diagonal.shr(-shift))
      .withoutSquare(sq);
});
final _antiDiagRange = _tabulate((sq) {
  final shift = 8 * (squareRank(sq) + squareFile(sq) - 7);
  return (shift >= 0
          ? SquareSet.antidiagonal.shl(shift)
          : SquareSet.antidiagonal.shr(-shift))
      .withoutSquare(sq);
});

SquareSet _hyperbola(SquareSet bit, SquareSet range, SquareSet occupied) {
  var forward = occupied & range;
  var reverse = forward.flipVertical(); // Assumes no more than 1 bit per rank
  forward = forward - bit;
  reverse = reverse - bit.flipVertical();
  return (forward ^ reverse.flipVertical()) & range;
}

SquareSet _fileAttacks(Square square, SquareSet occupied) =>
    _hyperbola(SquareSet.fromSquare(square), _fileRange[square], occupied);

SquareSet _rankAttacks(Square square, SquareSet occupied) {
  final range = _rankRange[square];
  final bit = SquareSet.fromSquare(square);
  var forward = occupied & range;
  var reverse = forward.mirrorHorizontal();
  forward = forward - bit;
  reverse = reverse - bit.mirrorHorizontal();
  return (forward ^ reverse.mirrorHorizontal()) & range;
}
