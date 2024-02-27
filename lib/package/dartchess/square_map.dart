import 'package:crea_chess/package/dartchess/models.dart';

/// An object used to interpet a BigInt as a [SquareMap] where each square is a
/// [Square].
class SquareMapSize {
  SquareMapSize({required this.files, required this.ranks})
      : capacity = files * ranks,
        full = _generateFull(files, ranks),
        firstFile = _generateFirstFile(files, ranks),
        firstRank = _generateFirstRank(files, ranks),
        lastRank = _generateLastRank(files, ranks),
        lightSquares = _generateLightSquares(files, ranks),
        darkSquares = _generateDarkSquares(files, ranks),
        diagonal = _generateDiagonal(files, ranks),
        antidiagonal = _generateAntidiagonal(files, ranks),
        corners = _generateCorners(files, ranks),
        center = _generateCenter(files, ranks),
        backranks = _generateBackranks(files, ranks);

  final int files;
  final int ranks;

  /// The number of squares a [SquareMap] with this size can contain.
  final int capacity;

  /// These fields are used to accelerated calculs.
  final SquareMap full;
  final SquareMap firstFile;
  final SquareMap firstRank;
  final SquareMap lastRank;
  final SquareMap lightSquares;
  final SquareMap darkSquares;
  final SquareMap diagonal; // diag from bottomleft corner, can exceed the size
  final SquareMap antidiagonal; // from bottomright corner, can exceed the size
  final SquareMap corners;
  final SquareMap center;
  final SquareMap backranks;

  static BigInt _generateFull(int files, int ranks) =>
      (BigInt.one << (files * ranks)) - BigInt.one;

  /// Return a [SquareMap] of this size with all squares of the first file.
  static SquareMap _generateFirstFile(int files, int ranks) => List.generate(
        ranks,
        (index) => BigInt.one << (index * files),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

  /// Return a [SquareMap] of this size with all squares of the first rank.
  static SquareMap _generateFirstRank(int files, int ranks) =>
      (BigInt.one << files) - BigInt.one;

  /// Return a [SquareMap] of this size with all squares of the first rank.
  static SquareMap _generateLastRank(int files, int ranks) =>
      ((BigInt.one << files) - BigInt.one) << (files * (ranks - 1));

  /// Return a [SquareMap] of this size with all light squares.
  static BigInt _generateLightSquares(int files, int ranks) => List.generate(
        files * ranks ~/ 2,
        (index) =>
            BigInt.one <<
            (index * 2 +
                (files.isEven && ((index * 2 + 1) ~/ files).isOdd ? 0 : 1)),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

  /// Return a [SquareMap] of this size with all dark squares.
  static BigInt _generateDarkSquares(int files, int ranks) => List.generate(
        (files * ranks + 1) ~/ 2,
        (index) =>
            BigInt.one <<
            (index * 2 +
                (files.isEven && ((index * 2 + 1) ~/ files).isOdd ? 1 : 0)),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

  /// Return a [SquareMap] of this size with diagonal squares from bottomleft.
  static BigInt _generateDiagonal(int files, int ranks) => List.generate(
        files,
        (index) => BigInt.one << (index + (index * files)),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

  /// Return a [SquareMap] of this size with diagonal squares from bottomright.
  static BigInt _generateAntidiagonal(int files, int ranks) => List.generate(
        files,
        (index) => BigInt.one << (files - 1 - index + (index * files)),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

  /// Return a [SquareMap] of this size with corners.
  static BigInt _generateCorners(int files, int ranks) => [
        BigInt.one,
        BigInt.one << files - 1,
        BigInt.one << files * (ranks - 1),
        BigInt.one << (files * (ranks - 1) + files - 1),
      ].fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

  /// Return a [SquareMap] of this size with center. If files are even, center
  /// is 2 squares wide, else it is 3 squares wide. Same for ranks.
  ///
  /// Used by king of the hill
  static BigInt _generateCenter(int files, int ranks) => List.generate(
        files.isEven ? 2 : 3,
        (file) => List.generate(
          ranks.isEven ? 2 : 3,
          (rank) =>
              BigInt.one <<
              (((files - 2) ~/ 2 + file) + (files * ((ranks - 2) ~/ 2 + rank))),
        ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

  /// Return a [SquareMap] of this size with first and last ranks.
  static BigInt _generateBackranks(int files, int ranks) =>
      _generateFirstRank(files, ranks) | _generateLastRank(files, ranks);

  /// Gets the rank of that square.
  int rankOf(int square) => square ~/ files;

  /// Gets the file of that square.
  int fileOf(int square) => square.remainder(files);

  SquareMap backrankOf(Side side) => side == Side.white ? firstRank : lastRank;
}

/// This extension helps to visualize the BigInt as a square map for chess boards.
extension SquareMapExt on SquareMap {
  /// Create a [SquareMap] containing all squares of the given file.
  static SquareMap fromFile(int file, SquareMapSize size) =>
      size.firstFile << file;

  /// Create a [SquareMap] containing all squares of the given rank.
  static SquareMap fromRank(int rank, SquareMapSize size) =>
      size.firstRank << (size.files * rank);

  /// Creates a [SquareMap] with a single square.
  static SquareMap fromSquare(int square) => (BigInt.one << square);

  /// Creates a [SquareSet] from several [Square]s.
  static SquareMap fromSquares(Iterable<Square> squares) => squares
      .map((square) => BigInt.one << square)
      .fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

  /// Return the position of the lowest square.
  ///
  /// Technically, it returns the Number of Trailing Zeros in a BigInt (NTZ)
  int? get first {
    if (this == BigInt.zero) {
      return -1;
    }

    var count = 0;
    var big = this;
    while (big & BigInt.one == BigInt.zero) {
      big >>= 1;
      count++;
    }

    return count;
  }

  bool get isEmpty => this == BigInt.zero;
  bool get isNotEmpty => this != BigInt.zero;
  bool isDisjoint(SquareMap other) => (this & other).isEmpty;
  bool isIntersected(SquareMap other) => (this & other).isNotEmpty;

  /// Return the position of the highest square.
  int? get last {
    if (this == BigInt.zero) return null;

    var lastSquare = 0;
    var bigInt = this;
    while (bigInt > BigInt.one) {
      bigInt >>= 1;
      lastSquare++;
    }

    return lastSquare;
  }

  /// Return the Number of Set Bits in a BigInt
  int get length {
    var count = 0;

    var big = this;
    while (big > BigInt.zero) {
      if (big & BigInt.one == BigInt.one) {
        count++;
      }

      big >>= 1;
    }

    return count;
  }

  /// Return true if this map contains more than one square.
  bool get moreThanOne => isNotEmpty && length > 1;

  /// Returns square if it is single, otherwise returns null.
  int? get singleSquare => moreThanOne ? null : last;

  /// Return a list of the squares of the [SquareMap], from lowest to highest.
  ///
  /// Ex : 001010 => [2, 4]
  Iterable<Square> get squares sync* {
    var bitmap = this;
    while (bitmap != BigInt.zero) {
      final square = bitmap.first;
      bitmap ^= BigInt.one << square!;
      yield square;
    }
  }

  /// Return a list of the squares of the [SquareMap], from highest to lowest.
  ///
  /// Ex : 001010 => [4, 2]
  Iterable<Square> get squaresReversed => squares.toList().reversed;

  SquareMap complement() => ~this;
  SquareMap diff(SquareMap other) => this & ~other;
  SquareMap intersect(SquareMap other) => this & other;
  SquareMap union(SquareMap other) => this | other;
  SquareMap xor(SquareMap other) => this ^ other;

  /// Return the same [SquareMap] flipped vertically, relatively to this size.
  SquareMap flipHorizontal(SquareMapSize size) {
    return List.generate(
      size.files,
      (index) => _getFile(index, size) << size.files - 1 - index,
    ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);
  }

  /// Return the same [SquareMap] flipped vertically, relatively to this size.
  SquareMap flipVertical(SquareMapSize size) {
    return List.generate(
      size.ranks,
      (index) => _getRank(index, size) << size.files * (size.ranks - 1 - index),
    ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);
  }

  bool has(Square square) {
    return this & (BigInt.one << square) != BigInt.zero;
  }

  /// Bitwise right shift
  SquareMap shr(int shift, SquareMapSize size) {
    if (shift >= size.capacity) return SquareMap.zero;
    if (shift > 0) return (this >> shift) & size.full;
    return this;
  }

  /// Bitwise left shift
  SquareMap shl(int shift, SquareMapSize size) {
    if (shift >= size.capacity) return SquareMap.zero;
    if (shift > 0) return (this << shift) & size.full;
    return this;
  }

  /// Removes [Square] if present, or put it if absent.
  SquareMap toggleSquare(Square square) {
    return this ^ (BigInt.one << square);
  }

  /// Return the same [SquareMap] without the lowest square.
  SquareMap withoutFirst() {
    final f = first;
    return f != null ? withoutSquare(f) : SquareMap.zero;
  }

  /// Return the same [SquareMap] with this square set.
  SquareMap withSquare(Square square) {
    return this | (BigInt.one << square);
  }

  /// Return the same [SquareMap] with this square not set.
  SquareMap withoutSquare(Square square) {
    return this & ~(BigInt.one << square);
  }

  /// Return a [SquareMap] of this size with all squares of the file at
  /// fileIndex.
  SquareMap _getFile(int fileIndex, SquareMapSize size) {
    return size.firstFile & (this >> fileIndex);
  }

  /// Return a [SquareMap] of this size with all squares of the rank at
  /// rankIndex.
  SquareMap _getRank(int rankIndex, SquareMapSize size) {
    return size.firstRank & (this >> (rankIndex * size.files));
  }

  String get readable => 'SquareMap(0x${toRadixString(16)})';
}
