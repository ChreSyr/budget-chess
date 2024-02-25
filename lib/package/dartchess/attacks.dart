
import 'package:crea_chess/package/dartchess/models.dart';
import 'package:crea_chess/package/dartchess/square_map.dart';

class Attacks {
  Attacks(SquareMapSize size)
      : _size = size,
        _antiDiagRange = Attacks._getAntiDiagRange(size),
        _diagRange = Attacks._getDiagRange(size),
        _fileRange = Attacks._getFileRange(size),
        _rankRange = Attacks._getRankRange(size),
        _kingAttacks = Attacks._getKingAttacks(size),
        _knightAttacks = Attacks._getKnightAttacks(size),
        _pawnAttacks = Attacks._getPawnAttacks(size);

  final SquareMapSize _size;
  final List<SquareMap> _antiDiagRange;
  final List<SquareMap> _diagRange;
  final List<SquareMap> _fileRange;
  final List<SquareMap> _rankRange;
  final List<SquareMap> _kingAttacks;
  final List<SquareMap> _knightAttacks;
  final Map<Side, List<SquareMap>> _pawnAttacks;

  static List<SquareMap> _getAntiDiagRange(SquareMapSize size) => _tabulate(
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

  static List<SquareMap> _getDiagRange(SquareMapSize size) => _tabulate(
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

  static List<SquareMap> _getFileRange(SquareMapSize size) => _tabulate(
        (sq) => SquareMapExt.fromFile(size.fileOf(sq), size).withoutSquare(sq),
        size,
      );

  static List<SquareMap> _getRankRange(SquareMapSize size) => _tabulate(
        (sq) => SquareMapExt.fromRank(size.rankOf(sq), size).withoutSquare(sq),
        size,
      );

  static List<SquareMap> _getKingAttacks(SquareMapSize size) => _tabulate(
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

  static List<SquareMap> _getKnightAttacks(SquareMapSize size) => _tabulate(
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

  static Map<Side, List<SquareMap>> _getPawnAttacks(SquareMapSize size) => {
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
              size),
          size,
        ),
      };

  // /// Gets squares attacked or defended by a `piece` on `square`, given
  // /// `occupied` squares.
  // SquareSet of(Piece piece, Square square, SquareSet occupied) {
  //   switch (piece.role) {
  //     case Role.pawn:
  //       return pawnAttacks(piece.color, square, occupied.size);
  //     case Role.knight:
  //       return knightAttacks(square, occupied.size);
  //     case Role.bishop:
  //       return bishopAttacks(square, occupied);
  //     case Role.rook:
  //       return rookAttacks(square, occupied);
  //     case Role.queen:
  //       return queenAttacks(square, occupied);
  //     case Role.king:
  //       return ofKing(square);
  //   }
  // }

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
}

SquareMap _computeRange(
    Square square, List<List<int>> deltas, SquareMapSize size) {
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
    SquareMap square, SquareMap range, SquareMap occupied, SquareMapSize size) {
  var forward = occupied & range;
  var reverse =
      forward.flipVertical(size); // Assumes no more than 1 square per rank
  forward = forward - square;
  reverse = reverse - square.flipVertical(size);
  return (forward ^ reverse.flipVertical(size)) & range;
}
