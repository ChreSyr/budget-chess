import 'package:crea_chess/package/dartchess/models.dart';
import 'package:crea_chess/package/dartchess/size.dart';
import 'package:meta/meta.dart';

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
