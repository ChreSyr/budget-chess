import 'package:crea_chess/package/dartchess/models.dart';

/// An object used to interpet a BigInt as a [SquareMap] where each square is a
/// [Square].
class SquareMapSize {
  SquareMapSize({required this.files, required this.ranks})
      : capacity = files * ranks,
        file1 = _generateFile1(files, ranks),
        rank1 = _generateRank1(files, ranks);

  final int files;
  final int ranks;

  /// The number of squares a [SquareMap] with this size can contain.
  final int capacity;
  final SquareMap file1;
  final SquareMap rank1;

  /// Return a [SquareMap] of this size with all squares of the first file.
  static SquareMap _generateFile1(int files, int ranks) => List.generate(
        ranks,
        (index) => BigInt.one << (index * files),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

  /// Return a [SquareMap] of this size with all squares of the first rank.
  static SquareMap _generateRank1(int files, int ranks) =>
      (BigInt.one << files) - BigInt.one;

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
