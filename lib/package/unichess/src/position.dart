// ignore_for_file: public_member_api_docs, always_use_package_imports

import 'dart:math' as math;

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'board.dart';
import 'models.dart';
import 'move.dart';
import 'setup.dart';
import 'square_map.dart';

/// A base class for playable chess or chess variant positions.
///
/// See [Chess] for a concrete implementation of standard rules.
@immutable
abstract class Position<T extends Position<T>> {
  /// A base class for playable chess or chess variant positions.
  ///
  /// See [Chess] for a concrete implementation of standard rules.
  const Position({
    required this.board,
    required this.turn,
    required this.castles,
    required this.halfmoves,
    required this.fullmoves,
    this.pockets,
    this.epSquare,
  });

  /// Abstract const constructor to be used by subclasses.
  Position._initial()
      : board = Board.standard,
        pockets = null,
        turn = Side.white,
        castles = Castles.standard,
        epSquare = null,
        halfmoves = 0,
        fullmoves = 1;

  Position._fromSetupUnchecked(Setup setup)
      : board = setup.board,
        pockets = setup.pockets,
        turn = setup.turn,
        castles = Castles.fromSetup(setup),
        epSquare = _validEpSquare(setup),
        halfmoves = setup.halfmoves,
        fullmoves = setup.fullmoves;

  /// Piece positions on the board.
  final Board board;

  /// Pockets in chess variants like [Crazyhouse].
  final Pockets? pockets;

  /// Side to move.
  final Side turn;

  /// Castling paths and unmoved rooks.
  final Castles castles;

  /// En passant target square.
  final Square? epSquare;

  /// Number of half-moves since the last capture or pawn move.
  final int halfmoves;

  /// Current move number.
  final int fullmoves;

  /// The [Rule] of this position.
  Rule get rule;

  Position<T> _copyWith({
    Board? board,
    Box<Pockets?>? pockets,
    Side? turn,
    Castles? castles,
    Box<Square?>? epSquare,
    int? halfmoves,
    int? fullmoves,
  });

  /// Create a [Position] from a [Setup] and [Rule].
  static Position setupPosition(
    Rule rule,
    Setup setup, {
    bool? ignoreImpossibleCheck,
  }) {
    switch (rule) {
      case Rule.chess:
        return Chess.fromSetup(
          setup,
          ignoreImpossibleCheck: ignoreImpossibleCheck,
        );
      case Rule.antichess:
        return Antichess.fromSetup(
          setup,
          ignoreImpossibleCheck: ignoreImpossibleCheck,
        );
      case Rule.atomic:
        return Atomic.fromSetup(
          setup,
          ignoreImpossibleCheck: ignoreImpossibleCheck,
        );
      case Rule.kingofthehill:
        return KingOfTheHill.fromSetup(
          setup,
          ignoreImpossibleCheck: ignoreImpossibleCheck,
        );
      case Rule.crazyhouse:
        return Crazyhouse.fromSetup(
          setup,
          ignoreImpossibleCheck: ignoreImpossibleCheck,
        );
      case Rule.threecheck:
        return ThreeCheck.fromSetup(
          setup,
          ignoreImpossibleCheck: ignoreImpossibleCheck,
        );
      case Rule.horde:
        return Horde.fromSetup(
          setup,
          ignoreImpossibleCheck: ignoreImpossibleCheck,
        );
      case Rule.racingKings:
        return RacingKings.fromSetup(
          setup,
          ignoreImpossibleCheck: ignoreImpossibleCheck,
        );
    }
  }

  /// Returns the initial [Position] for the corresponding [Rule].
  static Position initialPosition(Rule rule) {
    switch (rule) {
      case Rule.chess:
        return Chess.initial;
      case Rule.antichess:
        return Antichess.initial;
      case Rule.atomic:
        return Atomic.initial;
      case Rule.kingofthehill:
        return KingOfTheHill.initial;
      case Rule.threecheck:
        return ThreeCheck.initial;
      case Rule.crazyhouse:
        return Crazyhouse.initial;
      case Rule.horde:
        return Horde.initial;
      case Rule.racingKings:
        return RacingKings.initial;
    }
  }

  /// Checks if the game is over due to a special variant end condition.
  bool get isVariantEnd;

  /// Tests special variant winning, losing and drawing conditions.
  Outcome? get variantOutcome;

  /// Gets the current ply.
  int get ply => fullmoves * 2 - (turn == Side.white ? 2 : 1);

  /// Gets the FEN string of this position.
  ///
  /// Contrary to the FEN given by [Setup], this should always be a legal
  /// position.
  String get fen {
    return Setup(
      board: board,
      pockets: pockets,
      turn: turn,
      unmovedRooks: castles.unmovedRooks,
      epSquare: _legalEpSquare(),
      halfmoves: halfmoves,
      fullmoves: fullmoves,
    ).fen;
  }

  /// Tests if the king is in check.
  bool get isCheck {
    final king = board.kingOf(turn);
    return king != null && checkers.isNotEmpty;
  }

  /// Tests if the game is over.
  bool get isGameOver =>
      isVariantEnd || isInsufficientMaterial || !hasSomeLegalMoves;

  /// Tests for checkmate.
  bool get isCheckmate =>
      !isVariantEnd && checkers.isNotEmpty && !hasSomeLegalMoves;

  /// Tests for stalemate.
  bool get isStalemate =>
      !isVariantEnd && checkers.isEmpty && !hasSomeLegalMoves;

  /// The outcome of the game, or `null` if the game is not over.
  Outcome? get outcome {
    if (variantOutcome != null) {
      return variantOutcome;
    } else if (isCheckmate) {
      return Outcome(winner: turn.opposite);
    } else if (isInsufficientMaterial || isStalemate) {
      return Outcome.draw;
    } else {
      return null;
    }
  }

  /// Tests if both [Side] have insufficient winning material.
  bool get isInsufficientMaterial => Side.values.every(hasInsufficientMaterial);

  /// Tests if the position has at least one legal move.
  bool get hasSomeLegalMoves {
    final context = _makeContext();
    for (final square in board.bySide(turn).squares) {
      if (_legalMovesOf(square, context: context).isNotEmpty) return true;
    }
    return false;
  }

  /// Gets all the legal moves of this position.
  IMap<Square, SquareMap> get legalMoves {
    final context = _makeContext();
    if (context.isVariantEnd) return IMap(const {});
    return IMap({
      for (final s in board.bySide(turn).squares)
        s: _legalMovesOf(s, context: context),
    });
  }

  /// Gets all the legal drops of this position.
  SquareMap get legalDrops => SquareMap.zero;

  /// SquareMap of pieces giving check.
  SquareMap get checkers {
    final king = board.kingOf(turn);
    return king != null ? kingAttackers(king, turn.opposite) : SquareMap.zero;
  }

  /// Attacks that a king on `square` would have to deal with.
  SquareMap kingAttackers(Square square, Side attacker, {SquareMap? occupied}) {
    return board.attacksTo(square, attacker, occupied: occupied);
  }

  /// Tests if a [Side] has insufficient winning material.
  bool hasInsufficientMaterial(Side side) {
    if (board.bySide(side).isIntersected(board.pawns | board.rooksAndQueens)) {
      return false;
    }
    if (board.bySide(side).isIntersected(board.knights)) {
      return board.bySide(side).length <= 2 &&
          board
              .bySide(side.opposite)
              .diff(board.kings)
              .diff(board.queens)
              .isEmpty;
    }
    if (board.bySide(side).isIntersected(board.bishops)) {
      final sameColor = !board.bishops.isIntersected(board.size.darkSquares) ||
          !board.bishops.isIntersected(board.size.lightSquares);
      return sameColor && board.pawns.isEmpty && board.knights.isEmpty;
    }
    return true;
  }

  /// Tests a move for legality.
  bool isLegal(Move move) {
    switch (move) {
      case NormalMove(from: final f, to: final t, promotion: final p):
        if (p == Role.pawn) return false;
        if (p == Role.king && this is! Antichess) return false;
        if (p != null &&
            (!board.pawns.has(f) || !board.size.backranks.has(t))) {
          return false;
        }
        final legalMoves = _legalMovesOf(f);
        return legalMoves.has(t) || legalMoves.has(normalizeMove(move).to);
      case DropMove(to: final t, role: final r):
        if (pockets == null || pockets!.of(turn, r) <= 0) {
          return false;
        }
        if (r == Role.pawn && board.size.backranks.has(t)) {
          return false;
        }
        return legalDrops.has(t);
    }
  }

  /// Gets the legal moves for that [Square].
  SquareMap legalMovesOf(Square square) {
    return _legalMovesOf(square);
  }

  /// Parses a move in Standard Algebraic Notation.
  ///
  /// Returns a legal [Move] of the [Position] or `null`.
  Move? parseSan(String sanString) {
    // TODO : what if the last rank id is 10 ?
    final aIndex = 'a'.codeUnits[0];
    final lastFileIndex = board.size.fileIds.last.codeUnits[0];
    final oneIndex = '1'.codeUnits[0];
    final lastRankIndex = board.size.rankIds.last.codeUnits[0];
    var san = sanString;

    final firstAnnotationIndex = san.indexOf(RegExp('[!?#+]'));
    if (firstAnnotationIndex != -1) {
      san = san.substring(0, firstAnnotationIndex);
    }

    // Crazyhouse
    if (san.contains('@')) {
      if (san.length == 3 && san[0] != '@') {
        return null;
      }
      if (san.length == 4 && san[1] != '@') {
        return null;
      }
      final Role role;
      if (san.length == 3) {
        role = Role.pawn;
      } else if (san.length == 4) {
        final parsedRole = Role.fromChar(san[0]);
        if (parsedRole == null) {
          return null;
        }
        role = parsedRole;
      } else {
        return null;
      }
      final destination = board.size.parseSquare(san.substring(san.length - 2));
      if (destination == null) {
        return null;
      }
      final move = DropMove(to: destination, role: role);
      if (!isLegal(move)) {
        return null;
      }
      return move;
    }

    if (san == 'O-O') {
      final king = board.kingOf(turn);
      final rook = castles.rookOf(turn, CastlingSide.king);
      if (king == null || rook == null) {
        return null;
      }
      final move = NormalMove(from: king, to: rook);
      if (!isLegal(move)) {
        return null;
      }
      return move;
    }
    if (san == 'O-O-O') {
      final king = board.kingOf(turn);
      final rook = castles.rookOf(turn, CastlingSide.queen);
      if (king == null || rook == null) {
        return null;
      }
      final move = NormalMove(from: king, to: rook);
      if (!isLegal(move)) {
        return null;
      }
      return move;
    }

    final isPromotion = san.contains('=');
    final isCapturing = san.contains('x');
    int? pawnRank;
    if (oneIndex <= san.codeUnits[0] && san.codeUnits[0] <= lastRankIndex) {
      pawnRank = san.codeUnits[0] - oneIndex;
      san = san.substring(1);
    }
    final isPawnMove =
        aIndex <= san.codeUnits[0] && san.codeUnits[0] <= lastFileIndex;

    if (isPawnMove) {
      // Every pawn move has a destination (e.g. d4)
      // Optionally, pawn moves have a promotion
      // If the move is a capture then it will include the source file

      final colorFilter = board.bySide(turn);
      final pawnFilter = board.byRole(Role.pawn);
      var filter = colorFilter.intersect(pawnFilter);
      Role? promotionRole;

      // We can look at the first character of any pawn move
      // in order to determine which file the pawn will be moving
      // from
      final sourceFileCharacter = san.codeUnits[0];
      if (sourceFileCharacter < aIndex || sourceFileCharacter > lastFileIndex) {
        return null;
      }

      final sourceFile = sourceFileCharacter - aIndex;
      final sourceFileFilter = SquareMapExt.fromFile(sourceFile, board.size);
      filter = filter.intersect(sourceFileFilter);

      if (isCapturing) {
        // Invalid SAN
        if (san[1] != 'x') {
          return null;
        }

        // Remove the source file character and the capture marker
        san = san.substring(2);
      }

      if (isPromotion) {
        // Invalid SAN
        if (san[san.length - 2] != '=') {
          return null;
        }

        final promotionCharacter = san[san.length - 1];
        promotionRole = Role.fromChar(promotionCharacter);

        // Remove the promotion string
        san = san.substring(0, san.length - 2);
      }

      // After handling captures and promotions, the
      // remaining destination square should contain
      // two characters.
      if (san.length != 2) {
        return null;
      }

      final destination = board.size.parseSquare(san);
      if (destination == null) {
        return null;
      }

      // There may be many pawns in the corresponding file
      // The corect choice will always be the pawn behind the destination square
      // that is furthest down the board
      for (var rank = 0; rank < board.size.ranks; rank++) {
        final rankFilter = SquareMapExt.fromRank(rank, board.size).complement();
        // If the square is behind or on this rank,
        // the rank it will not contain the source pawn
        if (turn == Side.white && rank >= board.size.rankOf(destination) ||
            turn == Side.black && rank <= board.size.rankOf(destination)) {
          filter = filter.intersect(rankFilter);
        }
      }

      // If the pawn rank has been overspecified, then verify the rank
      if (pawnRank != null) {
        filter = filter.intersect(SquareMapExt.fromRank(pawnRank, board.size));
      }

      final source = (turn == Side.white) ? filter.last : filter.first;

      // There are no valid candidates for the move
      if (source == null) {
        return null;
      }

      final move =
          NormalMove(from: source, to: destination, promotion: promotionRole);
      if (!isLegal(move)) {
        return null;
      }
      return move;
    }

    // The final two moves define the destination
    final destination = board.size.parseSquare(san.substring(san.length - 2));
    if (destination == null) {
      return null;
    }

    san = san.substring(0, san.length - 2);
    if (isCapturing) {
      // Invalid SAN
      if (san[san.length - 1] != 'x') {
        return null;
      }
      san = san.substring(0, san.length - 1);
    }

    // For non-pawn moves, the first character describes a role
    final role = Role.fromChar(san[0]);
    if (role == null) {
      return null;
    }
    if (role == Role.pawn) {
      return null;
    }
    san = san.substring(1);

    final colorFilter = board.bySide(turn);
    final roleFilter = board.byRole(role);
    var filter = colorFilter.intersect(roleFilter);

    // The remaining characters disambiguate the moves
    if (san.length > 2) {
      return null;
    }
    if (san.length == 2) {
      final sourceSquare = board.size.parseSquare(san);
      if (sourceSquare == null) {
        return null;
      }
      final squareFilter = SquareMapExt.fromSquare(sourceSquare);
      filter = filter.intersect(squareFilter);
    }
    if (san.length == 1) {
      final sourceCharacter = san.codeUnits[0];
      if (oneIndex <= sourceCharacter && sourceCharacter <= lastRankIndex) {
        final rank = sourceCharacter - oneIndex;
        final rankFilter = SquareMapExt.fromRank(rank, board.size);
        filter = filter.intersect(rankFilter);
      } else if (aIndex <= sourceCharacter &&
          sourceCharacter <= lastFileIndex) {
        final file = sourceCharacter - aIndex;
        final fileFilter = SquareMapExt.fromFile(file, board.size);
        filter = filter.intersect(fileFilter);
      } else {
        return null;
      }
    }

    Move? move;
    for (final square in filter.squares) {
      final candidateMove = NormalMove(from: square, to: destination);
      if (!isLegal(candidateMove)) {
        continue;
      }
      if (move == null) {
        move = candidateMove;
      } else {
        // Ambiguous notation
        return null;
      }
    }

    if (move == null) {
      return null;
    }

    return move;
  }

  /// Plays a move and returns the updated [Position].
  ///
  /// Throws a [PlayError] if the move is not legal.
  Position<T> play(Move move) {
    if (isLegal(move)) {
      return playUnchecked(move);
    } else {
      throw PlayError('Invalid move $move');
    }
  }

  /// Plays a move without checking if the move is legal
  /// and returns the updated [Position].
  Position<T> playUnchecked(Move move) {
    switch (move) {
      case NormalMove(from: final from, to: final to, promotion: final prom):
        final piece = board.pieceAt(from);
        if (piece == null) {
          return _copyWith();
        }
        final castlingSide = _getCastlingSide(move);
        final epCaptureTarget =
            to + (turn == Side.white ? -board.size.files : board.size.files);
        Square? newEpSquare;
        var newBoard = board.removePieceAt(from);
        var newCastles = castles;
        if (piece.role == Role.pawn) {
          if (to == epSquare) {
            newBoard = newBoard.removePieceAt(epCaptureTarget);
          }
          final delta = from - to;
          if (delta.abs() == board.size.files * 2 &&
              from >= board.size.files &&
              from <= (board.size.capacity - board.size.files - 1)) {
            newEpSquare = (from + to) >>> 1;
          }
        } else if (piece.role == Role.rook) {
          newCastles = newCastles.discardRookAt(from);
        } else if (piece.role == Role.king) {
          if (castlingSide != null) {
            final rookFrom = castles.rookOf(turn, castlingSide);
            if (rookFrom != null) {
              final rook = board.pieceAt(rookFrom);
              newBoard = newBoard.removePieceAt(rookFrom).setPieceAt(
                    _kingCastlesTo(turn, castlingSide, board.size),
                    piece,
                  );
              if (rook != null) {
                newBoard = newBoard.setPieceAt(
                  _rookCastlesTo(turn, castlingSide, board.size),
                  rook,
                );
              }
            }
          }
          newCastles = newCastles.discardSide(turn);
        }

        if (castlingSide == null) {
          final newPiece = prom != null
              ? piece.copyWith(role: prom, promoted: pockets != null)
              : piece;
          newBoard = newBoard.setPieceAt(to, newPiece);
        }

        final capturedPiece = castlingSide == null
            ? board.pieceAt(to)
            : to == epSquare
                ? board.pieceAt(epCaptureTarget)
                : null;
        final isCapture = capturedPiece != null;

        if (capturedPiece != null && capturedPiece.role == Role.rook) {
          newCastles = newCastles.discardRookAt(to);
        }

        return _copyWith(
          halfmoves: isCapture || piece.role == Role.pawn ? 0 : halfmoves + 1,
          fullmoves: turn == Side.black ? fullmoves + 1 : fullmoves,
          pockets: Box(
            capturedPiece != null
                ? pockets?.increment(
                    capturedPiece.color.opposite,
                    capturedPiece.promoted ? Role.pawn : capturedPiece.role,
                  )
                : pockets,
          ),
          board: newBoard,
          turn: turn.opposite,
          castles: newCastles,
          epSquare: Box(newEpSquare),
        );
      case DropMove(to: final to, role: final role):
        return _copyWith(
          halfmoves: role == Role.pawn ? 0 : halfmoves + 1,
          fullmoves: turn == Side.black ? fullmoves + 1 : fullmoves,
          turn: turn.opposite,
          board: board.setPieceAt(to, Piece(color: turn, role: role)),
          pockets: Box(pockets?.decrement(turn, role)),
        );
    }
  }

  /// Returns the SAN of this [Move] and the updated [Position],
  /// without checking if the move is legal.
  (Position<T>, String) makeSanUnchecked(Move move) {
    final san = _makeSanWithoutSuffix(move);
    final newPos = playUnchecked(move);
    final suffixed = newPos.outcome?.winner != null
        ? '$san#'
        : newPos.isCheck
            ? '$san+'
            : san;
    return (newPos, suffixed);
  }

  /// Returns the SAN of this [Move] and the updated [Position].
  ///
  /// Throws a [PlayError] if the move is not legal.
  (Position<T>, String) makeSan(Move move) {
    if (isLegal(move)) {
      return makeSanUnchecked(move);
    } else {
      throw PlayError('Invalid move $move');
    }
  }

  /// Returns the SAN of this [Move] from the current [Position].
  ///
  /// Throws a [PlayError] if the move is not legal.
  @Deprecated('Use makeSan instead')
  String toSan(Move move) {
    if (isLegal(move)) {
      return makeSanUnchecked(move).$2;
    } else {
      throw PlayError('Invalid move $move');
    }
  }

  /// Returns the SAN representation of the [Move] with the updated [Position].
  ///
  /// Throws a [PlayError] if the move is not legal.
  @Deprecated('Use makeSan instead')
  (Position<T>, String) playToSan(Move move) {
    if (isLegal(move)) {
      final san = _makeSanWithoutSuffix(move);
      final newPos = playUnchecked(move);
      final suffixed = newPos.outcome?.winner != null
          ? '$san#'
          : newPos.isCheck
              ? '$san+'
              : san;
      return (newPos, suffixed);
    } else {
      throw PlayError('Invalid move $move');
    }
  }

  /// Returns the normalized form of a [NormalMove] to avoid castling
  /// inconsistencies.
  Move normalizeMove(NormalMove move) {
    final side = _getCastlingSide(move);
    if (side == null) return move;
    final castlingRook = castles.rookOf(turn, side);
    return NormalMove(
      from: move.from,
      to: castlingRook ?? move.to,
    );
  }

  /// Checks the legality of this position.
  ///
  /// Throws a [PositionError] if it does not meet basic validity requirements.
  void validate({bool? ignoreImpossibleCheck}) {
    if (board.occupied.isEmpty) {
      throw PositionError.empty;
    }
    if (board.kings.length != 2) {
      throw PositionError.kings;
    }
    final ourKing = board.kingOf(turn);
    if (ourKing == null) {
      throw PositionError.kings;
    }
    final otherKing = board.kingOf(turn.opposite);
    if (otherKing == null) {
      throw PositionError.kings;
    }
    if (kingAttackers(otherKing, turn).isNotEmpty) {
      throw PositionError.oppositeCheck;
    }
    if (board.size.backranks.isIntersected(board.pawns)) {
      throw PositionError.pawnsOnBackrank;
    }
    final skipImpossibleCheck = ignoreImpossibleCheck ?? false;
    if (!skipImpossibleCheck) {
      _validateCheckers(ourKing);
    }
  }

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return '$T(board: $board, turn: $turn, castles: $castles, halfmoves: $halfmoves, fullmoves: $fullmoves)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Position &&
            other.board == board &&
            other.pockets == pockets &&
            other.turn == turn &&
            other.castles == castles &&
            other.epSquare == epSquare &&
            other.halfmoves == halfmoves &&
            other.fullmoves == fullmoves;
  }

  @override
  int get hashCode => Object.hash(
        board,
        pockets,
        turn,
        castles,
        epSquare,
        halfmoves,
        fullmoves,
      );

  /// Checks if checkers are legal in this position.
  ///
  /// Throws a [PositionError.impossibleCheck] if it does not meet validity
  /// requirements.
  void _validateCheckers(Square ourKing) {
    final checkers = kingAttackers(ourKing, turn.opposite);
    if (checkers.isNotEmpty) {
      if (epSquare != null) {
        // The pushed pawn must be the only checker, or it has uncovered
        // check by a single sliding piece.
        final pushedTo = epSquare! ^ board.size.files;
        final pushedFrom = epSquare! ^ (board.size.files * 3);
        if (checkers.moreThanOne ||
            (checkers.first != pushedTo &&
                board
                    .attacksTo(
                      ourKing,
                      turn.opposite,
                      occupied: board.occupied
                          .withoutSquare(pushedTo)
                          .withSquare(pushedFrom),
                    )
                    .isNotEmpty)) {
          throw PositionError.impossibleCheck;
        }
      } else {
        // Multiple sliding checkers aligned with king.
        if (checkers.length > 2 ||
            (checkers.length == 2 &&
                board.attacks
                    .ray(checkers.first!, checkers.last!)
                    .has(ourKing))) {
          throw PositionError.impossibleCheck;
        }
      }
    }
  }

  String _makeSanWithoutSuffix(Move move) {
    var san = '';
    switch (move) {
      case NormalMove(from: final from, to: final to, promotion: final prom):
        final role = board.roleAt(from);
        if (role == null) return '--';
        if (role == Role.king &&
            (board.bySide(turn).has(to) || (to - from).abs() == 2)) {
          san = to > from ? 'O-O' : 'O-O-O';
        } else {
          final capture = board.occupied.has(to) ||
              (role == Role.pawn &&
                  board.size.fileOf(from) != board.size.fileOf(to));
          if (role != Role.pawn) {
            san = role.char.toUpperCase();

            // Disambiguation
            SquareMap others;
            if (role == Role.king) {
              others = board.attacks.ofKing(to) & board.kings;
            } else if (role == Role.queen) {
              others = board.attacks.ofQueen(to, board.occupied) & board.queens;
            } else if (role == Role.rook) {
              others = board.attacks.ofRook(to, board.occupied) & board.rooks;
            } else if (role == Role.bishop) {
              others =
                  board.attacks.ofBishop(to, board.occupied) & board.bishops;
            } else {
              others = board.attacks.ofKnight(to) & board.knights;
            }
            others = others.intersect(board.bySide(turn)).withoutSquare(from);

            if (others.isNotEmpty) {
              final ctx = _makeContext();
              for (final from in others.squares) {
                if (!_legalMovesOf(from, context: ctx).has(to)) {
                  others = others.withoutSquare(from);
                }
              }
              if (others.isNotEmpty) {
                var row = false;
                var column = others.isIntersected(
                  SquareMapExt.fromRank(board.size.rankOf(from), board.size),
                );
                if (others.isIntersected(
                  SquareMapExt.fromFile(
                    board.size.fileOf(from),
                    board.size,
                  ),
                )) {
                  row = true;
                } else {
                  column = true;
                }
                if (column) {
                  san += board.size.fileIds[board.size.fileOf(from)];
                }
                if (row) {
                  san += board.size.rankIds[board.size.rankOf(from)];
                }
              }
            }
          } else if (capture) {
            san = board.size.fileIds[board.size.fileOf(from)];
          }

          if (capture) san += 'x';
          san += board.size.algebraicOf(to);
          if (prom != null) {
            san += '=${prom.char.toUpperCase()}';
          }
        }
      case DropMove(role: final role, to: final to):
        if (role != Role.pawn) san = role.char.toUpperCase();
        san += '@${board.size.algebraicOf(to)}';
    }
    return san;
  }

  /// Gets the legal moves for that [Square].
  ///
  /// Optionnaly pass a [_Context] of the position, to optimize performance when
  /// calling this method several times.
  SquareMap _legalMovesOf(Square square, {_Context? context}) {
    final ctx = context ?? _makeContext();
    if (ctx.isVariantEnd) return SquareMap.zero;
    final piece = board.pieceAt(square);
    if (piece == null || piece.color != turn) return SquareMap.zero;

    SquareMap pseudo;
    SquareMap? legalEpSquare;
    switch (piece.role) {
      case Role.pawn:
        pseudo =
            board.attacks.ofPawn(turn, square) & board.bySide(turn.opposite);
        final delta = turn == Side.white ? board.size.files : -board.size.files;
        final step = square + delta;
        if (0 <= step &&
            step < board.size.capacity &&
            !board.occupied.has(step)) {
          pseudo = pseudo.withSquare(step);
          final canDoubleStep = turn == Side.white
              ? square < board.size.files * 2
              : square >= board.size.capacity - board.size.files * 2;
          final doubleStep = step + delta;
          if (canDoubleStep && !board.occupied.has(doubleStep)) {
            pseudo = pseudo.withSquare(doubleStep);
          }
        }
        if (epSquare != null && _canCaptureEp(square)) {
          final pawn = epSquare! - delta;
          if (ctx.checkers.isEmpty || ctx.checkers.singleSquare == pawn) {
            legalEpSquare = SquareMapExt.fromSquare(epSquare!);
          }
        }
      case Role.bishop:
        pseudo = board.attacks.ofBishop(square, board.occupied);
      case Role.knight:
        pseudo = board.attacks.ofKnight(square);
      case Role.rook:
        pseudo = board.attacks.ofRook(square, board.occupied);
      case Role.queen:
        pseudo = board.attacks.ofQueen(square, board.occupied);
      case Role.king:
        pseudo = board.attacks.ofKing(square);
    }

    pseudo = pseudo.diff(board.bySide(turn));
    if (ctx.king != null) {
      if (piece.role == Role.king) {
        final occ = board.occupied.withoutSquare(square);
        for (final to in pseudo.squares) {
          if (kingAttackers(to, turn.opposite, occupied: occ).isNotEmpty) {
            pseudo = pseudo.withoutSquare(to);
          }
        }
        return pseudo
            .union(_castlingMove(CastlingSide.queen, ctx))
            .union(_castlingMove(CastlingSide.king, ctx));
      }
      if (ctx.checkers.isNotEmpty) {
        final checker = ctx.checkers.singleSquare;
        if (checker == null) return SquareMap.zero;
        pseudo = pseudo &
            board.attacks.between(checker, ctx.king!).withSquare(checker);
      }

      if (ctx.blockers.has(square)) {
        pseudo = pseudo & board.attacks.ray(square, ctx.king!);
      }
    }

    if (legalEpSquare != null) {
      pseudo = pseudo | legalEpSquare;
    }

    return pseudo;
  }

  _Context _makeContext() {
    final king = board.kingOf(turn);
    if (king == null) {
      return _Context(
        isVariantEnd: isVariantEnd,
        mustCapture: false,
        king: king,
        blockers: SquareMap.zero,
        checkers: SquareMap.zero,
      );
    }
    return _Context(
      isVariantEnd: isVariantEnd,
      mustCapture: false,
      king: king,
      blockers: _sliderBlockers(king),
      checkers: checkers,
    );
  }

  SquareMap _sliderBlockers(Square king) {
    final snipers = board.attacks
        .ofRook(king, SquareMap.zero)
        .intersect(board.rooksAndQueens)
        .union(
          board.attacks
              .ofBishop(king, SquareMap.zero)
              .intersect(board.bishopsAndQueens),
        )
        .intersect(board.bySide(turn.opposite));
    var blockers = SquareMap.zero;
    for (final sniper in snipers.squares) {
      final b = board.attacks.between(king, sniper) & board.occupied;
      if (!b.moreThanOne) blockers = blockers | b;
    }
    return blockers;
  }

  SquareMap _castlingMove(CastlingSide side, _Context context) {
    final king = context.king;
    if (king == null || context.checkers.isNotEmpty) {
      return SquareMap.zero;
    }
    final rook = castles.rookOf(turn, side);
    if (rook == null) return SquareMap.zero;
    if (castles.pathOf(turn, side).isIntersected(board.occupied)) {
      return SquareMap.zero;
    }

    final kingTo = _kingCastlesTo(turn, side, board.size);
    final kingPath = board.attacks.between(king, kingTo);
    final occ = board.occupied.withoutSquare(king);
    for (final sq in kingPath.squares) {
      if (kingAttackers(sq, turn.opposite, occupied: occ).isNotEmpty) {
        return SquareMap.zero;
      }
    }
    final rookTo = _rookCastlesTo(turn, side, board.size);
    final after = board.occupied
        .toggleSquare(king)
        .toggleSquare(rook)
        .toggleSquare(rookTo);
    if (kingAttackers(kingTo, turn.opposite, occupied: after).isNotEmpty) {
      return SquareMap.zero;
    }
    return SquareMapExt.fromSquare(rook);
  }

  bool _canCaptureEp(Square pawn) {
    if (epSquare == null) return false;
    if (!board.attacks.ofPawn(turn, pawn).has(epSquare!)) return false;
    final king = board.kingOf(turn);
    if (king == null) return true;
    final captured =
        epSquare! + (turn == Side.white ? -board.size.files : board.size.files);
    final occupied = board.occupied
        .toggleSquare(pawn)
        .toggleSquare(epSquare!)
        .toggleSquare(captured);
    return !board
        .attacksTo(king, turn.opposite, occupied: occupied)
        .isIntersected(occupied);
  }

  /// Detects if a move is a castling move.
  ///
  /// Returns the [CastlingSide] or `null` if the move is a drop move.
  CastlingSide? _getCastlingSide(Move move) {
    if (move case NormalMove(from: final from, to: final to)) {
      final delta = to - from;
      if (delta.abs() != 2 && !board.bySide(turn).has(to)) {
        return null;
      }
      if (!board.kings.has(from)) {
        return null;
      }
      return delta > 0 ? CastlingSide.king : CastlingSide.queen;
    }
    return null;
  }

  Square? _legalEpSquare() {
    if (epSquare == null) return null;
    final ourPawns = board.piecesOf(turn, Role.pawn);
    final candidates =
        ourPawns & board.attacks.ofPawn(turn.opposite, epSquare!);
    for (final candidate in candidates.squares) {
      if (_legalMovesOf(candidate).has(epSquare!)) {
        return epSquare;
      }
    }
    return null;
  }

  /// Gets all the legal moves of this position in the algebraic coordinate
  /// notation.
  ///
  /// Includes both possible representations of castling moves
  /// (unless `chess960` is true).
  IMap<String, ISet<String>> algebraicLegalMoves({
    bool isChess960 = false,
  }) {
    final result = <String, ISet<String>>{};
    for (final entry in legalMoves.entries) {
      final dests = entry.value.squares;
      if (dests.isNotEmpty) {
        final from = entry.key;
        final destSet = dests.map(board.size.algebraicOf).toSet();
        if (!isChess960 &&
            from == board.kingOf(turn) &&
            board.size.fileOf(entry.key) == 4) {
          if (dests.contains(0)) {
            // c1 in standard chess
            destSet.add(board.size.algebraicOf(2));
          } else if (dests.contains(56)) {
            // c8 in standard chess
            destSet.add(
              board.size.algebraicOf(
                board.size.capacity - board.size.files + 2,
              ),
            );
          }
          if (dests.contains(board.size.files - 1)) {
            // g1 in standard chess
            destSet.add(board.size.algebraicOf(board.size.files - 2));
          } else if (dests.contains(63)) {
            // g8 in standard chess
            destSet.add(board.size.algebraicOf(board.size.capacity - 2));
          }
        }
        result[board.size.algebraicOf(from)] = ISet(destSet);
      }
    }
    return IMap(result);
  }
}

/// A standard chess position.
@immutable
class Chess extends Position<Chess> {
  /// A standard chess position.
  const Chess({
    required super.board,
    required super.turn,
    required super.castles,
    required super.halfmoves,
    required super.fullmoves,
    super.pockets,
    super.epSquare,
  });

  Chess._fromSetupUnchecked(super.setup) : super._fromSetupUnchecked();
  Chess._initial() : super._initial();

  /// Set up a playable [Chess] position.
  ///
  /// Throws a [PositionError] if the [Setup] does not meet basic validity
  /// requirements.
  /// Optionnaly pass a `ignoreImpossibleCheck` boolean if you want to skip that
  /// requirement.
  factory Chess.fromSetup(Setup setup, {bool? ignoreImpossibleCheck}) {
    final pos = Chess._fromSetupUnchecked(setup)
      ..validate(ignoreImpossibleCheck: ignoreImpossibleCheck);
    return pos;
  }
  @override
  Rule get rule => Rule.chess;

  /// The initial position of standard chess
  static final initial = Chess._initial();

  @override
  bool get isVariantEnd => false;

  @override
  Outcome? get variantOutcome => null;

  @override
  Chess _copyWith({
    Board? board,
    Box<Pockets?>? pockets,
    Side? turn,
    Castles? castles,
    Box<Square?>? epSquare,
    int? halfmoves,
    int? fullmoves,
  }) {
    return Chess(
      board: board ?? this.board,
      pockets: pockets != null ? pockets.value : this.pockets,
      turn: turn ?? this.turn,
      castles: castles ?? this.castles,
      epSquare: epSquare != null ? epSquare.value : this.epSquare,
      halfmoves: halfmoves ?? this.halfmoves,
      fullmoves: fullmoves ?? this.fullmoves,
    );
  }
}

/// A variant of chess where you lose all your pieces or get stalemated to win.
@immutable
class Antichess extends Position<Antichess> {
  /// A variant of chess where you lose all your pieces or get stalemated to
  /// win.
  const Antichess({
    required super.board,
    required super.turn,
    required super.castles,
    required super.halfmoves,
    required super.fullmoves,
    super.pockets,
    super.epSquare,
  });

  Antichess._fromSetupUnchecked(super.setup) : super._fromSetupUnchecked();

  /// Set up a playable [Antichess] position.
  ///
  /// Throws a [PositionError] if the [Setup] does not meet basic validity
  /// requirements.
  /// Optionnaly pass a `ignoreImpossibleCheck` boolean if you want to skip that
  /// requirement.
  factory Antichess.fromSetup(Setup setup, {bool? ignoreImpossibleCheck}) {
    final pos = Antichess._fromSetupUnchecked(setup);
    final noCastles = pos._copyWith(castles: Castles.empty(setup.board.size))
      ..validate(ignoreImpossibleCheck: ignoreImpossibleCheck);
    return noCastles;
  }
  @override
  Rule get rule => Rule.antichess;

  /// The initial position of standard antichess
  static final initial = Antichess(
    board: Board.standard,
    turn: Side.white,
    castles: Castles.empty(Board.standard.size),
    halfmoves: 0,
    fullmoves: 1,
  );

  @override
  bool get isVariantEnd => board.bySide(turn).isEmpty;

  @override
  Outcome? get variantOutcome {
    if (isVariantEnd || isStalemate) {
      return Outcome(winner: turn);
    }
    return null;
  }

  @override
  void validate({bool? ignoreImpossibleCheck}) {
    if (board.occupied.isEmpty) {
      throw PositionError.empty;
    }
    if (board.size.backranks.isIntersected(board.pawns)) {
      throw PositionError.pawnsOnBackrank;
    }
  }

  @override
  SquareMap kingAttackers(Square square, Side attacker, {SquareMap? occupied}) {
    return SquareMap.zero;
  }

  @override
  _Context _makeContext() {
    final ctx = super._makeContext();
    if (epSquare != null &&
        board.attacks
            .ofPawn(turn.opposite, epSquare!)
            .isIntersected(board.piecesOf(turn, Role.pawn))) {
      return ctx.copyWith(mustCapture: true);
    }
    final enemy = board.bySide(turn.opposite);
    for (final from in board.bySide(turn).squares) {
      if (_pseudoLegalMoves(this, from, ctx).isIntersected(enemy)) {
        return ctx.copyWith(mustCapture: true);
      }
    }
    return ctx;
  }

  @override
  SquareMap _legalMovesOf(Square square, {_Context? context}) {
    final ctx = context ?? _makeContext();
    final dests = _pseudoLegalMoves(this, square, ctx);
    final enemy = board.bySide(turn.opposite);
    return dests &
        (ctx.mustCapture
            ? epSquare != null && board.roleAt(square) == Role.pawn
                ? enemy.withSquare(epSquare!)
                : enemy
            : board.size.full);
  }

  @override
  bool hasInsufficientMaterial(Side side) {
    if (board.bySide(side).isEmpty) return false;
    if (board.bySide(side.opposite).isEmpty) return true;
    if (board.occupied == board.bishops) {
      final weSomeOnLight =
          board.bySide(side).isIntersected(board.size.lightSquares);
      final weSomeOnDark =
          board.bySide(side).isIntersected(board.size.darkSquares);
      final theyAllOnDark =
          board.bySide(side.opposite).isDisjoint(board.size.lightSquares);
      final theyAllOnLight =
          board.bySide(side.opposite).isDisjoint(board.size.darkSquares);
      return (weSomeOnLight && theyAllOnDark) ||
          (weSomeOnDark && theyAllOnLight);
    }
    if (board.occupied == board.knights && board.occupied.length == 2) {
      return (board.white.isIntersected(board.size.lightSquares) !=
              board.black.isIntersected(board.size.darkSquares)) !=
          (turn == side);
    }
    return false;
  }

  @override
  Antichess _copyWith({
    Board? board,
    Box<Pockets?>? pockets,
    Side? turn,
    Castles? castles,
    Box<Square?>? epSquare,
    int? halfmoves,
    int? fullmoves,
  }) {
    return Antichess(
      board: board ?? this.board,
      pockets: pockets != null ? pockets.value : this.pockets,
      turn: turn ?? this.turn,
      castles: castles ?? this.castles,
      epSquare: epSquare != null ? epSquare.value : this.epSquare,
      halfmoves: halfmoves ?? this.halfmoves,
      fullmoves: fullmoves ?? this.fullmoves,
    );
  }
}

/// A variant of chess where captures cause an explosion to the surrounding
/// pieces.
@immutable
class Atomic extends Position<Atomic> {
  /// A variant of chess where captures cause an explosion to the surrounding
  /// pieces.
  const Atomic({
    required super.board,
    required super.turn,
    required super.castles,
    required super.halfmoves,
    required super.fullmoves,
    super.pockets,
    super.epSquare,
  });

  Atomic._fromSetupUnchecked(super.setup) : super._fromSetupUnchecked();
  Atomic._initial() : super._initial();

  /// Set up a playable [Atomic] position.
  ///
  /// Throws a [PositionError] if the [Setup] does not meet basic validity
  /// requirements.
  /// Optionnaly pass a `ignoreImpossibleCheck` boolean if you want to skip that
  /// requirement.
  factory Atomic.fromSetup(Setup setup, {bool? ignoreImpossibleCheck}) {
    final pos = Atomic._fromSetupUnchecked(setup)
      ..validate(ignoreImpossibleCheck: ignoreImpossibleCheck);
    return pos;
  }
  @override
  Rule get rule => Rule.atomic;

  /// The initial position of standard atomic chess
  static final initial = Atomic._initial();

  @override
  bool get isVariantEnd => variantOutcome != null;

  @override
  Outcome? get variantOutcome {
    for (final color in Side.values) {
      if (board.piecesOf(color, Role.king).isEmpty) {
        return Outcome(winner: color.opposite);
      }
    }
    return null;
  }

  /// Attacks that a king on `square` would have to deal with.
  ///
  /// Contrary to chess, in Atomic kings can attack each other, without causing
  /// check.
  @override
  SquareMap kingAttackers(Square square, Side attacker, {SquareMap? occupied}) {
    final attackerKings = board.piecesOf(attacker, Role.king);
    if (attackerKings.isEmpty ||
        board.attacks.ofKing(square).isIntersected(attackerKings)) {
      return SquareMap.zero;
    }
    return super.kingAttackers(square, attacker, occupied: occupied);
  }

  /// Checks the legality of this position.
  ///
  /// Validation is like chess, but it allows our king to be missing.
  /// Throws a [PositionError] if it does not meet basic validity requirements.
  @override
  void validate({bool? ignoreImpossibleCheck}) {
    if (board.occupied.isEmpty) {
      throw PositionError.empty;
    }
    if (board.kings.length > 2) {
      throw PositionError.kings;
    }
    final otherKing = board.kingOf(turn.opposite);
    if (otherKing == null) {
      throw PositionError.kings;
    }
    if (kingAttackers(otherKing, turn).isNotEmpty) {
      throw PositionError.oppositeCheck;
    }
    if (board.size.backranks.isIntersected(board.pawns)) {
      throw PositionError.pawnsOnBackrank;
    }
    final skipImpossibleCheck = ignoreImpossibleCheck ?? false;
    final ourKing = board.kingOf(turn);
    if (!skipImpossibleCheck && ourKing != null) {
      _validateCheckers(ourKing);
    }
  }

  @override
  void _validateCheckers(Square ourKing) {
    // Other king moving away can cause many checks to be given at the
    // same time. Not checking details or even that the king is close enough.
    if (epSquare == null) {
      super._validateCheckers(ourKing);
    }
  }

  /// Plays a move without checking if the move is legal.
  ///
  /// In addition to standard rules, all captures cause an explosion by which
  /// the captured piece, the piece used to capture, and all surrounding pieces
  /// except pawns that are within a one square radius are removed from the
  /// board.
  @override
  Atomic playUnchecked(Move move) {
    final castlingSide = _getCastlingSide(move);
    final capturedPiece = castlingSide == null ? board.pieceAt(move.to) : null;
    final isCapture = capturedPiece != null || move.to == epSquare;
    final newPos = super.playUnchecked(move) as Atomic;

    if (isCapture) {
      var newCastles = newPos.castles;
      var newBoard = newPos.board.removePieceAt(move.to);
      for (final explode in board.attacks
          .ofKing(move.to)
          .intersect(newBoard.occupied)
          .diff(newBoard.pawns)
          .squares) {
        final piece = newBoard.pieceAt(explode);
        newBoard = newBoard.removePieceAt(explode);
        if (piece != null) {
          if (piece.role == Role.rook) {
            newCastles = newCastles.discardRookAt(explode);
          }
          if (piece.role == Role.king) {
            newCastles = newCastles.discardSide(piece.color);
          }
        }
      }
      return newPos._copyWith(board: newBoard, castles: newCastles);
    } else {
      return newPos;
    }
  }

  /// Tests if a [Side] has insufficient winning material.
  @override
  bool hasInsufficientMaterial(Side side) {
    // Remaining material does not matter if the enemy king is already
    // exploded.
    if (board.piecesOf(side.opposite, Role.king).isEmpty) return false;

    // Bare king cannot mate.
    if (board.bySide(side).diff(board.kings).isEmpty) return true;

    // As long as the enemy king is not alone, there is always a chance their
    // own pieces explode next to it.
    if (board.bySide(side.opposite).diff(board.kings).isNotEmpty) {
      // Unless there are only bishops that cannot explode each other.
      if (board.occupied == board.bishops | board.kings) {
        if (!(board.bishops & board.white)
            .isIntersected(board.size.darkSquares)) {
          return !(board.bishops & board.black)
              .isIntersected(board.size.lightSquares);
        }
        if (!(board.bishops & board.white)
            .isIntersected(board.size.lightSquares)) {
          return !(board.bishops & board.black)
              .isIntersected(board.size.darkSquares);
        }
      }
      return false;
    }

    // Queen or pawn (future queen) can give mate against bare king.
    if (board.queens.isNotEmpty || board.pawns.isNotEmpty) return false;

    // Single knight, bishop or rook cannot mate against bare king.
    if ((board.knights | board.bishops | board.rooks).length == 1) {
      return true;
    }

    // If only knights, more than two are required to mate bare king.
    if (board.occupied == board.knights | board.kings) {
      return board.knights.length <= 2;
    }

    return false;
  }

  @override
  SquareMap _legalMovesOf(Square square, {_Context? context}) {
    var moves = SquareMap.zero;
    final ctx = context ?? _makeContext();
    for (final to in _pseudoLegalMoves(this, square, ctx).squares) {
      final after = playUnchecked(NormalMove(from: square, to: to));
      final ourKing = after.board.kingOf(turn);
      if (ourKing != null &&
          (after.board.kingOf(after.turn) == null ||
              after.kingAttackers(ourKing, after.turn).isEmpty)) {
        moves = moves.withSquare(to);
      }
    }
    return moves;
  }

  @override
  Atomic _copyWith({
    Board? board,
    Box<Pockets?>? pockets,
    Side? turn,
    Castles? castles,
    Box<Square?>? epSquare,
    int? halfmoves,
    int? fullmoves,
  }) {
    return Atomic(
      board: board ?? this.board,
      pockets: pockets != null ? pockets.value : this.pockets,
      turn: turn ?? this.turn,
      castles: castles ?? this.castles,
      epSquare: epSquare != null ? epSquare.value : this.epSquare,
      halfmoves: halfmoves ?? this.halfmoves,
      fullmoves: fullmoves ?? this.fullmoves,
    );
  }
}

/// A variant where captured pieces can be dropped back on the board instead
/// of moving a piece.
@immutable
class Crazyhouse extends Position<Crazyhouse> {
  /// A variant where captured pieces can be dropped back on the board instead
  /// of moving a piece.
  const Crazyhouse({
    required super.board,
    required super.turn,
    required super.castles,
    required super.halfmoves,
    required super.fullmoves,
    super.pockets,
    super.epSquare,
  });

  Crazyhouse._fromSetupUnchecked(super.setup) : super._fromSetupUnchecked();

  /// Set up a playable [Crazyhouse] position.
  ///
  /// Throws a [PositionError] if the [Setup] does not meet basic validity
  /// requirements.
  /// Optionnaly pass a `ignoreImpossibleCheck` boolean if you want to skip that
  /// requirement.
  factory Crazyhouse.fromSetup(Setup setup, {bool? ignoreImpossibleCheck}) {
    final pos = Crazyhouse._fromSetupUnchecked(setup)._copyWith(
      pockets: Box(setup.pockets ?? Pockets.empty),
      board: setup.board.withPromoted(
        setup.board.promoted
            .intersect(setup.board.occupied)
            .diff(setup.board.kings)
            .diff(setup.board.pawns),
      ),
    )..validate(ignoreImpossibleCheck: ignoreImpossibleCheck);
    return pos;
  }
  @override
  Rule get rule => Rule.crazyhouse;

  /// The initial position of standard crazyhouse chess
  static final initial = Crazyhouse(
    board: Board.standard,
    pockets: Pockets.empty,
    turn: Side.white,
    castles: Castles.standard,
    halfmoves: 0,
    fullmoves: 1,
  );

  @override
  bool get isVariantEnd => false;

  @override
  Outcome? get variantOutcome => null;

  @override
  void validate({bool? ignoreImpossibleCheck}) {
    super.validate(ignoreImpossibleCheck: ignoreImpossibleCheck);
    if (pockets == null) {
      throw PositionError.variant;
    } else {
      if (pockets!.count(Role.king) > 0) {
        throw PositionError.kings;
      }
      if (pockets!.size + board.occupied.length > board.size.capacity) {
        throw PositionError.variant;
      }
    }
  }

  @override
  bool hasInsufficientMaterial(Side side) {
    if (pockets == null) {
      return super.hasInsufficientMaterial(side);
    }
    return board.occupied.length + pockets!.size <= 3 &&
        board.pawns.isEmpty &&
        board.promoted.isEmpty &&
        board.rooksAndQueens.isEmpty &&
        pockets!.count(Role.pawn) <= 0 &&
        pockets!.count(Role.rook) <= 0 &&
        pockets!.count(Role.queen) <= 0;
  }

  @override
  SquareMap get legalDrops {
    final mask = board.occupied.complement().intersect(
          pockets != null && pockets!.hasQuality(turn)
              ? board.size.full
              : pockets != null && pockets!.hasPawn(turn)
                  ? board.size.backranks.complement()
                  : SquareMap.zero,
        );

    final ctx = _makeContext();
    if (ctx.king != null && ctx.checkers.isNotEmpty) {
      final checker = ctx.checkers.singleSquare;
      if (checker == null) {
        return SquareMap.zero;
      } else {
        return mask & board.attacks.between(checker, ctx.king!);
      }
    } else {
      return mask;
    }
  }

  @override
  Crazyhouse _copyWith({
    Board? board,
    Box<Pockets?>? pockets,
    Side? turn,
    Castles? castles,
    Box<Square?>? epSquare,
    int? halfmoves,
    int? fullmoves,
  }) {
    return Crazyhouse(
      board: board ?? this.board,
      pockets: pockets != null ? pockets.value : this.pockets,
      turn: turn ?? this.turn,
      castles: castles ?? this.castles,
      epSquare: epSquare != null ? epSquare.value : this.epSquare,
      halfmoves: halfmoves ?? this.halfmoves,
      fullmoves: fullmoves ?? this.fullmoves,
    );
  }
}

/// A variant similar to standard chess, where you win by putting your king on
/// the center of the board.
@immutable
class KingOfTheHill extends Position<KingOfTheHill> {
  /// A variant similar to standard chess, where you win by putting your king on
  /// the center of the board.
  const KingOfTheHill({
    required super.board,
    required super.turn,
    required super.castles,
    required super.halfmoves,
    required super.fullmoves,
    super.pockets,
    super.epSquare,
  });

  KingOfTheHill._fromSetupUnchecked(super.setup) : super._fromSetupUnchecked();
  KingOfTheHill._initial() : super._initial();

  /// Set up a playable [KingOfTheHill] position.
  ///
  /// Throws a [PositionError] if the [Setup] does not meet basic validity
  /// requirements.
  /// Optionnaly pass a `ignoreImpossibleCheck` boolean if you want to skip that
  /// requirement.
  factory KingOfTheHill.fromSetup(Setup setup, {bool? ignoreImpossibleCheck}) {
    final pos = KingOfTheHill._fromSetupUnchecked(setup)
      ..validate(ignoreImpossibleCheck: ignoreImpossibleCheck);
    return pos;
  }
  @override
  Rule get rule => Rule.kingofthehill;

  /// The initial position of standard KOTH
  static final initial = KingOfTheHill._initial();

  @override
  bool get isVariantEnd => board.kings.isIntersected(board.size.center);

  @override
  Outcome? get variantOutcome {
    for (final color in Side.values) {
      if (board.piecesOf(color, Role.king).isIntersected(board.size.center)) {
        return Outcome(winner: color);
      }
    }
    return null;
  }

  @override
  bool hasInsufficientMaterial(Side side) => false;

  @override
  KingOfTheHill _copyWith({
    Board? board,
    Box<Pockets?>? pockets,
    Side? turn,
    Castles? castles,
    Box<Square?>? epSquare,
    int? halfmoves,
    int? fullmoves,
  }) {
    return KingOfTheHill(
      board: board ?? this.board,
      pockets: pockets != null ? pockets.value : this.pockets,
      turn: turn ?? this.turn,
      castles: castles ?? this.castles,
      epSquare: epSquare != null ? epSquare.value : this.epSquare,
      halfmoves: halfmoves ?? this.halfmoves,
      fullmoves: fullmoves ?? this.fullmoves,
    );
  }
}

/// A variant similar to standard chess, where you can win if you put your
/// opponent king into the third check.
@immutable
class ThreeCheck extends Position<ThreeCheck> {
  /// A variant similar to standard chess, where you can win if you put your
  /// opponent king into the third check.
  const ThreeCheck({
    required super.board,
    required super.turn,
    required super.castles,
    required super.halfmoves,
    required super.fullmoves,
    required this.remainingChecks,
    super.pockets,
    super.epSquare,
  });

  ThreeCheck._initial()
      : remainingChecks = _defaultRemainingChecks,
        super._initial();

  /// Set up a playable [ThreeCheck] position.
  ///
  /// Throws a [PositionError] if the [Setup] does not meet basic validity
  /// requirements.
  /// Optionnaly pass a `ignoreImpossibleCheck` boolean if you want to skip that
  /// requirement.
  factory ThreeCheck.fromSetup(Setup setup, {bool? ignoreImpossibleCheck}) {
    if (setup.remainingChecks == null) {
      throw PositionError.variant;
    } else {
      final pos = ThreeCheck(
        board: setup.board,
        turn: setup.turn,
        castles: Castles.fromSetup(setup),
        epSquare: _validEpSquare(setup),
        halfmoves: setup.halfmoves,
        fullmoves: setup.fullmoves,
        remainingChecks: setup.remainingChecks!,
      )..validate(ignoreImpossibleCheck: ignoreImpossibleCheck);
      return pos;
    }
  }
  @override
  Rule get rule => Rule.threecheck;

  /// Number of remainingChecks for white (`item1`) and black (`item2`).
  final (int, int) remainingChecks;

  /// The initial position of standard threecheck chess
  static final initial = ThreeCheck._initial();

  static const _defaultRemainingChecks = (3, 3);

  @override
  bool get isVariantEnd => remainingChecks.$1 <= 0 || remainingChecks.$2 <= 0;

  @override
  Outcome? get variantOutcome {
    final (white, black) = remainingChecks;
    if (white <= 0) {
      return Outcome.whiteWins;
    }
    if (black <= 0) {
      return Outcome.blackWins;
    }
    return null;
  }

  @override
  String get fen {
    return Setup(
      board: board,
      turn: turn,
      unmovedRooks: castles.unmovedRooks,
      epSquare: _legalEpSquare(),
      halfmoves: halfmoves,
      fullmoves: fullmoves,
      remainingChecks: remainingChecks,
    ).fen;
  }

  @override
  bool hasInsufficientMaterial(Side side) =>
      board.piecesOf(side, Role.king) == board.bySide(side);

  @override
  ThreeCheck playUnchecked(Move move) {
    final newPos = super.playUnchecked(move) as ThreeCheck;
    if (newPos.isCheck) {
      final (whiteChecks, blackChecks) = remainingChecks;
      return newPos._copyWith(
        remainingChecks: turn == Side.white
            ? (math.max(whiteChecks - 1, 0), blackChecks)
            : (whiteChecks, math.max(blackChecks - 1, 0)),
      );
    } else {
      return newPos;
    }
  }

  @override
  ThreeCheck _copyWith({
    Board? board,
    Box<Pockets?>? pockets,
    Side? turn,
    Castles? castles,
    Box<Square?>? epSquare,
    int? halfmoves,
    int? fullmoves,
    (int, int)? remainingChecks,
  }) {
    return ThreeCheck(
      board: board ?? this.board,
      pockets: pockets != null ? pockets.value : this.pockets,
      turn: turn ?? this.turn,
      castles: castles ?? this.castles,
      epSquare: epSquare != null ? epSquare.value : this.epSquare,
      halfmoves: halfmoves ?? this.halfmoves,
      fullmoves: fullmoves ?? this.fullmoves,
      remainingChecks: remainingChecks ?? this.remainingChecks,
    );
  }
}

/// A variant where the goal is to put your king on the eigth rank
@immutable
class RacingKings extends Position<RacingKings> {
  /// A variant where the goal is to put your king on the eigth rank
  const RacingKings({
    required super.board,
    required super.turn,
    required super.castles,
    required super.halfmoves,
    required super.fullmoves,
    super.pockets,
    super.epSquare,
  });

  RacingKings._initial()
      : super(
          board: Board.standardRacingKings,
          pockets: null,
          turn: Side.white,
          castles: Castles.empty(Board.standardRacingKings.size),
          epSquare: null,
          halfmoves: 0,
          fullmoves: 1,
        );

  /// Set up a playable [RacingKings] position.
  ///
  /// Throws a [PositionError] if the [Setup] does not meet basic validity
  /// requirements.
  /// Optionnaly pass a `ignoreImpossibleCheck` boolean if you want to skip that
  /// requirement.
  factory RacingKings.fromSetup(Setup setup, {bool? ignoreImpossibleCheck}) {
    final pos = RacingKings(
      board: setup.board,
      turn: setup.turn,
      castles: Castles.empty(setup.board.size),
      halfmoves: setup.halfmoves,
      fullmoves: setup.fullmoves,
    )..validate(ignoreImpossibleCheck: ignoreImpossibleCheck);
    return pos;
  }
  @override
  Rule get rule => Rule.racingKings;

  /// The initial position of standard racing kings.
  static final initial = RacingKings._initial();

  /// The king's squares to reach to win the game.
  SquareMap get goal => board.size.lastRank;

  /// Return true if black king is a move away from his goal.
  bool get blackCanReachGoal {
    final blackKing = board.kingOf(Side.black);
    return blackKing != null &&
        board.attacks.ofKing(blackKing).intersect(goal).squares.where((square) {
          // Check whether this king move is legal
          final context = _Context(
            isVariantEnd: false,
            mustCapture: false,
            king: blackKing,
            blockers: _sliderBlockers(blackKing),
            checkers: checkers,
          );
          final legalMoves = _legalMovesOf(blackKing, context: context);
          return legalMoves.has(square);
        }).isNotEmpty;
  }

  /// Return true if black king reached his goal.
  bool get blackInGoal =>
      board.black.intersect(goal).intersect(board.kings).isNotEmpty;

  /// Return true if white king reached his goal.
  bool get whiteInGoal =>
      board.white.intersect(goal).intersect(board.kings).isNotEmpty;

  @override
  SquareMap _legalMovesOf(Square square, {_Context? context}) =>
      SquareMapExt.fromSquares(
        super._legalMovesOf(square, context: context).squares.where(
              (to) => !playUnchecked(NormalMove(from: square, to: to)).isCheck,
            ),
      );

  @override
  bool isLegal(Move move) =>
      !playUnchecked(move).isCheck && super.isLegal(move);

  @override
  bool get isVariantEnd {
    if (!whiteInGoal && !blackInGoal) {
      return false;
    }
    if (blackInGoal || !blackCanReachGoal) {
      return true;
    }
    return false;
  }

  @override
  Outcome? get variantOutcome {
    if (!isVariantEnd) return null;
    if (whiteInGoal && blackInGoal) return Outcome.draw;
    // If white is in the goal, check whether
    // black can reach the goal. If not, then
    // white wins
    if (whiteInGoal && !blackCanReachGoal) return Outcome.whiteWins;
    // If black is the only side in the goal
    // then black wins
    if (blackInGoal) return Outcome.blackWins;

    return Outcome.draw;
  }

  @override
  bool hasInsufficientMaterial(Side side) => false;

  @override
  RacingKings playUnchecked(Move move) =>
      super.playUnchecked(move) as RacingKings;

  @override
  RacingKings _copyWith({
    Board? board,
    Box<Pockets?>? pockets,
    Side? turn,
    Castles? castles,
    Box<Square?>? epSquare,
    int? halfmoves,
    int? fullmoves,
  }) {
    return RacingKings(
      board: board ?? this.board,
      turn: turn ?? this.turn,
      castles: Castles.empty((board ?? this.board).size),
      halfmoves: halfmoves ?? this.halfmoves,
      fullmoves: fullmoves ?? this.fullmoves,
    );
  }
}

/// A variant where the black goal is to eat all the white pawns, and the
/// white goal is to checkmate black
@immutable
class Horde extends Position<Horde> {
  /// A variant where the black goal is to eat all the white pawns, and the
  /// white goal is to checkmate black
  const Horde({
    required super.board,
    required super.turn,
    required super.castles,
    required super.halfmoves,
    required super.fullmoves,
    super.pockets,
    super.epSquare,
  });

  Horde._initial()
      : super(
          board: Board.standardHorde,
          pockets: null,
          turn: Side.white,
          castles: Castles.horde,
          epSquare: null,
          halfmoves: 0,
          fullmoves: 1,
        );

  /// Set up a playable [RacingKings] position.
  ///
  /// Throws a [PositionError] if the [Setup] does not meet basic validity
  /// requirements. Optionnaly pass a ignoreImpossibleCheck boolean if you want
  /// to skip that requirement.
  factory Horde.fromSetup(Setup setup, {bool? ignoreImpossibleCheck}) {
    final pos = Horde(
      board: setup.board,
      turn: setup.turn,
      castles: Castles.fromSetup(setup),
      epSquare: _validEpSquare(setup),
      halfmoves: setup.halfmoves,
      fullmoves: setup.fullmoves,
    )..validate(ignoreImpossibleCheck: ignoreImpossibleCheck);
    return pos;
  }
  @override
  Rule get rule => Rule.horde;

  /// The initial position of standard horde chess.
  static final initial = Horde._initial();

  @override
  void validate({bool? ignoreImpossibleCheck}) {
    if (board.occupied.isEmpty) {
      throw PositionError.empty;
    }

    if (board.kings.length != 1) {
      throw PositionError.kings;
    }

    final otherKing = board.kingOf(turn.opposite);
    if (otherKing != null && kingAttackers(otherKing, turn).isNotEmpty) {
      throw PositionError.oppositeCheck;
    }

    // white can have pawns on back rank
    if (board.size.backranks
        .isIntersected(board.black.intersect(board.pawns))) {
      throw PositionError.pawnsOnBackrank;
    }

    final skipImpossibleCheck = ignoreImpossibleCheck ?? false;
    final ourKing = board.kingOf(turn);
    if (!skipImpossibleCheck && ourKing != null) {
      _validateCheckers(ourKing);
    }
  }

  // get the number of light or dark square bishops
  int _hordeBishops(Side side, SquareColor sqColor) {
    if (sqColor == SquareColor.light) {
      return board
          .piecesOf(side, Role.bishop)
          .intersect(board.size.lightSquares)
          .length;
    }
    // dark squares
    return board
        .piecesOf(side, Role.bishop)
        .intersect(board.size.darkSquares)
        .length;
  }

  SquareColor _hordeBishopColor(Side side) {
    if (_hordeBishops(side, SquareColor.light) >= 1) {
      return SquareColor.light;
    }
    return SquareColor.dark;
  }

  bool _hasBishopPair(Side side) {
    final bishops = board.piecesOf(side, Role.bishop);
    return bishops.isIntersected(board.size.darkSquares) &&
        bishops.isIntersected(board.size.lightSquares);
  }

  int _pieceOfRoleNot(int piecesNum, int rolePieces) => piecesNum - rolePieces;

  @override
  bool hasInsufficientMaterial(Side side) {
    // side with king can always win by capturing the horde
    if (board.piecesOf(side, Role.king).isNotEmpty) {
      return false;
    }

    // now color represents horde and color.opposite is pieces
    final hordeNum = board.piecesOf(side, Role.pawn).length +
        board.piecesOf(side, Role.rook).length +
        board.piecesOf(side, Role.queen).length +
        board.piecesOf(side, Role.knight).length +
        math.min(_hordeBishops(side, SquareColor.light), 2) +
        math.min(_hordeBishops(side, SquareColor.dark), 2);

    if (hordeNum == 0) {
      return true;
    }

    if (hordeNum >= 4) {
      // 4 or more pieces can always deliver mate.
      return false;
    }

    final hordeMap = board.materialCount(side);
    final hordeBishopColor = _hordeBishopColor(side);
    final piecesMap = board.materialCount(side.opposite);
    final piecesNum = board.bySide(side.opposite).length;

    if ((hordeMap[Role.pawn]! >= 1 || hordeMap[Role.queen]! >= 1) &&
        hordeNum >= 2) {
      // Pawns/queens are never insufficient material when paired with any other
      // piece (a pawn promotes to a queen and delivers mate).
      return false;
    }

    if (hordeMap[Role.rook]! >= 1 && hordeNum >= 2) {
      // A rook is insufficient material only when it is paired with a bishop
      // against a lone king. The horde can mate in any other case.
      // A rook on A1 and a bishop on C3 mate a king on B1 when there is a
      // friendly pawn/opposite-color-bishop/rook/queen on C2.
      // A rook on B8 and a bishop C3 mate a king on A1 when there is a friendly
      // knight on A2.
      return hordeNum == 2 &&
          hordeMap[Role.rook]! == 1 &&
          hordeMap[Role.bishop]! == 1 &&
          (_pieceOfRoleNot(
                piecesNum,
                _hordeBishops(side.opposite, hordeBishopColor),
              ) ==
              1);
    }

    if (hordeNum == 1) {
      if (piecesNum == 1) {
        // lone piece cannot mate a lone king
        return true;
      } else if (hordeMap[Role.queen] == 1) {
        // The horde has a lone queen.
        // A lone queen mates a king on A1 bounded by:
        //  -- a pawn/rook on A2
        //  -- two same color bishops on A2, B1
        // We ignore every other mating case, since it can be reduced to
        // the two previous cases (e.g. a black pawn on A2 and a black
        // bishop on B1).

        return !(piecesMap[Role.pawn]! >= 1 ||
            piecesMap[Role.rook]! >= 1 ||
            _hordeBishops(side.opposite, SquareColor.light) >= 2 ||
            _hordeBishops(side, SquareColor.dark) >= 2);
      } else if (hordeMap[Role.pawn] == 1) {
        // Promote the pawn to a queen or a knight and check whether white can
        // mate.
        final pawnSquare = board.piecesOf(side, Role.pawn).last;

        final promoteToQueen = _copyWith();
        promoteToQueen.board
            .setPieceAt(pawnSquare!, Piece(color: side, role: Role.queen));
        final promoteToKnight = _copyWith();
        promoteToKnight.board
            .setPieceAt(pawnSquare, Piece(color: side, role: Role.knight));
        return promoteToQueen.hasInsufficientMaterial(side) &&
            promoteToKnight.hasInsufficientMaterial(side);
      } else if (hordeMap[Role.rook] == 1) {
        // A lone rook mates a king on A8 bounded by a pawn/rook on A7 and a
        // pawn/knight on B7. We ignore every other case, since it can be
        // reduced to the two previous cases.
        // (e.g. three pawns on A7, B7, C7)

        return !(piecesMap[Role.pawn]! >= 2 ||
            (piecesMap[Role.rook]! >= 1 && piecesMap[Role.pawn]! >= 1) ||
            (piecesMap[Role.rook]! >= 1 && piecesMap[Role.knight]! >= 1) ||
            (piecesMap[Role.pawn]! >= 1 && piecesMap[Role.knight]! >= 1));
      } else if (hordeMap[Role.bishop] == 1) {
        // horde has a lone bishop
        // The king can be mated on A1 if there is a pawn/opposite-color-bishop
        // on A2 and an opposite-color-bishop on B1.
        // If black has two or more pawns, white gets the benefit of the doubt;
        // there is an outside chance that white promotes its pawns to
        // opposite-color-bishops and selfmates theirself.
        // Every other case that the king is mated by the bishop requires that
        // black has two pawns or two opposite-color-bishop or a pawn and an
        // opposite-color-bishop.
        // For example a king on A3 can be mated if there is
        // a pawn/opposite-color-bishop on A4, a pawn/opposite-color-bishop on
        // B3, a pawn/bishop/rook/queen on A2 and any other piece on B2.

        return !(_hordeBishops(side.opposite, hordeBishopColor.opposite) >= 2 ||
            (_hordeBishops(side.opposite, hordeBishopColor.opposite) >= 1 &&
                piecesMap[Role.pawn]! >= 1) ||
            piecesMap[Role.pawn]! >= 2);
      } else if (hordeMap[Role.knight] == 1) {
        // horde has a lone knight
        // The king on A1 can be smother mated by a knight on C2 if there is
        // a pawn/knight/bishop on B2, a knight/rook on B1 and any other piece
        // on A2.
        // Moreover, when black has four or more pieces and two of them are
        // pawns, black can promote their pawns and selfmate theirself.

        return !(piecesNum >= 4 &&
            (piecesMap[Role.knight]! >= 2 ||
                piecesMap[Role.pawn]! >= 2 ||
                (piecesMap[Role.rook]! >= 1 && piecesMap[Role.knight]! >= 1) ||
                (piecesMap[Role.rook]! >= 1 && piecesMap[Role.bishop]! >= 1) ||
                (piecesMap[Role.knight]! >= 1 &&
                    piecesMap[Role.bishop]! >= 1) ||
                (piecesMap[Role.rook]! >= 1 && piecesMap[Role.pawn]! >= 1) ||
                (piecesMap[Role.knight]! >= 1 && piecesMap[Role.pawn]! >= 1) ||
                (piecesMap[Role.bishop]! >= 1 && piecesMap[Role.pawn]! >= 1) ||
                (_hasBishopPair(side.opposite) &&
                    piecesMap[Role.pawn]! >= 1)) &&
            (_hordeBishops(side.opposite, SquareColor.light) < 2 ||
                (_pieceOfRoleNot(
                      piecesNum,
                      _hordeBishops(side.opposite, SquareColor.light),
                    ) >=
                    3)) &&
            (_hordeBishops(side.opposite, SquareColor.dark) < 2 ||
                (_pieceOfRoleNot(
                      piecesNum,
                      _hordeBishops(side.opposite, SquareColor.dark),
                    ) >=
                    3)));
      }
    } else if (hordeNum == 2) {
      if (piecesNum == 1) {
        // two minor pieces cannot mate a lone king
        return true;
      } else if (hordeMap[Role.knight] == 2) {
        // A king on A1 is mated by two knights, if it is obstructed by a
        // pawn/bishop/knight on B2. On the other hand, if black only has
        // major pieces it is a draw.

        return piecesMap[Role.pawn]! +
                piecesMap[Role.bishop]! +
                piecesMap[Role.knight]! <
            1;
      } else if (_hasBishopPair(side)) {
        return !(piecesMap[Role.pawn]! >= 1 ||
            piecesMap[Role.bishop]! >= 1 ||
            (piecesMap[Role.knight]! >= 1 &&
                piecesMap[Role.rook]! + piecesMap[Role.queen]! >= 1));
      } else if (hordeMap[Role.bishop]! >= 1 && hordeMap[Role.knight]! >= 1) {
        // horde has a bishop and a knight
        return !(piecesMap[Role.pawn]! >= 1 ||
            _hordeBishops(side.opposite, hordeBishopColor.opposite) >= 1 ||
            (_pieceOfRoleNot(
                  piecesNum,
                  _hordeBishops(side.opposite, hordeBishopColor),
                ) >=
                3));
      } else {
        // The horde has two or more bishops on the same color.
        // White can only win if black has enough material to obstruct
        // the squares of the opposite color around the king.
        //
        // A king on A1 obstructed by a pawn/opposite-bishop/knight
        // on A2 and a opposite-bishop/knight on B1 is mated by two
        // bishops on B2 and C3. This position is theoretically
        // achievable even when black has two pawns or when they
        // have a pawn and an opposite color bishop.

        return !((piecesMap[Role.pawn]! >= 1 &&
                _hordeBishops(side.opposite, hordeBishopColor.opposite) >= 1) ||
            (piecesMap[Role.pawn]! >= 1 && piecesMap[Role.knight]! >= 1) ||
            (_hordeBishops(side.opposite, hordeBishopColor.opposite) >= 1 &&
                piecesMap[Role.knight]! >= 1) ||
            (_hordeBishops(side.opposite, hordeBishopColor.opposite) >= 2) ||
            piecesMap[Role.knight]! >= 2 ||
            piecesMap[Role.pawn]! >= 2);
      }
    } else if (hordeNum == 3) {
      // A king in the corner is mated by two knights and a bishop or three
      // knights or the bishop pair and a knight/bishop.

      if ((hordeMap[Role.knight] == 2 && hordeMap[Role.bishop] == 1) ||
          hordeMap[Role.knight] == 3 ||
          _hasBishopPair(side)) {
        return false;
      } else {
        return piecesNum == 1;
      }
    }

    return true;
  }

  @override
  Outcome? get variantOutcome {
    if (board.white.isEmpty) return Outcome.blackWins;

    return null;
  }

  @override
  bool get isVariantEnd => board.white.isEmpty;

  @override
  Horde playUnchecked(Move move) => super.playUnchecked(move) as Horde;

  @override
  Horde _copyWith({
    Board? board,
    Box<Pockets?>? pockets,
    Side? turn,
    Castles? castles,
    Box<Square?>? epSquare,
    int? halfmoves,
    int? fullmoves,
  }) {
    return Horde(
      board: board ?? this.board,
      turn: turn ?? this.turn,
      castles: Castles.empty((board ?? this.board).size),
      halfmoves: halfmoves ?? this.halfmoves,
      fullmoves: fullmoves ?? this.fullmoves,
      epSquare: epSquare != null ? epSquare.value : this.epSquare,
    );
  }
}

/// The outcome of a [Position]. No `winner` means a draw.
@immutable
class Outcome {
  const Outcome({this.winner});

  final Side? winner;

  static const whiteWins = Outcome(winner: Side.white);
  static const blackWins = Outcome(winner: Side.black);
  static const draw = Outcome();

  @override
  String toString() {
    return 'winner: $winner';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Outcome && winner == other.winner;

  @override
  int get hashCode => winner.hashCode;

  /// Create [Outcome] from string
  static Outcome? fromPgn(String? outcome) {
    if (outcome == '1/2-1/2') {
      return Outcome.draw;
    } else if (outcome == '1-0') {
      return Outcome.whiteWins;
    } else if (outcome == '0-1') {
      return Outcome.blackWins;
    } else {
      return null;
    }
  }

  /// Create PGN String out of [Outcome]
  static String toPgnString(Outcome? outcome) {
    if (outcome == null) {
      return '*';
    } else if (outcome.winner == Side.white) {
      return '1-0';
    } else if (outcome.winner == Side.black) {
      return '0-1';
    } else {
      return '1/2-1/2';
    }
  }
}

enum IllegalSetup {
  /// There are no pieces on the board.
  empty,

  /// The player not to move is in check.
  oppositeCheck,

  /// There are impossibly many checkers, two sliding checkers are
  /// aligned, or check is not possible because the last move was a
  /// double pawn push.
  ///
  /// Such a position cannot be reached by any sequence of legal moves.
  impossibleCheck,

  /// There are pawns on the backrank.
  pawnsOnBackrank,

  /// A king is missing, or there are too many kings.
  kings,

  /// A variant specific rule is violated.
  variant,
}

@immutable
class PlayError implements Exception {
  const PlayError(this.message);
  final String message;

  @override
  String toString() => 'PlayError($message)';
}

/// Error when trying to create a [Position] from an illegal [Setup].
@immutable
class PositionError implements Exception {
  const PositionError(this.cause);
  final IllegalSetup cause;

  static const empty = PositionError(IllegalSetup.empty);
  static const oppositeCheck = PositionError(IllegalSetup.oppositeCheck);
  static const impossibleCheck = PositionError(IllegalSetup.impossibleCheck);
  static const pawnsOnBackrank = PositionError(IllegalSetup.pawnsOnBackrank);
  static const kings = PositionError(IllegalSetup.kings);
  static const variant = PositionError(IllegalSetup.variant);

  @override
  String toString() => 'PositionError(${cause.name})';
}

@immutable
class Castles {
  const Castles({
    required this.size,
    required this.unmovedRooks,
    required Square? whiteRookQueenSide,
    required Square? whiteRookKingSide,
    required Square? blackRookQueenSide,
    required Square? blackRookKingSide,
    required SquareMap whitePathQueenSide,
    required SquareMap whitePathKingSide,
    required SquareMap blackPathQueenSide,
    required SquareMap blackPathKingSide,
  })  : _whiteRookQueenSide = whiteRookQueenSide,
        _whiteRookKingSide = whiteRookKingSide,
        _blackRookQueenSide = blackRookQueenSide,
        _blackRookKingSide = blackRookKingSide,
        _whitePathQueenSide = whitePathQueenSide,
        _whitePathKingSide = whitePathKingSide,
        _blackPathQueenSide = blackPathQueenSide,
        _blackPathKingSide = blackPathKingSide;

  factory Castles.fromSetup(Setup setup) {
    var castles = Castles.empty(setup.board.size);
    final rooks = setup.unmovedRooks & setup.board.rooks;
    for (final side in Side.values) {
      final backrank = setup.board.size.backrankOf(side);
      final king = setup.board.kingOf(side);
      if (king == null || !backrank.has(king)) continue;
      final backrankRooks = rooks & setup.board.bySide(side) & backrank;
      if (backrankRooks.first != null && backrankRooks.first! < king) {
        castles =
            castles._add(side, CastlingSide.queen, king, backrankRooks.first!);
      }
      if (backrankRooks.last != null && king < backrankRooks.last!) {
        castles =
            castles._add(side, CastlingSide.king, king, backrankRooks.last!);
      }
    }
    return castles;
  }

  factory Castles.empty(BoardSize size) => Castles(
        size: size,
        unmovedRooks: SquareMap.zero,
        whiteRookQueenSide: null,
        whiteRookKingSide: null,
        blackRookQueenSide: null,
        blackRookKingSide: null,
        whitePathQueenSide: SquareMap.zero,
        whitePathKingSide: SquareMap.zero,
        blackPathQueenSide: SquareMap.zero,
        blackPathKingSide: SquareMap.zero,
      );

  final BoardSize size;

  /// SquareMap of rooks that have not moved yet.
  final SquareMap unmovedRooks;

  final Square? _whiteRookQueenSide;
  final Square? _whiteRookKingSide;
  final Square? _blackRookQueenSide;
  final Square? _blackRookKingSide;
  final SquareMap _whitePathQueenSide;
  final SquareMap _whitePathKingSide;
  final SquareMap _blackPathQueenSide;
  final SquareMap _blackPathKingSide;

  static final standard = Castles(
    size: BoardSize.standard,
    unmovedRooks: BoardSize.standard.corners,
    whiteRookQueenSide: 0,
    whiteRookKingSide: 7,
    blackRookQueenSide: 56,
    blackRookKingSide: 63,
    whitePathQueenSide: SquareMap.from(0x000000000000000e),
    whitePathKingSide: SquareMap.from(0x0000000000000060),
    blackPathQueenSide: SquareMap.parse('0x0e00000000000000'),
    blackPathKingSide: SquareMap.parse('0x6000000000000000'),
  );

  static final horde = Castles(
    size: BoardSize.standard,
    unmovedRooks: SquareMap.parse('0x8100000000000000'),
    whiteRookKingSide: null,
    whiteRookQueenSide: null,
    blackRookKingSide: 63,
    blackRookQueenSide: 56,
    whitePathKingSide: SquareMap.zero,
    whitePathQueenSide: SquareMap.zero,
    blackPathQueenSide: SquareMap.parse('0x0e00000000000000'),
    blackPathKingSide: SquareMap.parse('0x6000000000000000'),
  );

  /// Gets rooks positions by side and castling side.
  BySide<ByCastlingSide<Square?>> get rooksPositions {
    return BySide({
      Side.white: ByCastlingSide({
        CastlingSide.queen: _whiteRookQueenSide,
        CastlingSide.king: _whiteRookKingSide,
      }),
      Side.black: ByCastlingSide({
        CastlingSide.queen: _blackRookQueenSide,
        CastlingSide.king: _blackRookKingSide,
      }),
    });
  }

  /// Gets rooks paths by side and castling side.
  BySide<ByCastlingSide<SquareMap>> get paths {
    return BySide({
      Side.white: ByCastlingSide({
        CastlingSide.queen: _whitePathQueenSide,
        CastlingSide.king: _whitePathKingSide,
      }),
      Side.black: ByCastlingSide({
        CastlingSide.queen: _blackPathQueenSide,
        CastlingSide.king: _blackPathKingSide,
      }),
    });
  }

  /// Gets the rook [Square] by side and castling side.
  Square? rookOf(Side side, CastlingSide cs) => cs == CastlingSide.queen
      ? side == Side.white
          ? _whiteRookQueenSide
          : _blackRookQueenSide
      : side == Side.white
          ? _whiteRookKingSide
          : _blackRookKingSide;

  /// Gets the squares that need to be empty so that castling is possible
  /// on the given side.
  ///
  /// We're assuming the player still has the required castling rigths.
  SquareMap pathOf(Side side, CastlingSide cs) => cs == CastlingSide.queen
      ? side == Side.white
          ? _whitePathQueenSide
          : _blackPathQueenSide
      : side == Side.white
          ? _whitePathKingSide
          : _blackPathKingSide;

  Castles discardRookAt(Square square) {
    return _copyWith(
      unmovedRooks: unmovedRooks.withoutSquare(square),
      whiteRookQueenSide:
          _whiteRookQueenSide == square ? const Box(null) : null,
      whiteRookKingSide: _whiteRookKingSide == square ? const Box(null) : null,
      blackRookQueenSide:
          _blackRookQueenSide == square ? const Box(null) : null,
      blackRookKingSide: _blackRookKingSide == square ? const Box(null) : null,
    );
  }

  Castles discardSide(Side side) {
    return _copyWith(
      unmovedRooks: unmovedRooks.diff(size.backrankOf(side)),
      whiteRookQueenSide: side == Side.white ? const Box(null) : null,
      whiteRookKingSide: side == Side.white ? const Box(null) : null,
      blackRookQueenSide: side == Side.black ? const Box(null) : null,
      blackRookKingSide: side == Side.black ? const Box(null) : null,
    );
  }

  Castles _add(Side side, CastlingSide cs, Square king, Square rook) {
    final kingTo = _kingCastlesTo(side, cs, size);
    final rookTo = _rookCastlesTo(side, cs, size);
    final path = size.attacks
        .between(rook, rookTo)
        .withSquare(rookTo)
        .union(size.attacks.between(king, kingTo).withSquare(kingTo))
        .withoutSquare(king)
        .withoutSquare(rook);
    return _copyWith(
      unmovedRooks: unmovedRooks.withSquare(rook),
      whiteRookQueenSide:
          side == Side.white && cs == CastlingSide.queen ? Box(rook) : null,
      whiteRookKingSide:
          side == Side.white && cs == CastlingSide.king ? Box(rook) : null,
      blackRookQueenSide:
          side == Side.black && cs == CastlingSide.queen ? Box(rook) : null,
      blackRookKingSide:
          side == Side.black && cs == CastlingSide.king ? Box(rook) : null,
      whitePathQueenSide:
          side == Side.white && cs == CastlingSide.queen ? path : null,
      whitePathKingSide:
          side == Side.white && cs == CastlingSide.king ? path : null,
      blackPathQueenSide:
          side == Side.black && cs == CastlingSide.queen ? path : null,
      blackPathKingSide:
          side == Side.black && cs == CastlingSide.king ? path : null,
    );
  }

  Castles _copyWith({
    SquareMap? unmovedRooks,
    Box<Square?>? whiteRookQueenSide,
    Box<Square?>? whiteRookKingSide,
    Box<Square?>? blackRookQueenSide,
    Box<Square?>? blackRookKingSide,
    SquareMap? whitePathQueenSide,
    SquareMap? whitePathKingSide,
    SquareMap? blackPathQueenSide,
    SquareMap? blackPathKingSide,
  }) {
    return Castles(
      size: size,
      unmovedRooks: unmovedRooks ?? this.unmovedRooks,
      whiteRookQueenSide: whiteRookQueenSide != null
          ? whiteRookQueenSide.value
          : _whiteRookQueenSide,
      whiteRookKingSide: whiteRookKingSide != null
          ? whiteRookKingSide.value
          : _whiteRookKingSide,
      blackRookQueenSide: blackRookQueenSide != null
          ? blackRookQueenSide.value
          : _blackRookQueenSide,
      blackRookKingSide: blackRookKingSide != null
          ? blackRookKingSide.value
          : _blackRookKingSide,
      whitePathQueenSide: whitePathQueenSide ?? _whitePathQueenSide,
      whitePathKingSide: whitePathKingSide ?? _whitePathKingSide,
      blackPathQueenSide: blackPathQueenSide ?? _blackPathQueenSide,
      blackPathKingSide: blackPathKingSide ?? _blackPathKingSide,
    );
  }

  @override
  String toString() {
    return 'Castles(unmovedRooks: ${unmovedRooks.readable})';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Castles &&
          other.unmovedRooks == unmovedRooks &&
          other._whiteRookQueenSide == _whiteRookQueenSide &&
          other._whiteRookKingSide == _whiteRookKingSide &&
          other._blackRookQueenSide == _blackRookQueenSide &&
          other._blackRookKingSide == _blackRookKingSide &&
          other._whitePathQueenSide == _whitePathQueenSide &&
          other._whitePathKingSide == _whitePathKingSide &&
          other._blackPathQueenSide == _blackPathQueenSide &&
          other._blackPathKingSide == _blackPathKingSide;

  @override
  int get hashCode => Object.hash(
        unmovedRooks,
        _whiteRookQueenSide,
        _whiteRookKingSide,
        _blackRookQueenSide,
        _blackRookKingSide,
        _whitePathQueenSide,
        _whitePathKingSide,
        _blackPathQueenSide,
        _blackPathKingSide,
      );
}

@immutable
class _Context {
  const _Context({
    required this.isVariantEnd,
    required this.king,
    required this.blockers,
    required this.checkers,
    required this.mustCapture,
  });

  final bool isVariantEnd;
  final bool mustCapture;
  final Square? king;
  final SquareMap blockers;
  final SquareMap checkers;

  _Context copyWith({
    bool? isVariantEnd,
    bool? mustCapture,
    Square? king,
    SquareMap? blockers,
    SquareMap? checkers,
  }) {
    return _Context(
      isVariantEnd: isVariantEnd ?? this.isVariantEnd,
      mustCapture: mustCapture ?? this.mustCapture,
      king: king,
      blockers: blockers ?? this.blockers,
      checkers: checkers ?? this.checkers,
    );
  }
}

Square _rookCastlesTo(Side side, CastlingSide cs, SquareMapSize size) {
  return side == Side.white
      ? (cs == CastlingSide.queen ? 3 : size.files - 3) // standard : d1 / f1
      : size.capacity -
          (cs == CastlingSide.queen ? size.files - 3 : 3); // standard : d8 / f8
}

Square _kingCastlesTo(Side side, CastlingSide cs, SquareMapSize size) {
  return side == Side.white
      ? (cs == CastlingSide.queen ? 2 : size.files - 2) // standard : c1 / g1
      : size.capacity -
          (cs == CastlingSide.queen ? size.files - 2 : 2); // standard : c8 / g8
}

Square? _validEpSquare(Setup setup) {
  // TODO : change ? can make two moves from any starting square ?
  if (setup.epSquare == null) return null;
  final epRank = setup.turn == Side.white ? setup.board.size.ranks - 3 : 2;
  final forward = setup.turn == Side.white
      ? setup.board.size.files
      : -setup.board.size.files;
  if (setup.board.size.rankOf(setup.epSquare!) != epRank) return null;
  if (setup.board.occupied.has(setup.epSquare! + forward)) return null;
  final pawn = setup.epSquare! - forward;
  if (!setup.board.pawns.has(pawn) ||
      !setup.board.bySide(setup.turn.opposite).has(pawn)) {
    return null;
  }
  return setup.epSquare;
}

SquareMap _pseudoLegalMoves(Position pos, Square square, _Context context) {
  if (pos.isVariantEnd) return SquareMap.zero;
  final piece = pos.board.pieceAt(square);
  if (piece == null || piece.color != pos.turn) return SquareMap.zero;

  var pseudo = pos.board.attacks.of(piece, square, pos.board.occupied);
  if (piece.role == Role.pawn) {
    var captureTargets = pos.board.bySide(pos.turn.opposite);
    if (pos.epSquare != null) {
      captureTargets = captureTargets.withSquare(pos.epSquare!);
    }
    pseudo = pseudo & captureTargets;
    final size = pos.board.size;
    final delta = pos.turn == Side.white ? size.files : -size.files;
    final step = square + delta;
    if (0 <= step && step < size.capacity && !pos.board.occupied.has(step)) {
      pseudo = pseudo.withSquare(step);
      final canDoubleStep = pos.turn == Side.white
          ? square < size.files * 2
          : square >= size.capacity - size.files * 2;
      final doubleStep = step + delta;
      if (canDoubleStep && !pos.board.occupied.has(doubleStep)) {
        pseudo = pseudo.withSquare(doubleStep);
      }
    }
    return pseudo;
  } else {
    pseudo = pseudo.diff(pos.board.bySide(pos.turn));
  }
  if (square == context.king) {
    return pseudo
        .union(pos._castlingMove(CastlingSide.queen, context))
        .union(pos._castlingMove(CastlingSide.king, context));
  } else {
    return pseudo;
  }
}
