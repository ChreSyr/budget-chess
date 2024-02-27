
import 'package:crea_chess/package/dartchess/models.dart';
import 'package:crea_chess/package/dartchess/square_map.dart';

class Attacks {
  Attacks(SquareMapSize size)
      : _size = size,
        _antiDiagRange = Attacks._generateAntiDiagRange(size),
        _diagRange = Attacks._generateDiagRange(size),
        _fileRange = Attacks._generateFileRange(size),
        _rankRange = Attacks._generateRankRange(size),
        _kingAttacks = Attacks._generateKingAttacks(size),
        _knightAttacks = Attacks._generateKnightAttacks(size),
        _pawnAttacks = Attacks._generatePawnAttacks(size);

  final SquareMapSize _size;
  final List<SquareMap> _antiDiagRange;
  final List<SquareMap> _diagRange;
  final List<SquareMap> _fileRange;
  final List<SquareMap> _rankRange;
  final List<SquareMap> _kingAttacks;
  final List<SquareMap> _knightAttacks;
  final Map<Side, List<SquareMap>> _pawnAttacks;

  static final standard = Attacks(SquareMapSize(files: 8, ranks: 8));

  static List<SquareMap> _generateAntiDiagRange(SquareMapSize size) =>
      _tabulate(
        (square) {
          // shift is the lowest square in the same antidiagonal as sq
          final shift = size.files *
              (size.rankOf(square) + size.fileOf(square) - (size.files - 1));
          final antidiagonal = List.generate(
            size.files,
            (index) =>
                BigInt.one << (size.files - 1 - index + (index * size.files)),
          ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

          return (shift >= 0 ? antidiagonal << shift : antidiagonal >> -shift)
              .withoutSquare(square);
        },
        size,
      );

  static List<SquareMap> _generateDiagRange(SquareMapSize size) => _tabulate(
        (sq) {
          // shift is the lower square in the same diagonal as sq
          final shift = size.files * (size.rankOf(sq) - size.fileOf(sq));
          final diagonal = List.generate(
            size.files,
            (index) => BigInt.one << (index + (index * size.files)),
          ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

          return (shift >= 0 ? diagonal << shift : diagonal >> -shift)
              .withoutSquare(sq);
        },
        size,
      );

  static List<SquareMap> _generateFileRange(SquareMapSize size) => _tabulate(
        (sq) => SquareMapExt.fromFile(size.fileOf(sq), size).withoutSquare(sq),
        size,
      );

  static List<SquareMap> _generateRankRange(SquareMapSize size) => _tabulate(
        (sq) => SquareMapExt.fromRank(size.rankOf(sq), size).withoutSquare(sq),
        size,
      );

  static List<SquareMap> _generateKingAttacks(SquareMapSize size) => _tabulate(
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

  static List<SquareMap> _generateKnightAttacks(SquareMapSize size) =>
      _tabulate(
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

  static Map<Side, List<SquareMap>> _generatePawnAttacks(SquareMapSize size) =>
      {
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

  SquareMap _fileAttacks(Square square, SquareMap occupied) => _hyperbola(
        SquareMapExt.fromSquare(square),
        _fileRange[square],
        occupied,
        _size,
      );

  SquareMap _rankAttacks(Square square, SquareMap occupied) {
    final range = _rankRange[square];
    final map = SquareMapExt.fromSquare(square);
    var forward = occupied & range;
    var reverse = forward.flipHorizontal(_size);
    forward = forward - map;
    reverse = reverse - map.flipHorizontal(_size);
    return (forward ^ reverse.flipHorizontal(_size)) & range;
  }

  /// Gets squares attacked or defended by a `piece` on `square`, given
  /// `occupied` squares.
  SquareMap of(Piece piece, Square square, SquareMap occupied) {
    switch (piece.role) {
      case Role.pawn:
        return ofPawn(piece.color, square);
      case Role.knight:
        return ofKnight(square);
      case Role.bishop:
        return ofBishop(square, occupied);
      case Role.rook:
        return ofRook(square, occupied);
      case Role.queen:
        return ofQueen(square, occupied);
      case Role.king:
        return ofKing(square);
    }
  }

  /// Return a [SquareMap] with all the square a bishop attacks from this square
  SquareMap ofBishop(Square square, SquareMap occupied) {
    final map = SquareMapExt.fromSquare(square);
    return _hyperbola(map, _diagRange[square], occupied, _size) ^
        _hyperbola(map, _antiDiagRange[square], occupied, _size);
  }

  /// Return a [SquareMap] with all the square a king attacks from this square
  SquareMap ofKing(Square square) => _kingAttacks[square];

  /// Return a [SquareMap] with all the square a knight attacks from this square
  SquareMap ofKnight(Square square) => _knightAttacks[square];

  /// Return a [SquareMap] with all the square a pawn attacks from this square
  SquareMap ofPawn(Side side, Square square) => _pawnAttacks[side]![square];

  /// Return a [SquareMap] with all the square a pawn attacks from this square
  SquareMap ofQueen(Square square, SquareMap occupied) =>
      ofBishop(square, occupied) ^ ofRook(square, occupied);

  /// Return a [SquareMap] with all the square a rook attacks from this square
  SquareMap ofRook(Square square, SquareMap occupied) =>
      _fileAttacks(square, occupied) ^ _rankAttacks(square, occupied);

  /// Gets all squares of the rank, file or diagonal with the two squares
  /// `a` and `b`, or an empty set if they are not aligned.
  SquareMap ray(Square a, Square b) {
    final other = SquareMapExt.fromSquare(b);
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
    return SquareMap.zero;
  }

  /// Gets all squares between `a` and `b` (bounds not included), or an empty set
  /// if they are not on the same rank, file or diagonal.
  SquareMap between(Square a, Square b) => ray(a, b)
      .intersect(_size.full.shl(a, _size).xor(_size.full.shl(b, _size)))
      .withoutFirst();
}

SquareMap _computeRange(
  Square square,
  List<List<int>> deltas,
  SquareMapSize size,
) {
  final x = size.fileOf(square);
  final y = size.rankOf(square);
  var range = BigInt.zero;
  for (final [dy, dx] in deltas) {
    final sqX = x + dx;
    if (sqX < 0 || size.files <= sqX) continue;
    final sqY = y + dy;
    if (sqY < 0 || size.ranks <= sqY) continue;
    range = range.withSquare(sqY * size.files + sqX);
  }
  return range;
}

List<T> _tabulate<T>(T Function(Square square) f, SquareMapSize size) {
  final table = <T>[];
  for (var square = 0; square < size.capacity; square++) {
    table.insert(square, f(square));
  }
  return table;
}

SquareMap _hyperbola(
  SquareMap square,
  SquareMap range,
  SquareMap occupied,
  SquareMapSize size,
) {
  var forward = occupied & range;
  var reverse =
      forward.flipVertical(size); // Assumes no more than 1 square per rank
  forward = forward - square;
  reverse = reverse - square.flipVertical(size);
  return (forward ^ reverse.flipVertical(size)) & range;
}
