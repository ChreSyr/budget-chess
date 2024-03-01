import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';

/// The side that can interact with the board.
enum InteractableSide { both, none, white, black }

/// CGPiece kind, such as white pawn, black knight, etc.
enum PieceKind {
  whitePawn,
  whiteKnight,
  whiteBishop,
  whiteRook,
  whiteQueen,
  whiteKing,
  blackPawn,
  blackKnight,
  blackBishop,
  blackRook,
  blackQueen,
  blackKing;

  static PieceKind fromPiece(CGPiece piece) {
    switch (piece.role) {
      case Role.pawn:
        return piece.color == Side.white
            ? PieceKind.whitePawn
            : PieceKind.blackPawn;
      case Role.knight:
        return piece.color == Side.white
            ? PieceKind.whiteKnight
            : PieceKind.blackKnight;
      case Role.bishop:
        return piece.color == Side.white
            ? PieceKind.whiteBishop
            : PieceKind.blackBishop;
      case Role.rook:
        return piece.color == Side.white
            ? PieceKind.whiteRook
            : PieceKind.blackRook;
      case Role.queen:
        return piece.color == Side.white
            ? PieceKind.whiteQueen
            : PieceKind.blackQueen;
      case Role.king:
        return piece.color == Side.white
            ? PieceKind.whiteKing
            : PieceKind.blackKing;
    }
  }
}

/// Describes a set of piece assets.
///
/// The [PieceAssets] must be complete with all the pieces for both sides.
typedef PieceAssets = IMap<PieceKind, AssetImage>;

/// Representation of the piece positions on a board.
typedef Pieces = Map<SquareId, CGPiece>;

/// Sets of each valid destinations for an origin square.
typedef ValidMoves = IMap<SquareId, ISet<SquareId>>;

/// Square highlight color or image on the chessboard.
class HighlightDetails {
  const HighlightDetails({
    this.solidColor,
    this.image,
  }) : assert(
          solidColor != null || image != null,
          'You must provide either `solidColor` or `image`.',
        );

  final Color? solidColor;
  final AssetImage? image;
}

/// Zero-based numeric board coordinate.
///
/// For instance a1 is (0, 0), a2 is (0, 1), etc.
@immutable
class Coord {
  Coord({
    required this.x,
    required this.y,
    required this.boardSize,
  })  : assert(x >= 0 && x < boardSize.files),
        assert(y >= 0 && y < boardSize.ranks);

  Coord.fromSquareId(SquareId squareId, {required this.boardSize})
      : x = squareId.codeUnitAt(0) - 97,
        y = squareId.codeUnitAt(1) - 49;

  final int x;
  final int y;
  final BoardSize boardSize;

  SquareId get squareId => boardSize.allSquareIds[boardSize.ranks * x + y];

  Offset offset(Side orientation, double squareSize) {
    final dx = (orientation == Side.black ? (boardSize.files - 1) - x : x) *
        squareSize;
    final dy = (orientation == Side.black ? y : (boardSize.ranks - 1) - y) *
        squareSize;
    return Offset(dx, dy);
  }

  @override
  String toString() {
    return '($x, $y)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Coord &&
            other.runtimeType == runtimeType &&
            other.x == x &&
            other.y == y;
  }

  @override
  int get hashCode => Object.hash(x, y);

  /// All the coordinates of the chessboard, for a given size.
  static List<Coord> allCoords(BoardSize boardSize) => List.unmodifiable([
        for (final f in boardSize.fileIds)
          for (final r in boardSize.rankIds)
            Coord.fromSquareId(
              '$f$r',
              boardSize: boardSize,
            ),
      ]);
}

/// Describes a chess piece by its role and color.
///
/// Can be promoted.
@immutable
class CGPiece {
  const CGPiece({
    required this.color,
    required this.role,
    this.promoted = false,
  });

  final Side color;
  final Role role;
  final bool promoted;

  PieceKind get kind => PieceKind.fromPiece(this);

  CGPiece copyWith({
    Side? color,
    Role? role,
    bool? promoted,
  }) {
    return CGPiece(
      color: color ?? this.color,
      role: role ?? this.role,
      promoted: promoted ?? this.promoted,
    );
  }

  @override
  String toString() {
    return 'CGPiece(${kind.name})';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CGPiece &&
            other.runtimeType == runtimeType &&
            other.color == color &&
            other.role == role &&
            other.promoted == promoted;
  }

  @override
  int get hashCode => Object.hash(color, role, promoted);

  static const whitePawn = CGPiece(color: Side.white, role: Role.pawn);
  static const whiteKnight = CGPiece(color: Side.white, role: Role.knight);
  static const whiteBishop = CGPiece(color: Side.white, role: Role.bishop);
  static const whiteRook = CGPiece(color: Side.white, role: Role.rook);
  static const whiteQueen = CGPiece(color: Side.white, role: Role.queen);
  static const whiteKing = CGPiece(color: Side.white, role: Role.king);

  static const blackPawn = CGPiece(color: Side.black, role: Role.pawn);
  static const blackKnight = CGPiece(color: Side.black, role: Role.knight);
  static const blackBishop = CGPiece(color: Side.black, role: Role.bishop);
  static const blackRook = CGPiece(color: Side.black, role: Role.rook);
  static const blackQueen = CGPiece(color: Side.black, role: Role.queen);
  static const blackKing = CGPiece(color: Side.black, role: Role.king);
}

/// A piece and its position on the board.
@immutable
class PositionedPiece {
  const PositionedPiece({
    required this.piece,
    required this.squareId,
    required this.coord,
  });

  final CGPiece piece;
  final SquareId squareId;
  final Coord coord;

  PositionedPiece? closest(List<PositionedPiece> pieces) {
    pieces.sort(
      (p1, p2) => _distanceSq(coord, p1.coord) - _distanceSq(coord, p2.coord),
    );
    return pieces.isNotEmpty ? pieces[0] : null;
  }

  int _distanceSq(Coord pos1, Coord pos2) {
    final dx = pos1.x - pos2.x;
    final dy = pos1.y - pos2.y;
    return dx * dx + dy * dy;
  }
}

/// A chess move.
@immutable
class CGMove {
  const CGMove({
    required this.from,
    required this.to,
    this.promotion,
  });

  CGMove.fromUci(String uci)
      : from = uci.substring(0, 2),
        to = uci.substring(2, 4),
        promotion = uci.length > 4 ? _toRole(uci.substring(4)) : null;

  final SquareId from;
  final SquareId to;
  final Role? promotion;

  List<SquareId> get squares => List.unmodifiable([from, to]);

  String get uci => '$from$to${_toPieceLetter(promotion)}';

  bool hasSquare(SquareId squareId) {
    return from == squareId || to == squareId;
  }

  CGMove withPromotion(Role promotion) {
    return CGMove(
      from: from,
      to: to,
      promotion: promotion,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CGMove &&
            other.runtimeType == runtimeType &&
            other.from == from &&
            other.to == to &&
            other.promotion == promotion;
  }

  @override
  int get hashCode => Object.hash(from, to, promotion);

  String _toPieceLetter(Role? role) {
    return switch (role) {
      Role.king => 'k',
      Role.queen => 'q',
      Role.rook => 'r',
      Role.bishop => 'b',
      Role.knight => 'n',
      Role.pawn => 'p',
      _ => ''
    };
  }
}

/// A chess move annotation represented by a symbol and a color.
@immutable
class Annotation {
  const Annotation({
    required this.symbol,
    required this.color,
    this.duration,
  });

  /// Annotation symbol. Two letters max.
  final String symbol;

  /// Annotation background color.
  final Color color;

  /// Specify a duration to create a transient annotation.
  final Duration? duration;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Annotation &&
            other.runtimeType == runtimeType &&
            other.symbol == symbol &&
            other.color == color &&
            other.duration == duration;
  }

  @override
  int get hashCode => Object.hash(symbol, color, duration);
}

Role _toRole(String uciLetter) {
  switch (uciLetter.trim().toLowerCase()) {
    case 'k':
      return Role.king;
    case 'q':
      return Role.queen;
    case 'r':
      return Role.rook;
    case 'b':
      return Role.bishop;
    case 'n':
      return Role.knight;
    default:
      return Role.pawn;
  }
}

/// Base class for shapes that can be drawn on the board.
sealed class Shape {
  /// Decide what shape to draw based on the current shape and the new
  /// destination.
  Shape newDest(Coord newDest);
}

/// An circle shape that can be drawn on the board.
@immutable
class Circle implements Shape {
  const Circle({required this.color, required this.orig});

  final Color color;
  final Coord orig;

  @override
  Shape newDest(Coord newDest) {
    return newDest == orig
        ? this
        : Arrow(color: color, orig: orig, dest: newDest);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Circle &&
            other.runtimeType == runtimeType &&
            other.orig == orig &&
            other.color == color;
  }

  @override
  int get hashCode => Object.hash(color, orig);
}

/// An arrow shape that can be drawn on the board.
@immutable
class Arrow implements Shape {
  const Arrow({
    required this.color,
    required this.orig,
    required this.dest,
  });

  final Color color;
  final Coord orig;
  final Coord dest;

  @override
  Shape newDest(Coord newDest) {
    return Arrow(color: color, orig: orig, dest: newDest);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Arrow &&
            other.runtimeType == runtimeType &&
            other.orig == orig &&
            other.dest == dest &&
            other.color == color;
  }

  @override
  int get hashCode => Object.hash(color, orig, dest);
}
