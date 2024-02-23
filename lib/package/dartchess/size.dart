import 'dart:math';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

/// Square identifier using the algebraic coordinate notation such as e2, c3,
/// etc.
typedef SquareId = String;

/// Number between 0 and 63 included representing a square on the board.
///
/// See [SquareSet] to see how the mapping looks like.
typedef Square = int;

class BoardSizeConverter
    implements JsonConverter<BoardSize, Map<String, dynamic>> {
  const BoardSizeConverter();

  @override
  BoardSize fromJson(Map<String, dynamic> json) {
    return BoardSize.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(BoardSize data) => data.toJson();
}

/// The number of ranks and files of a chessboard
@immutable
class BoardSize {
  factory BoardSize({required int ranks, required int files}) {
    final rankIds = _generateRankIds(ranks);
    final fileIds = _generateFileIds(files);
    return BoardSize._(
      ranks: ranks,
      files: files,
      rankIds: rankIds,
      fileIds: fileIds,
      allSquareIds: List.unmodifiable([
        for (final f in _generateFileIds(files))
          for (final r in _generateRankIds(ranks)) '$f$r',
      ]),
    );
  }

  const BoardSize._({
    required this.ranks,
    required this.files,
    required this.rankIds,
    required this.fileIds,
    required this.allSquareIds,
  })  : assert(ranks <= 10),
        assert(files <= 26);

  factory BoardSize.fromJson(Map<String, dynamic> json) {
    return BoardSize(
      ranks: json['ranks'] as int,
      files: json['files'] as int,
    );
  }

  final int ranks;
  final int files;
  final List<String> rankIds;
  final List<String> fileIds;
  final List<SquareId> allSquareIds;

  Map<String, dynamic> toJson() {
    return {
      'ranks': ranks,
      'files': files,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BoardSize && other.ranks == ranks && other.files == files;
  }

  @override
  int get hashCode => ranks.hashCode ^ files.hashCode;

  static List<String> _generateRankIds(int ranks) => List.unmodifiable(
        List.generate(
          ranks,
          (index) => (1 + index).toString(),
        ),
      );

  static List<String> _generateFileIds(int files) => List.unmodifiable(
        List.generate(
          files,
          (index) => String.fromCharCode(97 + index),
        ),
      );

  static const BoardSize standard = BoardSize._(
    ranks: 8,
    files: 8,
    rankIds: ['1', '2', '3', '4', '5', '6', '7', '8'],
    fileIds: ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'],
    allSquareIds: [
      'a1',
      'a2',
      'a3',
      'a4',
      'a5',
      'a6',
      'a7',
      'a8',
      'b1',
      'b2',
      'b3',
      'b4',
      'b5',
      'b6',
      'b7',
      'b8',
      'c1',
      'c2',
      'c3',
      'c4',
      'c5',
      'c6',
      'c7',
      'c8',
      'd1',
      'd2',
      'd3',
      'd4',
      'd5',
      'd6',
      'd7',
      'd8',
      'e1',
      'e2',
      'e3',
      'e4',
      'e5',
      'e6',
      'e7',
      'e8',
      'f1',
      'f2',
      'f3',
      'f4',
      'f5',
      'f6',
      'f7',
      'f8',
      'g1',
      'g2',
      'g3',
      'g4',
      'g5',
      'g6',
      'g7',
      'g8',
      'h1',
      'h2',
      'h3',
      'h4',
      'h5',
      'h6',
      'h7',
      'h8',
    ],
  );

  /// The board part of the initial position in the FEN format.
  static const standardInitialBoardFEN =
      'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR';

  /// Initial position in the Extended Position Description format.
  static const standardInitialEPD = '$standardInitialBoardFEN w KQkq -';

  /// Initial position in the FEN format.
  static const standardInitialFEN = '$standardInitialEPD 0 1';

  /// Empty board part in the FEN format.
  static const standardEmptyBoardFEN = '8/8/8/8/8/8/8/8';

  /// Empty board in the EPD format.
  static const standardEmptyEPD = '$standardEmptyBoardFEN w - -';

  /// Empty board in the FEN format.
  static const standardEmptyFEN = '$standardEmptyEPD 0 1';

  @override
  String toString() => 'BoardSize(files:$files, ranks:$ranks)';

  String get emptyFen => List.generate(ranks, (_) => files).join('/');

  String get emptyHalfFen => List.generate(ranks ~/ 2, (_) => files).join('/');

  /// Gets the rank of that square.
  int rankOf(int square) => square ~/ files;

  /// Gets the file of that square.
  int fileOf(int square) => square.remainder(files);

  /// Returns the algebraic coordinate notation of the [Square].
  String algebraicOf(Square square) =>
      fileIds[fileOf(square)] + rankIds[rankOf(square)];

  /// Parses a string like 'a1', 'a2', etc. and returns a [Square] or `null` if
  /// the square doesn't exist.
  Square? parseSquare(String str) {
    if (str.length != 2) return null;
    final file = str.codeUnitAt(0) - 97; // 'a'.codeUnitAt(0);
    final rank = str.codeUnitAt(1) - 49; // '1'.codeUnitAt(0);
    if (file < 0 || file >= files || rank < 0 || rank >= ranks) {
      return null;
    }
    return file + files * rank;
  }
}

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
  final BigInt diagonal;
  final BigInt antidiagonal;
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
        min(size.files, size.ranks),
        (index) => BigInt.one << (index + (index * size.files)),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 | bi2);

  static BigInt _antidiagonal(BoardSize size) => List.generate(
        min(size.files, size.ranks),
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

  /// Gets the rank of that square.
  int rankOf(int square) => square ~/ files;

  /// Gets the file of that square.
  int fileOf(int square) => square.remainder(files);
}
