import 'package:crea_chess/package/dartchess/board.dart';
import 'package:crea_chess/package/dartchess/models.dart';
import 'package:meta/meta.dart';

@immutable
class SquareSetSize {
  SquareSetSize({
    required BoardSize boardSize,
  })  : files = boardSize.files,
        ranks = boardSize.ranks,
        squaresCount = boardSize.files * boardSize.ranks,
        full = SquareSetSize._full(boardSize),
        file1 = SquareSetSize._file1(boardSize),
        rank1 = SquareSetSize._rank1(boardSize),
        lightSquares = SquareSetSize._lightSquares(boardSize),
        darkSquares = SquareSetSize._darkSquares(boardSize),
        diagonal = SquareSetSize._diagonal(boardSize),
        antidiagonal = SquareSetSize._antidiagonal(boardSize),
        corners = SquareSetSize._corners(boardSize),
        center = SquareSetSize._center(boardSize),
        backranks = SquareSetSize._backranks(boardSize);

  const SquareSetSize._({
    required this.files,
    required this.ranks,
    required this.squaresCount,
    required this.full,
    required this.file1,
    required this.rank1,
    required this.lightSquares,
    required this.darkSquares,
    required this.diagonal,
    required this.antidiagonal,
    required this.corners,
    required this.center,
    required this.backranks,
  });

  final int files;
  final int ranks;
  final int squaresCount;
  final BigInt full;
  final BigInt file1;
  final BigInt rank1;
  final BigInt lightSquares;
  final BigInt darkSquares;
  final BigInt diagonal; // diag from bottomleft corner, can exceed the size
  final BigInt antidiagonal; // from bottomright corner, can exceed the size
  final BigInt corners;
  final BigInt center;
  final BigInt backranks;

  static final standard = SquareSetSize._(
    files: BoardSize.standard.files,
    ranks: BoardSize.standard.ranks,
    squaresCount: 64,
    full: BigInt.parse('0xffffffffffffffff'),
    file1: BigInt.parse('0x0101010101010101'),
    rank1: BigInt.parse('0x00000000000000ff'),
    lightSquares: BigInt.parse('0x55AA55AA55AA55AA'),
    darkSquares: BigInt.parse('0xAA55AA55AA55AA55'),
    diagonal: BigInt.parse('0x8040201008040201'),
    antidiagonal: BigInt.parse('0x0102040810204080'),
    corners: BigInt.parse('0x8100000000000081'),
    center: BigInt.parse('0x0000001818000000'),
    backranks: BigInt.parse('0xff000000000000ff'),
  );

  static BigInt _full(BoardSize boardSize) =>
      (BigInt.one << (boardSize.files * boardSize.ranks)) - BigInt.one;

  static BigInt _file1(BoardSize boardSize) => List.generate(
        boardSize.ranks,
        (index) => BigInt.one << (index * boardSize.files),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

  static BigInt _rank1(BoardSize boardSize) =>
      (BigInt.one << boardSize.files) - BigInt.one;

  static BigInt _lightSquares(BoardSize size) => List.generate(
        size.files * size.ranks,
        (index) =>
            BigInt.one <<
            (index * 2 +
                (size.files.isEven && ((index * 2 + 1) ~/ size.files).isOdd
                    ? 0
                    : 1)),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

  static BigInt _darkSquares(BoardSize size) => List.generate(
        size.files * size.ranks,
        (index) =>
            BigInt.one <<
            (index * 2 +
                (size.files.isEven && ((index * 2 + 1) ~/ size.files).isOdd
                    ? 1
                    : 0)),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

  static BigInt _diagonal(BoardSize size) => List.generate(
        size.files,
        (index) => BigInt.one << (index + (index * size.files)),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

  static BigInt _antidiagonal(BoardSize size) => List.generate(
        size.files,
        (index) =>
            BigInt.one << (size.files - 1 - index + (index * size.files)),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

  static BigInt _corners(BoardSize size) => [
        BigInt.one,
        BigInt.one << size.files - 1,
        BigInt.one << size.files * (size.ranks - 1),
        BigInt.one << (size.files * (size.ranks - 1) + size.files - 1),
      ].fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

  /// Used by king of the hill
  static BigInt _center(BoardSize size) => List.generate(
        size.files.isEven ? 2 : 3,
        (file) => List.generate(
          size.ranks.isEven ? 2 : 3,
          (rank) =>
              BigInt.one <<
              (((size.files - 2) ~/ 2 + file) +
                  (size.files * ((size.ranks - 2) ~/ 2 + rank))),
        ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

  static BigInt _backranks(BoardSize size) => [
        _rank1(size),
        _rank1(size) << (size.files * (size.ranks - 1)),
      ].fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

  @override
  String toString() => 'SquareSetSize(files:$files, ranks:$ranks)';

  /// Gets the rank of that square.
  int rankOf(int square) => square ~/ files;

  /// Gets the file of that square.
  int fileOf(int square) => square.remainder(files);
}

/// A set of squares represented by a (ranks x files) bit mask, using little
/// endian rank-file (LERF) mapping.
///
/// For standard chess :
/// ```
///  8 | 56 57 58 59 60 61 62 63
///  7 | 48 49 50 51 52 53 54 55
///  6 | 40 41 42 43 44 45 46 47
///  5 | 32 33 34 35 36 37 38 39
///  4 | 24 25 26 27 28 29 30 31
///  3 | 16 17 18 19 20 21 22 23
///  2 | 8  9  10 11 12 13 14 15
///  1 | 0  1  2  3  4  5  6  7
///    -------------------------
///      a  b  c  d  e  f  g  h
/// ```
@immutable
class SquareSet {
  /// Creates a [SquareSet] with the provided (ranks x files) bit integer value.
  SquareSet(BigInt bitmap, this.size) : value = bitmap & size.full;

  /// Creates a [SquareSet] with a single [Square].
  SquareSet.fromSquare(Square square, this.size)
      : value = (BigInt.one << square) & size.full,
        assert(0 <= square),
        assert(square < size.squaresCount);

  /// Creates a [SquareSet] from several [Square]s.
  SquareSet.fromSquares(Iterable<Square> squares, this.size)
      : value = squares
                .map((square) => BigInt.one << square)
                .fold(BigInt.zero, (bi1, bi2) => bi1 | bi2) &
            size.full;

  /// Create a [SquareSet] containing all squares of the given rank.
  SquareSet.fromRank(int rank, this.size)
      : value = size.rank1 << (size.files * rank),
        assert(rank >= 0 && rank < size.ranks);

  /// Create a [SquareSet] containing all squares of the given file.
  SquareSet.fromFile(int file, this.size)
      : value = size.file1 << file,
        assert(file >= 0 && file < size.files);

  /// Create a [SquareSet] containing all squares of the given backrank [Side].
  SquareSet.backrankOf(Side side, this.size)
      : value = side == Side.white
            ? size.rank1
            : size.rank1 << (size.files * (size.ranks - 1));

  /// Create a full [SquareSet].
  SquareSet.full(this.size) : value = size.full;

  /// Create an empty [SquareSet].
  SquareSet.empty(this.size) : value = BigInt.zero;

  /// Create an empty [SquareSet].
  SquareSet.corners(this.size) : value = size.corners;

  /// bit integer representing the square set.
  final BigInt value;

  /// An object defining the number of ranks and files of the SquareSet
  final SquareSetSize size;

  /// Bitwise right shift
  SquareSet shr(int shift) {
    if (shift >= size.squaresCount) return cleared;
    if (shift > 0) return SquareSet(value >> shift, size);
    return this;
  }

  /// Bitwise left shift
  SquareSet shl(int shift) {
    if (shift >= size.squaresCount) return cleared;
    if (shift > 0) return SquareSet(value << shift & size.full, size);
    return this;
  }

  SquareSet xor(SquareSet other) => SquareSet(value ^ other.value, size);
  SquareSet operator ^(SquareSet other) => SquareSet(value ^ other.value, size);

  SquareSet union(SquareSet other) => SquareSet(value | other.value, size);
  SquareSet operator |(SquareSet other) => SquareSet(value | other.value, size);

  SquareSet intersect(SquareSet other) => SquareSet(value & other.value, size);
  SquareSet operator &(SquareSet other) => SquareSet(value & other.value, size);

  SquareSet minus(SquareSet other) => SquareSet(value - other.value, size);
  SquareSet operator -(SquareSet other) => SquareSet(value - other.value, size);

  SquareSet complement() => SquareSet(~value, size);

  SquareSet diff(SquareSet other) => SquareSet(value & ~other.value, size);

  SquareSet flipVertical() {
    return SquareSet(
      List.generate(
        size.ranks,
        (index) => _getRank(index) << size.files * (size.ranks - 1 - index),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2),
      size,
    );
  }

  SquareSet mirrorHorizontal() {
    return SquareSet(
      List.generate(
        size.files,
        (index) => _getFile(index) << size.files - 1 - index,
      ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2),
      size,
    );
  }

  int get bits => _nsbBigInt(value);
  SquareSet get cleared => SquareSet(BigInt.zero, size);
  bool get isEmpty => value == BigInt.zero;
  bool get isNotEmpty => value != BigInt.zero;
  int? get first => _getFirstSquare(value);
  int? get last => _getLastSquare(value);
  Iterable<Square> get squares => _iterateSquares();
  Iterable<Square> get squaresReversed => squares.toList().reversed;
  bool get moreThanOne => isNotEmpty && bits > 1;

  /// Returns square if it is single, otherwise returns null.
  int? get singleSquare => moreThanOne ? null : last;

  bool has(Square square) {
    assert(square >= 0 && square < size.squaresCount);
    return value & (BigInt.one << square) != BigInt.zero;
  }

  bool isIntersected(SquareSet other) => intersect(other).isNotEmpty;
  bool isDisjoint(SquareSet other) => intersect(other).isEmpty;

  SquareSet withSquare(Square square) {
    return SquareSet(value | (BigInt.one << square), size);
  }

  SquareSet withoutSquare(Square square) {
    return SquareSet(value & ~(BigInt.one << square), size);
  }

  /// Removes [Square] if present, or put it if absent.
  SquareSet toggleSquare(Square square) {
    return SquareSet(value ^ (BigInt.one << square), size);
  }

  SquareSet withoutFirst() {
    final f = first;
    return f != null ? withoutSquare(f) : cleared;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SquareSet &&
            other.runtimeType == runtimeType &&
            other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'SquareSet(0x${value.toRadixString(16)})';

  Iterable<Square> _iterateSquares() sync* {
    var bitboard = value;
    while (bitboard != BigInt.zero) {
      final square = _getFirstSquare(bitboard);
      bitboard ^= BigInt.one << square!;
      yield square;
    }
  }

  /// Return the position of the lowest bit
  int? _getFirstSquare(BigInt bitboard) {
    final ntz = _ntzBigInt(bitboard);
    return ntz >= 0 && ntz < size.squaresCount ? ntz : null;
  }

  /// Return the position of the highest bit
  int? _getLastSquare(BigInt bitboard) {
    if (bitboard == BigInt.zero) return null;

    var lastSquare = 0;
    var bigInt = bitboard;
    while (bigInt > BigInt.one) {
      bigInt >>= 1;
      lastSquare++;
    }

    return lastSquare;
  }

  BigInt _getFile(int fileIndex) {
    return size.file1 & (value >> fileIndex);
  }

  BigInt _getRank(int rankIndex) {
    return size.rank1 & (value >> (rankIndex * size.files));
  }
}

/// Return the Number of Set Bits in a BigInt
int _nsbBigInt(BigInt bigInt) {
  var count = 0;

  var big = bigInt;
  while (big > BigInt.zero) {
    if (big & BigInt.one == BigInt.one) {
      count++;
    }

    big >>= 1;
  }

  return count;
}

/// Return the Number of Trailing Zeros in a BigInt
int _ntzBigInt(BigInt bigInt) {
  if (bigInt == BigInt.zero) {
    return -1;
  }

  var count = 0;
  var big = bigInt;
  while (big & BigInt.one == BigInt.zero) {
    big >>= 1;
    count++;
  }

  return count;
}
