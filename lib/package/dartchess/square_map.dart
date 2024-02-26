import 'package:crea_chess/package/dartchess/models.dart';

/// An object used to interpet a BigInt as a [SquareMap] where each square is a
/// [Square].
class SquareMapSize {
  SquareMapSize({required this.files, required this.ranks})
      : capacity = files * ranks,
        file1 = _generateFile1(files, ranks),
        rank1 = _generateRank1(files, ranks),
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
  final SquareMap file1;
  final SquareMap rank1;
  final BigInt lightSquares;
  final BigInt darkSquares;
  final BigInt diagonal; // diag from bottomleft corner, can exceed the size
  final BigInt antidiagonal; // from bottomright corner, can exceed the size
  final BigInt corners;
  final BigInt center;
  final BigInt backranks;

  /// Return a [SquareMap] of this size with all squares of the first file.
  static SquareMap _generateFile1(int files, int ranks) => List.generate(
        ranks,
        (index) => BigInt.one << (index * files),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

  /// Return a [SquareMap] of this size with all squares of the first rank.
  static SquareMap _generateRank1(int files, int ranks) =>
      (BigInt.one << files) - BigInt.one;

  /// Return a [SquareMap] of this size with all light squares.
  static BigInt _generateLightSquares(int files, int ranks) => List.generate(
        files * ranks,
        (index) =>
            BigInt.one <<
            (index * 2 +
                (files.isEven && ((index * 2 + 1) ~/ files).isOdd ? 0 : 1)),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

  /// Return a [SquareMap] of this size with all dark squares.
  static BigInt _generateDarkSquares(int files, int ranks) => List.generate(
        files * ranks,
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
  static BigInt _generateBackranks(int files, int ranks) => [
        _generateRank1(files, ranks),
        _generateRank1(files, ranks) << (files * (ranks - 1)),
      ].fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

  /// Gets the rank of that square.
  int rankOf(int square) => square ~/ files;

  /// Gets the file of that square.
  int fileOf(int square) => square.remainder(files);
}

/// This extension helps to visualize the BigInt as a square map for chess boards.
extension SquareMapExt on SquareMap {
  /// Creates a [SquareMap] with a single square.
  static SquareMap fromSquare(int square) => (BigInt.one << square);

  /// Create a [SquareMap] containing all squares of the given rank.
  static SquareMap fromRank(int rank, SquareMapSize size) =>
      size.rank1 << (size.files * rank);

  /// Create a [SquareMap] containing all squares of the given file.
  static SquareMap fromFile(int file, SquareMapSize size) => size.file1 << file;

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

  /// Return a list of the squares of the [SquareMap].
  ///
  /// Ex : 001010 => [2, 4]
  Iterable<Square> get squares sync* {
    var bitboard = this;
    while (bitboard != BigInt.zero) {
      final square = bitboard.first;
      bitboard ^= BigInt.one << square!;
      yield square;
    }
  }

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
    return size.file1 & (this >> fileIndex);
  }

  /// Return a [SquareMap] of this size with all squares of the rank at
  /// rankIndex.
  SquareMap _getRank(int rankIndex, SquareMapSize size) {
    return size.rank1 & (this >> (rankIndex * size.files));
  }
}
