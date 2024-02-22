import 'package:crea_chess/package/dartchess/models.dart';
import 'package:meta/meta.dart';

final _max = BigInt.parse('0xffffffffffffffff');
final _fileA = BigInt.parse('0x0101010101010101');
final _rank8 = BigInt.parse('0xff00000000000000');

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
  const SquareSet(this.value);

  /// Creates a [SquareSet] with a single [Square].
  SquareSet.fromSquare(Square square)
      : value = BigInt.one << square;

  /// Creates a [SquareSet] from several [Square]s.
  SquareSet.fromSquares(Iterable<Square> squares)
      : value = squares
            .map((square) => BigInt.one << square)
            .fold(BigInt.zero, (left, right) => left | right);

  /// Create a [SquareSet] containing all squares of the given rank.
  SquareSet.fromRank(int rank, SquareSetSize size)
      : value = size.rank1 << (size.files * rank),
        assert(rank >= 0 && rank < size.ranks);

  /// Create a [SquareSet] containing all squares of the given file.
  SquareSet.fromFile(int file, SquareSetSize size)
      : value = size.file1 << file,
        assert(file >= 0 && file < size.files);

  /// Create a [SquareSet] containing all squares of the given backrank [Side].
  SquareSet.backrankOf(Side side, SquareSetSize size)
      : value = side == Side.white
            ? size.rank1
            : size.rank1 << (size.files * (size.ranks - 1));

  /// 64 bit integer representing the square set.
  final BigInt value;

  static final empty = SquareSet(BigInt.zero);
  
  // SquareSet full(SquareSetSize size) => SquareSet(size.max);
  // SquareSet lightSquares(SquareSetSize size) => SquareSet(size.lightSquares);
  // SquareSet darkSquares(SquareSetSize size) => SquareSet(size.darkSquares);
  // SquareSet diagonal(SquareSetSize size) =>
  //     SquareSet(BigInt.parse('0x8040201008040201'));
  // SquareSet antidiagonal(SquareSetSize size) =>
  //     SquareSet(BigInt.parse('0x0102040810204080'));
  // SquareSet corners(SquareSetSize size) =>
  //     SquareSet(BigInt.parse('0x8100000000000081'));
  // SquareSet center(SquareSetSize size) =>
  //     SquareSet(BigInt.parse('0x0000001818000000'));
  // SquareSet backranks(SquareSetSize size) =>
  //     SquareSet(BigInt.parse('0xff000000000000ff')); // TODO

  /// Bitwise right shift
  SquareSet shr(int shift) {
    if (shift >= 64) return SquareSet.empty;
    if (shift > 0) return SquareSet(value >> shift);
    return this;
  }

  /// Bitwise left shift
  SquareSet shl(int shift) {
    if (shift >= 64) return SquareSet.empty;
    if (shift > 0) return SquareSet(value << shift & _max);
    return this;
  }

  SquareSet xor(SquareSet other) => SquareSet(value ^ other.value);
  SquareSet operator ^(SquareSet other) => SquareSet(value ^ other.value);

  SquareSet union(SquareSet other) => SquareSet(value | other.value);
  SquareSet operator |(SquareSet other) => SquareSet(value | other.value);

  SquareSet intersect(SquareSet other) => SquareSet(value & other.value);
  SquareSet operator &(SquareSet other) => SquareSet(value & other.value);

  SquareSet minus(SquareSet other) => SquareSet(value - other.value);
  SquareSet operator -(SquareSet other) => SquareSet(value - other.value);

  SquareSet complement() => SquareSet(~value);

  SquareSet diff(SquareSet other) => SquareSet(value & ~other.value);

  SquareSet flipVertical(SquareSetSize size) {
    return SquareSet(
      List.generate(
        size.ranks,
        (index) =>
            _getRank(index, size) << size.files * (size.ranks - 1 - index),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 + bi2),
    );
  }

  SquareSet mirrorHorizontal(SquareSetSize size) {
    return SquareSet(
      List.generate(
        size.files,
        (index) => _getFile(index, size) << size.files - 1 - index,
      ).fold(BigInt.zero, (bi1, bi2) => bi1 + bi2),
    );
  }

  int get size => _nsbBigInt(value);
  bool get isEmpty => value == BigInt.zero;
  bool get isNotEmpty => value != BigInt.zero;
  int? get first => _getFirstSquare(value);
  int? get last => _getLastSquare(value);
  Iterable<Square> get squares => _iterateSquares();
  Iterable<Square> get squaresReversed => squares.toList().reversed;
  bool get moreThanOne => isNotEmpty && size > 1;

  /// Returns square if it is single, otherwise returns null.
  int? get singleSquare => moreThanOne ? null : last;

  bool has(Square square, SquareSetSize size) {
    assert(square >= 0 && square < size.ranks * size.files);
    return value & (BigInt.one << square) != BigInt.zero;
  }

  bool isIntersected(SquareSet other) => intersect(other).isNotEmpty;
  bool isDisjoint(SquareSet other) => intersect(other).isEmpty;

  SquareSet withSquare(Square square) {
    assert(square >= 0 && square < 64);
    return SquareSet(value | (BigInt.one << square));
  }

  SquareSet withoutSquare(Square square) {
    assert(square >= 0 && square < 64);
    return SquareSet(value & ~(BigInt.one << square));
  }

  /// Removes [Square] if present, or put it if absent.
  SquareSet toggleSquare(Square square) {
    assert(square >= 0 && square < 64);
    return SquareSet(value ^ (BigInt.one << square));
  }

  SquareSet withoutFirst() {
    final f = first;
    return f != null ? withoutSquare(f) : empty;
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
    return ntz >= 0 && ntz < 64 ? ntz : null;
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
  
  BigInt _getFile(int fileIndex, SquareSetSize size) {
    return size.file1 & (value >> fileIndex);
  }

  BigInt _getRank(int rankIndex, SquareSetSize size) {
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
