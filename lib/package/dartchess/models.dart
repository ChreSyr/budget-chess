import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

/// A map of squares represented by a (ranks x files) square mask, using little
/// endian rank-file (LERF) mapping.
///
/// For 8 files x 8 ranks :
/// ```
///  7 | 56 57 58 59 60 61 62 63
///  6 | 48 49 50 51 52 53 54 55
///  5 | 40 41 42 43 44 45 46 47
///  4 | 32 33 34 35 36 37 38 39
///  3 | 24 25 26 27 28 29 30 31
///  2 | 16 17 18 19 20 21 22 23
///  1 | 8  9  10 11 12 13 14 15
///  0 | 0  1  2  3  4  5  6  7
///    -------------------------
///      0  1  2  3  4  5  6  7
/// ```
typedef SquareMap = BigInt;

/// Number between 0 and SquareMap.capacity - 1 included representing a square
/// on the board.
///
/// See [SquareMap] to see how the mapping looks like.
typedef Square = int;

/// Square identifier using the algebraic coordinate notation such as e2, c3,
/// etc.
///
/// The first rank is noted 1 and the first file is noted a.
typedef SquareId = String;

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

/// All the squares on the board.
abstract class StandardSquares {
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

/// Utility for nullable fields in copyWith methods
class Box<T> {
  const Box(this.value);
  final T value;
}
