// ignore_for_file: always_use_package_imports, public_member_api_docs

import 'dart:math' as math;

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'board.dart';
import 'fen.dart';
import 'models.dart';
import 'position.dart';
import 'square_map.dart';

/// A not necessarily legal position.
@immutable
class Setup {
  const Setup({
    required this.board,
    required this.turn,
    required this.unmovedRooks,
    required this.halfmoves,
    required this.fullmoves,
    this.pockets,
    this.epSquare,
    this.remainingChecks,
  });

  /// Parse Forsyth-Edwards-Notation and returns a Setup.
  ///
  /// The parser is relaxed:
  ///
  /// * Supports X-FEN and Shredder-FEN for castling right notation.
  /// * Accepts missing FEN fields (except the board) and fills them with
  ///   default values of `8/8/8/8/8/8/8/8 w - - 0 1`.
  /// * Accepts multiple spaces and underscores (`_`) as separators between
  ///   FEN fields.
  ///
  /// Throws a [FenError] if the provided FEN is not valid.
  factory Setup.parseFen(String fen, {BoardSize? size}) {
    final parts = fen.split(RegExp(r'[\s_]+'));
    if (parts.isEmpty) throw const FenError('ERR_FEN');

    // board and pockets
    final boardPocketsPart = parts.removeAt(0);
    final String boardPart;
    Pockets? pockets;
    if (boardPocketsPart.endsWith(']')) {
      final pocketStart = boardPocketsPart.indexOf('[');
      if (pocketStart == -1) {
        throw const FenError('ERR_FEN');
      }
      boardPart = boardPocketsPart.substring(0, pocketStart);
      pockets = _parsePockets(
        boardPocketsPart.substring(
          pocketStart + 1,
          boardPocketsPart.length - 1,
        ),
      );
    } else {
      boardPart = boardPocketsPart;
    }
    if (size == null) {
      final (files, ranks) = FEN.getFilesRanksOf(boardPart);
      size = BoardSize(files: files, ranks: ranks);
    }
    final board = Board.parseFen(boardPart, size: size);

    // turn
    Side turn;
    if (parts.isEmpty) {
      turn = Side.white;
    } else {
      final turnPart = parts.removeAt(0);
      if (turnPart == 'w') {
        turn = Side.white;
      } else if (turnPart == 'b') {
        turn = Side.black;
      } else {
        throw const FenError('ERR_TURN');
      }
    }

    // Castling
    SquareMap unmovedRooks;
    if (parts.isEmpty) {
      unmovedRooks = SquareMap.zero;
    } else {
      final castlingPart = parts.removeAt(0);
      unmovedRooks = _parseCastlingFen(board, castlingPart);
    }

    // En passant square
    Square? epSquare;
    if (parts.isNotEmpty) {
      final epPart = parts.removeAt(0);
      if (epPart != '-') {
        epSquare = board.size.parseSquare(epPart);
        if (epSquare == null) throw const FenError('ERR_EP_SQUARE');
      }
    }

    // move counters or remainingChecks
    var halfmovePart = parts.isNotEmpty ? parts.removeAt(0) : null;
    (int, int)? earlyRemainingChecks;
    if (halfmovePart != null && halfmovePart.contains('+')) {
      earlyRemainingChecks = _parseRemainingChecks(halfmovePart);
      halfmovePart = parts.isNotEmpty ? parts.removeAt(0) : null;
    }
    final halfmoves = halfmovePart != null ? _parseSmallUint(halfmovePart) : 0;
    if (halfmoves == null) {
      throw const FenError('ERR_HALFMOVES');
    }

    final fullmovesPart = parts.isNotEmpty ? parts.removeAt(0) : null;
    final fullmoves =
        fullmovesPart != null ? _parseSmallUint(fullmovesPart) : 1;
    if (fullmoves == null) {
      throw const FenError('ERR_FULLMOVES');
    }

    final remainingChecksPart = parts.isNotEmpty ? parts.removeAt(0) : null;
    (int, int)? remainingChecks;
    if (remainingChecksPart != null) {
      if (earlyRemainingChecks != null) {
        throw const FenError('ERR_REMAINING_CHECKS');
      }
      remainingChecks = _parseRemainingChecks(remainingChecksPart);
    } else if (earlyRemainingChecks != null) {
      remainingChecks = earlyRemainingChecks;
    }

    if (parts.isNotEmpty) {
      throw const FenError('ERR_FEN');
    }

    return Setup(
      board: board,
      pockets: pockets,
      turn: turn,
      unmovedRooks: unmovedRooks,
      epSquare: epSquare,
      halfmoves: halfmoves,
      fullmoves: fullmoves,
      remainingChecks: remainingChecks,
    );
  }

  factory Setup.fromHalfSetups({
    required BoardSize size,
    required String? whiteSetupFen,
    required String? blackSetupFen,
  }) {
    whiteSetupFen ??= size.emptyHalfFen;
    blackSetupFen ??= size.emptyHalfFen;

    final (whiteFiles, whiteRanks) = FEN.getFilesRanksOf(whiteSetupFen);
    final (blackFiles, blackRanks) = FEN.getFilesRanksOf(whiteSetupFen);
    if (whiteFiles != size.files || blackFiles != size.files) {
      throw const FenError("Files don't match");
    }
    if (whiteRanks + blackRanks + (size.ranks.isEven ? 0 : 1) != size.ranks) {
      throw const FenError("Ranks don't match");
    }

    final board = Board.parseFen(
      '${blackSetupFen.split('').reversed.join()}${size.ranks.isEven ? '' : '8/'}/$whiteSetupFen',
      size: size,
    );

    return Setup(
      board: board,
      turn: Side.white,
      unmovedRooks: board.rooks,
      halfmoves: 0,
      fullmoves: 0,
    );
  }

  /// Piece positions on the board.
  final Board board;

  /// Pockets in chess variants like [Crazyhouse].
  final Pockets? pockets;

  /// Side to move.
  final Side turn;

  /// Unmoved rooks positions used to determine castling rights.
  final SquareMap unmovedRooks;

  /// En passant target square.
  ///
  /// Valid target squares are on the third or sixth rank.
  final Square? epSquare;

  /// Number of half-moves since the last capture or pawn move.
  final int halfmoves;

  /// Current move number.
  final int fullmoves;

  /// Number of remainingChecks for white and black.
  final (int, int)? remainingChecks;

  static final standard = Setup(
    board: Board.standard,
    turn: Side.white,
    unmovedRooks: BoardSize.standard.corners,
    halfmoves: 0,
    fullmoves: 1,
  );

  String get turnLetter => turn.name[0];

  String get fen => [
        board.fen + (pockets != null ? _makePockets(pockets!) : ''),
        turnLetter,
        _makeCastlingFen(board, unmovedRooks),
        if (epSquare != null) board.size.algebraicOf(epSquare!) else '-',
        if (remainingChecks != null) _makeRemainingChecks(remainingChecks!),
        math.max(0, math.min(halfmoves, 9999)),
        math.max(1, math.min(fullmoves, 9999)),
      ].join(' ');

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Setup &&
            other.board == board &&
            other.turn == turn &&
            other.unmovedRooks == unmovedRooks &&
            other.epSquare == epSquare &&
            other.halfmoves == halfmoves &&
            other.fullmoves == fullmoves;
  }

  @override
  int get hashCode => Object.hash(
        board,
        turn,
        unmovedRooks,
        epSquare,
        halfmoves,
        fullmoves,
      );
}

/// Pockets (captured pieces) in chess variants like [Crazyhouse].
@immutable
class Pockets {
  const Pockets({
    required this.value,
  });

  final BySide<ByRole<int>> value;

  /// An empty pocket.
  static const empty = Pockets(value: _emptyPocketsBySide);

  /// Gets the total number of pieces in the pocket.
  int get size => value.values
      .fold(0, (acc, e) => acc + e.values.fold(0, (acc, e) => acc + e));

  /// Gets the number of pieces of that [Side] and [Role] in the pocket.
  int of(Side side, Role role) {
    return value[side]![role]!;
  }

  /// Counts the number of pieces by [Role].
  int count(Role role) {
    return value[Side.white]![role]! + value[Side.black]![role]!;
  }

  /// Checks whether this side has at least 1 quality (any piece but a pawn).
  bool hasQuality(Side side) {
    final bySide = value[side]!;
    return bySide[Role.knight]! > 0 ||
        bySide[Role.bishop]! > 0 ||
        bySide[Role.rook]! > 0 ||
        bySide[Role.queen]! > 0 ||
        bySide[Role.king]! > 0;
  }

  /// Checks whether this side has at least 1 pawn.
  bool hasPawn(Side side) {
    return value[side]![Role.pawn]! > 0;
  }

  /// Increments the number of pieces in the pocket of that [Side] and [Role].
  Pockets increment(Side side, Role role) {
    final newPocket = value[side]!.add(role, of(side, role) + 1);
    return Pockets(value: value.add(side, newPocket));
  }

  /// Decrements the number of pieces in the pocket of that [Side] and [Role].
  Pockets decrement(Side side, Role role) {
    final newPocket = value[side]!.add(role, of(side, role) - 1);
    return Pockets(value: value.add(side, newPocket));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is Pockets && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

Pockets _parsePockets(String pocketPart) {
  if (pocketPart.length > 64) {
    throw const FenError('ERR_POCKETS');
  }
  var pockets = Pockets.empty;
  for (var i = 0; i < pocketPart.length; i++) {
    final c = pocketPart[i];
    final piece = Piece.fromChar(c);
    if (piece == null) {
      throw const FenError('ERR_POCKETS');
    }
    pockets = pockets.increment(piece.color, piece.role);
  }
  return pockets;
}

(int, int) _parseRemainingChecks(String part) {
  final parts = part.split('+');
  if (parts.length == 3 && parts[0] == '') {
    final white = _parseSmallUint(parts[1]);
    final black = _parseSmallUint(parts[2]);
    if (white == null || white > 3 || black == null || black > 3) {
      throw const FenError('ERR_REMAINING_CHECKS');
    }
    return (3 - white, 3 - black);
  } else if (parts.length == 2) {
    final white = _parseSmallUint(parts[0]);
    final black = _parseSmallUint(parts[1]);
    if (white == null || white > 3 || black == null || black > 3) {
      throw const FenError('ERR_REMAINING_CHECKS');
    }
    return (white, black);
  } else {
    throw const FenError('ERR_REMAINING_CHECKS');
  }
}

SquareMap _parseCastlingFen(Board board, String castlingPart) {
  var unmovedRooks = SquareMap.zero;
  if (castlingPart == '-') {
    return unmovedRooks;
  }
  for (var i = 0; i < castlingPart.length; i++) {
    final c = castlingPart[i];
    final lower = c.toLowerCase();
    final color = c == lower ? Side.black : Side.white;
    final backrankMask = board.size.backrankOf(color);
    final backrank = backrankMask & board.bySide(color);

    Iterable<Square> candidates;
    if (lower == 'q') {
      candidates = backrank.squares;
    } else if (lower == 'k') {
      candidates = backrank.squaresReversed;
    } else if ('a'.compareTo(lower) <= 0 &&
        lower.compareTo(board.size.fileIds.last) <= 0) {
      // Casle rights with rook file. Ex : qkGK
      // TODO : replace by UNI-FEN notation. Ex : qkQ(g)K
      candidates = (SquareMapExt.fromFile(
                lower.codeUnitAt(0) - 'a'.codeUnitAt(0),
                board.size,
              ) &
              backrank)
          .squares;
    } else {
      throw const FenError('ERR_CASTLING');
    }
    for (final square in candidates) {
      if (board.kings.has(square)) break;
      if (board.rooks.has(square)) {
        unmovedRooks = unmovedRooks.withSquare(square);
        break;
      }
    }
  }
  if ((SquareMapExt.fromRank(0, board.size) & unmovedRooks).length > 2 ||
      (SquareMapExt.fromRank(board.size.ranks - 1, board.size) & unmovedRooks)
              .length >
          2) {
    throw const FenError('ERR_CASTLING');
  }
  return unmovedRooks;
}

String _makePockets(Pockets pockets) {
  final wPart = [
    for (final r in Role.values)
      ...List.filled(pockets.of(Side.white, r), r.char),
  ].join();
  final bPart = [
    for (final r in Role.values)
      ...List.filled(pockets.of(Side.black, r), r.char),
  ].join();
  return '[${wPart.toUpperCase()}$bPart]';
}

String _makeCastlingFen(Board board, SquareMap unmovedRooks) {
  final buffer = StringBuffer();
  for (final color in Side.values) {
    final backrank = board.size.backrankOf(color);
    final king = board.kingOf(color);
    final candidates =
        board.byPiece(Piece(color: color, role: Role.rook)) & backrank;
    for (final rook in (unmovedRooks & candidates).squaresReversed) {
      if (rook == candidates.first && king != null && rook < king) {
        buffer.write(color == Side.white ? 'Q' : 'q');
      } else if (rook == candidates.last && king != null && king < rook) {
        buffer.write(color == Side.white ? 'K' : 'k');
      } else {
        // Casle rights with rook file. Ex : qkGK
        // TODO : replace by UNI-FEN notation. Ex : qkQ(g)K
        final file = board.size.fileIds[board.size.fileOf(rook)];
        buffer.write(color == Side.white ? file.toUpperCase() : file);
      }
    }
  }
  final fen = buffer.toString();
  return fen != '' ? fen : '-';
}

String _makeRemainingChecks((int, int) checks) {
  final (white, black) = checks;
  return '$white+$black';
}

int? _parseSmallUint(String str) =>
    RegExp(r'^\d{1,4}$').hasMatch(str) ? int.parse(str) : null;

const ByRole<int> _emptyPocket = IMapConst({
  Role.pawn: 0,
  Role.knight: 0,
  Role.bishop: 0,
  Role.rook: 0,
  Role.queen: 0,
  Role.king: 0,
});

const BySide<ByRole<int>> _emptyPocketsBySide = IMapConst({
  Side.white: _emptyPocket,
  Side.black: _emptyPocket,
});
