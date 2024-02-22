import 'dart:math';

import 'package:crea_chess/package/dartchess/utils.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

enum Side {
  white,
  black;

  Side get opposite => this == Side.white ? Side.black : Side.white;
}

enum SquareColor {
  light,
  dark;

  SquareColor get opposite =>
      this == SquareColor.light ? SquareColor.dark : SquareColor.light;
}

enum CastlingSide {
  queen,
  king;
}

enum Role {
  pawn,
  knight,
  bishop,
  rook,
  king,
  queen;

  static Role? fromChar(String ch) {
    switch (ch.toLowerCase()) {
      case 'p':
        return Role.pawn;
      case 'n':
        return Role.knight;
      case 'b':
        return Role.bishop;
      case 'r':
        return Role.rook;
      case 'q':
        return Role.queen;
      case 'k':
        return Role.king;
      default:
        return null;
    }
  }

  String get char {
    switch (this) {
      case Role.pawn:
        return 'p';
      case Role.knight:
        return 'n';
      case Role.bishop:
        return 'b';
      case Role.rook:
        return 'r';
      case Role.queen:
        return 'q';
      case Role.king:
        return 'k';
    }
  }
}

/// Square identifier using the algebraic coordinate notation such as e2, c3,
/// etc.
typedef SquareId = String;

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

  @override
  String toString() => 'BoardSize(files:$files, ranks:$ranks)';

  String get emptyFen => List.generate(ranks, (_) => files).join('/');

  String get emptyHalfFen => List.generate(ranks ~/ 2, (_) => files).join('/');
}

@immutable
class SquareSetSize {
  SquareSetSize({
    required BoardSize boardSize,
  })  : files = boardSize.files,
        ranks = boardSize.ranks,
        max = SquareSetSize._max(boardSize),
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
    required this.max,
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
  final BigInt max; // TODO : used ?
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
    max: BigInt.parse('0xffffffffffffffff'),
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

  static BigInt _max(BoardSize boardSize) =>
      (BigInt.one << (boardSize.files * boardSize.ranks)) - BigInt.one;

  static BigInt _file1(BoardSize boardSize) => List.generate(
        boardSize.ranks,
        (index) => BigInt.one << (index * boardSize.files),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 + bi2);

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
      ).fold(BigInt.zero, (bi1, bi2) => bi1 + bi2);

  static BigInt _darkSquares(BoardSize size) => List.generate(
        size.files * size.ranks,
        (index) =>
            BigInt.one <<
            (index * 2 +
                (size.files.isEven && ((index * 2 + 1) ~/ size.files).isOdd
                    ? 1
                    : 0)),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 + bi2);

  static BigInt _diagonal(BoardSize size) => List.generate(
        min(size.files, size.ranks),
        (index) => BigInt.one << (index + (index * size.files)),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 + bi2);

  static BigInt _antidiagonal(BoardSize size) => List.generate(
        min(size.files, size.ranks),
        (index) =>
            BigInt.one << (size.files - 1 - index + (index * size.files)),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 + bi2);

  static BigInt _corners(BoardSize size) => [
        BigInt.one,
        BigInt.one << size.files - 1,
        BigInt.one << size.files * (size.ranks - 1),
        BigInt.one << (size.files * (size.ranks - 1) + size.files - 1),
      ].fold(BigInt.zero, (bi1, bi2) => bi1 + bi2);

  /// Used by king of the hill
  static BigInt _center(BoardSize size) => List.generate(
        size.files.isEven ? 2 : 3,
        (file) => List.generate(
          size.ranks.isEven ? 2 : 3,
          (rank) =>
              BigInt.one <<
              (((size.files - 2) ~/ 2 + file) +
                  (size.files * ((size.ranks - 2) ~/ 2 + rank))),
        ).fold(BigInt.zero, (bi1, bi2) => bi1 + bi2),
      ).fold(BigInt.zero, (bi1, bi2) => bi1 + bi2);

  static BigInt _backranks(BoardSize size) => [
        _rank1(size),
        _rank1(size) << (size.files * (size.ranks - 1)),
      ].fold(BigInt.zero, (bi1, bi2) => bi1 + bi2);
}

/// Number between 0 and 63 included representing a square on the board.
///
/// See [SquareSet] to see how the mapping looks like.
typedef Square = int;

/// All the squares on the board.
abstract class Squares {
  static const a1 = 0;
  static const b1 = 1;
  static const c1 = 2;
  static const d1 = 3;
  static const e1 = 4;
  static const f1 = 5;
  static const g1 = 6;
  static const h1 = 7;
  static const a2 = 8;
  static const b2 = 9;
  static const c2 = 10;
  static const d2 = 11;
  static const e2 = 12;
  static const f2 = 13;
  static const g2 = 14;
  static const h2 = 15;
  static const a3 = 16;
  static const b3 = 17;
  static const c3 = 18;
  static const d3 = 19;
  static const e3 = 20;
  static const f3 = 21;
  static const g3 = 22;
  static const h3 = 23;
  static const a4 = 24;
  static const b4 = 25;
  static const c4 = 26;
  static const d4 = 27;
  static const e4 = 28;
  static const f4 = 29;
  static const g4 = 30;
  static const h4 = 31;
  static const a5 = 32;
  static const b5 = 33;
  static const c5 = 34;
  static const d5 = 35;
  static const e5 = 36;
  static const f5 = 37;
  static const g5 = 38;
  static const h5 = 39;
  static const a6 = 40;
  static const b6 = 41;
  static const c6 = 42;
  static const d6 = 43;
  static const e6 = 44;
  static const f6 = 45;
  static const g6 = 46;
  static const h6 = 47;
  static const a7 = 48;
  static const b7 = 49;
  static const c7 = 50;
  static const d7 = 51;
  static const e7 = 52;
  static const f7 = 53;
  static const g7 = 54;
  static const h7 = 55;
  static const a8 = 56;
  static const b8 = 57;
  static const c8 = 58;
  static const d8 = 59;
  static const e8 = 60;
  static const f8 = 61;
  static const g8 = 62;
  static const h8 = 63;
}

typedef BySide<T> = IMap<Side, T>;
typedef ByRole<T> = IMap<Role, T>;
typedef ByCastlingSide<T> = IMap<CastlingSide, T>;

@immutable
class Piece {
  const Piece({
    required this.color,
    required this.role,
    this.promoted = false,
  });

  final Side color;
  final Role role;
  final bool promoted;

  static Piece? fromChar(String ch) {
    final role = Role.fromChar(ch);
    if (role != null) {
      return Piece(
        role: role,
        color: ch.toLowerCase() == ch ? Side.black : Side.white,
      );
    }
    return null;
  }

  String get fenChar {
    var r = role.char;
    if (color == Side.white) r = r.toUpperCase();
    if (promoted) r += '~';
    return r;
  }

  Piece copyWith({
    Side? color,
    Role? role,
    bool? promoted,
  }) {
    return Piece(
      color: color ?? this.color,
      role: role ?? this.role,
      promoted: promoted ?? this.promoted,
    );
  }

  @override
  String toString() {
    return '${color.name}${role.name}';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Piece &&
            other.runtimeType == runtimeType &&
            color == other.color &&
            role == other.role &&
            promoted == other.promoted;
  }

  @override
  int get hashCode => Object.hash(color, role, promoted);

  static const whitePawn = Piece(color: Side.white, role: Role.pawn);
  static const whiteKnight = Piece(color: Side.white, role: Role.knight);
  static const whiteBishop = Piece(color: Side.white, role: Role.bishop);
  static const whiteRook = Piece(color: Side.white, role: Role.rook);
  static const whiteQueen = Piece(color: Side.white, role: Role.queen);
  static const whiteKing = Piece(color: Side.white, role: Role.king);

  static const blackPawn = Piece(color: Side.black, role: Role.pawn);
  static const blackKnight = Piece(color: Side.black, role: Role.knight);
  static const blackBishop = Piece(color: Side.black, role: Role.bishop);
  static const blackRook = Piece(color: Side.black, role: Role.rook);
  static const blackQueen = Piece(color: Side.black, role: Role.queen);
  static const blackKing = Piece(color: Side.black, role: Role.king);
}

/// Base class for a chess move.
///
/// A move can be either a [NormalMove] or a [DropMove].
@immutable
sealed class Move {
  const Move({
    required this.to,
  });

  /// The target square of this move.
  final Square to;

  /// Gets the UCI notation of this move.
  String get uci;

  /// Constructs a [Move] from an UCI string.
  ///
  /// Returns `null` if UCI string is not valid.
  static Move? fromUci(String str) {
    if (str[1] == '@' && str.length == 4) {
      final role = Role.fromChar(str[0]);
      final to = parseSquare(str.substring(2));
      if (role != null && to != null) return DropMove(to: to, role: role);
    } else if (str.length == 4 || str.length == 5) {
      final from = parseSquare(str.substring(0, 2));
      final to = parseSquare(str.substring(2, 4));
      Role? promotion;
      if (str.length == 5) {
        promotion = Role.fromChar(str[4]);
        if (promotion == null) {
          return null;
        }
      }
      if (from != null && to != null) {
        return NormalMove(from: from, to: to, promotion: promotion);
      }
    }
    return null;
  }

  @override
  String toString() {
    return 'Move($uci)';
  }
}

/// Represents a chess move, possibly a promotion.
@immutable
class NormalMove extends Move {
  const NormalMove({
    required this.from,
    required super.to,
    this.promotion,
  });

  /// The origin square of this move.
  final Square from;

  /// The role of the promoted piece, if any.
  final Role? promotion;

  /// Gets UCI notation, like `g1f3` for a normal move,
  /// `a7a8q` for promotion to a queen.
  @override
  String get uci =>
      toAlgebraic(from) +
      toAlgebraic(to) +
      (promotion != null ? promotion!.char : '');

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other.runtimeType == runtimeType && hashCode == other.hashCode;
  }

  @override
  int get hashCode => Object.hash(from, to, promotion);
}

/// Represents a drop move.
@immutable
class DropMove extends Move {
  const DropMove({
    required super.to,
    required this.role,
  });

  final Role role;

  /// Gets UCI notation of the drop, like `Q@f7`.
  @override
  String get uci => '${role.char.toUpperCase()}@${toAlgebraic(to)}';

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other.runtimeType == runtimeType && hashCode == other.hashCode;
  }

  @override
  int get hashCode => Object.hash(to, role);
}

@immutable
class FenError implements Exception {
  const FenError(this.message);

  final String message;
}

/// Represents the different possible rules of chess and its variants
enum Rule {
  chess,
  antichess,
  kingofthehill,
  threecheck,
  atomic,
  horde,
  racingKings,
  crazyhouse;

  /// Parses a PGN header variant tag
  static Rule? fromPgn(String? variant) {
    switch ((variant ?? 'chess').toLowerCase()) {
      case 'chess':
      case 'chess960':
      case 'chess 960':
      case 'standard':
      case 'from position':
      case 'classical':
      case 'normal':
      case 'fischerandom': // Cute Chess
      case 'fischerrandom':
      case 'fischer random':
      case 'wild/0':
      case 'wild/1':
      case 'wild/2':
      case 'wild/3':
      case 'wild/4':
      case 'wild/5':
      case 'wild/6':
      case 'wild/7':
      case 'wild/8':
      case 'wild/8a':
        return Rule.chess;
      case 'crazyhouse':
      case 'crazy house':
      case 'house':
      case 'zh':
        return Rule.crazyhouse;
      case 'king of the hill':
      case 'koth':
      case 'kingofthehill':
        return Rule.kingofthehill;
      case 'three-check':
      case 'three check':
      case 'threecheck':
      case 'three check chess':
      case '3-check':
      case '3 check':
      case '3check':
        return Rule.threecheck;
      case 'antichess':
      case 'anti chess':
      case 'anti':
        return Rule.antichess;
      case 'atomic':
      case 'atom':
      case 'atomic chess':
        return Rule.atomic;
      case 'horde':
      case 'horde chess':
        return Rule.horde;
      case 'racing kings':
      case 'racingkings':
      case 'racing':
      case 'race':
        return Rule.racingKings;
      default:
        return null;
    }
  }
}
