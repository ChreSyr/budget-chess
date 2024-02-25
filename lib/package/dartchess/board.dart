import 'package:crea_chess/package/dartchess/attacks.dart';
import 'package:crea_chess/package/dartchess/models.dart';
import 'package:crea_chess/package/dartchess/square_map.dart';
import 'package:crea_chess/package/dartchess/square_set.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

// TODO : move this converter somewhere else
class BoardSizeConverter
    implements JsonConverter<BoardSize, Map<String, dynamic>> {
  const BoardSizeConverter();

  @override
  BoardSize fromJson(Map<String, dynamic> json) {
    return BoardSize(
      ranks: json['ranks'] as int,
      files: json['files'] as int,
    );
  }

  @override
  Map<String, dynamic> toJson(BoardSize size) => {
        'ranks': size.ranks,
        'files': size.files,
      };
}

/// The number of ranks and files of a chessboard
@immutable
class BoardSize extends SquareMapSize {
  BoardSize({required super.files, required super.ranks})
      : rankIds = _generateRankIds(ranks),
        fileIds = _generateFileIds(files),
        allSquareIds = _generateAllSquareIds(files, ranks),
        attacks = Attacks(SquareMapSize(files: files, ranks: ranks));

  final List<String> rankIds;
  final List<String> fileIds;
  final List<SquareId> allSquareIds;

  /// An attacks calculator
  final Attacks attacks;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BoardSize && other.ranks == ranks && other.files == files;
  }

  @override
  int get hashCode => ranks.hashCode ^ files.hashCode;

  static List<String> _generateAllSquareIds(int files, int ranks) =>
      List.unmodifiable([
        for (final f in _generateFileIds(files))
          for (final r in _generateRankIds(ranks)) '$f$r',
      ]);

  static List<String> _generateFileIds(int files) => List.unmodifiable(
        List.generate(
          files,
          (index) => String.fromCharCode(97 + index),
        ),
      );

  static List<String> _generateRankIds(int ranks) => List.unmodifiable(
        List.generate(
          ranks,
          (index) => (1 + index).toString(),
        ),
      );

  static final BoardSize standard = BoardSize(ranks: 8, files: 8);

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

/// A board represented by several square sets for each piece.
@immutable
class Board {
  const Board._({
    required this.size,
    required this.attacks,
    required this.occupied,
    required this.promoted,
    required this.white,
    required this.black,
    required this.pawns,
    required this.knights,
    required this.bishops,
    required this.rooks,
    required this.queens,
    required this.kings,
  });

  /// Parse the board part of a FEN string and returns a Board.
  ///
  /// Throws a [FenError] if the provided FEN string is not valid.
  factory Board.parseFen(String boardFen) {
    var board = Board.empty(?);
    var rank = 7;
    var file = 0;
    for (var i = 0; i < boardFen.length; i++) {
      final c = boardFen[i];
      if (c == '/' && file == 8) {
        file = 0;
        rank--;
      } else {
        final code = c.codeUnitAt(0);
        if (code < 57) {
          file += code - 48;
        } else {
          if (file >= 8 || rank < 0) throw const FenError('ERR_BOARD');
          final square = file + rank * 8;
          final promoted = i + 1 < boardFen.length && boardFen[i + 1] == '~';
          final piece = _charToPiece(c, promoted);
          if (piece == null) throw const FenError('ERR_BOARD');
          if (promoted) i++;
          board = board.setPieceAt(square, piece);
          file++;
        }
      }
    }
    if (rank != 0 || file != 8) throw const FenError('ERR_BOARD');
    return board;
  }

  factory Board.empty(BoardSize size) => Board._(
    size: size,
    attacks: Attacks(SquareSetSize(boardSize: size)),
    occupied: SquareSet.empty(SquareSetSize(boardSize: size)),
    promoted: SquareSet.empty(SquareSetSize(boardSize: size)),
    white: SquareSet.empty(SquareSetSize(boardSize: size)),
    black: SquareSet.empty(SquareSetSize(boardSize: size)),
    pawns: SquareSet.empty(SquareSetSize(boardSize: size)),
    knights: SquareSet.empty(SquareSetSize(boardSize: size)),
    bishops: SquareSet.empty(SquareSetSize(boardSize: size)),
    rooks: SquareSet.empty(SquareSetSize(boardSize: size)),
    queens: SquareSet.empty(SquareSetSize(boardSize: size)),
    kings: SquareSet.empty(SquareSetSize(boardSize: size)),
  );

  /// The number of ranks and files
  final BoardSize size;

  /// The calculator of piece attacks
  final Attacks attacks;

  /// All occupied squares.
  final SquareSet occupied;

  /// All squares occupied by pieces known to be promoted.
  ///
  /// This information is relevant in chess variants like [Crazyhouse].
  final SquareSet promoted;

  /// All squares occupied by white pieces.
  final SquareSet white;

  /// All squares occupied by black pieces.
  final SquareSet black;

  /// All squares occupied by pawns.
  final SquareSet pawns;

  /// All squares occupied by knights.
  final SquareSet knights;

  /// All squares occupied by bishops.
  final SquareSet bishops;

  /// All squares occupied by rooks.
  final SquareSet rooks;

  /// All squares occupied by queens.
  final SquareSet queens;

  /// All squares occupied by kings.
  final SquareSet kings;

  /// Standard chess starting position.
  static final standard = Board._(
    size: BoardSize.standard,
    attacks: Attacks.standard,
    occupied: SquareSet(BigInt.parse('0xffff00000000ffff'), SquareSetSize.standard,),
    promoted: SquareSet.empty(SquareSetSize.standard),
    white: SquareSet(BigInt.from(0xffff), SquareSetSize.standard),
    black: SquareSet(BigInt.parse('0xffff000000000000'), SquareSetSize.standard,),
    pawns: SquareSet(BigInt.parse('0x00ff00000000ff00'), SquareSetSize.standard,),
    knights: SquareSet(BigInt.parse('0x4200000000000042'), SquareSetSize.standard,),
    bishops: SquareSet(BigInt.parse('0x2400000000000024'), SquareSetSize.standard,),
    rooks: SquareSet.corners(SquareSetSize.standard),
    queens: SquareSet(BigInt.parse('0x0800000000000008'), SquareSetSize.standard,),
    kings: SquareSet(BigInt.parse('0x1000000000000010'), SquareSetSize.standard,),
  );

  /// Racing Kings start position
  static final standardRacingKings =  Board._(
    size: BoardSize.standard,
    attacks: Attacks.standard,
    occupied: SquareSet(BigInt.from(0xffff), SquareSetSize.standard),
    promoted: SquareSet.empty(SquareSetSize.standard),
    white: SquareSet(BigInt.from(0xf0f0), SquareSetSize.standard),
    black: SquareSet(BigInt.from(0x0f0f), SquareSetSize.standard),
    pawns: SquareSet.empty(SquareSetSize.standard),
    knights: SquareSet(BigInt.from(0x1818), SquareSetSize.standard),
    bishops: SquareSet(BigInt.from(0x2424), SquareSetSize.standard),
    rooks: SquareSet(BigInt.from(0x4242), SquareSetSize.standard),
    queens: SquareSet(BigInt.from(0x0081), SquareSetSize.standard),
    kings: SquareSet(BigInt.from(0x8100), SquareSetSize.standard),
  );

  /// Horde start Position
  static final standardHorde = Board._(
    size: BoardSize.standard,
    attacks: Attacks.standard,
    occupied: SquareSet(BigInt.parse('0xffff0066ffffffff'), SquareSetSize.standard,),
    promoted: SquareSet.empty(SquareSetSize.standard),
    white: SquareSet(BigInt.from(0x00000066ffffffff), SquareSetSize.standard,),
    black: SquareSet(BigInt.parse('0xffff000000000000'), SquareSetSize.standard,),
    pawns: SquareSet(BigInt.parse('0x00ff0066ffffffff'), SquareSetSize.standard,),
    knights: SquareSet(BigInt.parse('0x4200000000000000'), SquareSetSize.standard,),
    bishops: SquareSet(BigInt.parse('0x2400000000000000'), SquareSetSize.standard,),
    rooks: SquareSet(BigInt.parse('0x8100000000000000'), SquareSetSize.standard,),
    queens: SquareSet(BigInt.parse('0x0800000000000000'), SquareSetSize.standard,),
    kings: SquareSet(BigInt.parse('0x1000000000000000'), SquareSetSize.standard,),
  );

  SquareSet get rooksAndQueens => rooks | queens;
  SquareSet get bishopsAndQueens => bishops | queens;

  /// Board part of the Forsyth-Edwards-Notation.
  String get fen {
    final buffer = StringBuffer();
    var empty = 0;
    for (var rank = 7; rank >= 0; rank--) {
      for (var file = 0; file < 8; file++) {
        final square = file + rank * 8;
        final piece = pieceAt(square);
        if (piece == null) {
          empty++;
        } else {
          if (empty > 0) {
            buffer.write(empty.toString());
            empty = 0;
          }
          buffer.write(piece.fenChar);
        }

        if (file == 7) {
          if (empty > 0) {
            buffer.write(empty.toString());
            empty = 0;
          }
          if (rank != 0) buffer.write('/');
        }
      }
    }
    return buffer.toString();
  }

  /// An iterable of each [Piece] associated to its [Square].
  Iterable<(Square, Piece)> get pieces sync* {
    for (final square in occupied.squares) {
      yield (square, pieceAt(square)!);
    }
  }

  /// Gets the number of pieces of each [Role] for the given [Side].
  IMap<Role, int> materialCount(Side side) => IMap.fromEntries(
        Role.values.map((role) => MapEntry(role, piecesOf(side, role).bits)),
      );

  /// A [SquareSet] of all the pieces matching this [Side] and [Role].
  SquareSet piecesOf(Side side, Role role) {
    return bySide(side) & byRole(role);
  }

  /// Gets all squares occupied by [Side].
  SquareSet bySide(Side side) => side == Side.white ? white : black;

  /// Gets all squares occupied by [Role].
  SquareSet byRole(Role role) {
    switch (role) {
      case Role.pawn:
        return pawns;
      case Role.knight:
        return knights;
      case Role.bishop:
        return bishops;
      case Role.rook:
        return rooks;
      case Role.queen:
        return queens;
      case Role.king:
        return kings;
    }
  }

  /// Gets all squares occupied by [Piece].
  SquareSet byPiece(Piece piece) {
    return bySide(piece.color) & byRole(piece.role);
  }

  /// Gets the [Side] at this [Square], if any.
  Side? sideAt(Square square) {
    if (bySide(Side.white).has(square)) {
      return Side.white;
    } else if (bySide(Side.black).has(square)) {
      return Side.black;
    } else {
      return null;
    }
  }

  /// Gets the [Role] at this [Square], if any.
  Role? roleAt(Square square) {
    for (final role in Role.values) {
      if (byRole(role).has(square)) {
        return role;
      }
    }
    return null;
  }

  /// Gets the [Piece] at this [Square], if any.
  Piece? pieceAt(Square square) {
    final side = sideAt(square);
    if (side == null) {
      return null;
    }
    final role = roleAt(square)!;
    final prom = promoted.has(square);
    return Piece(color: side, role: role, promoted: prom);
  }

  /// Finds the unique king [Square] of the given [Side], if any.
  Square? kingOf(Side side) {
    return byPiece(Piece(color: side, role: Role.king)).singleSquare;
  }

  /// Finds the squares who are attacking `square` by the `attacker` [Side].
  SquareSet attacksTo(Square square, Side attacker, {SquareSet? occupied}) =>
      bySide(attacker).intersect(
        rookAttacks(square, occupied ?? this.occupied)
            .intersect(rooksAndQueens)
            .union(
              bishopAttacks(square, occupied ?? this.occupied)
                  .intersect(bishopsAndQueens),
            )
            .union(knightAttacks(square).intersect(knights))
            .union(kingAttacks(square).intersect(kings))
            .union(pawnAttacks(attacker.opposite, square).intersect(pawns)),
      );

  /// Puts a [Piece] on a [Square] overriding the existing one, if any.
  Board setPieceAt(Square square, Piece piece) {
    return removePieceAt(square)._copyWith(
      occupied: occupied.withSquare(square),
      promoted: piece.promoted ? promoted.withSquare(square) : null,
      white: piece.color == Side.white ? white.withSquare(square) : null,
      black: piece.color == Side.black ? black.withSquare(square) : null,
      pawns: piece.role == Role.pawn ? pawns.withSquare(square) : null,
      knights: piece.role == Role.knight ? knights.withSquare(square) : null,
      bishops: piece.role == Role.bishop ? bishops.withSquare(square) : null,
      rooks: piece.role == Role.rook ? rooks.withSquare(square) : null,
      queens: piece.role == Role.queen ? queens.withSquare(square) : null,
      kings: piece.role == Role.king ? kings.withSquare(square) : null,
    );
  }

  /// Removes the [Piece] at this [Square] if it exists.
  Board removePieceAt(Square square) {
    final piece = pieceAt(square);
    return piece != null
        ? _copyWith(
            occupied: occupied.withoutSquare(square),
            promoted: piece.promoted ? promoted.withoutSquare(square) : null,
            white:
                piece.color == Side.white ? white.withoutSquare(square) : null,
            black:
                piece.color == Side.black ? black.withoutSquare(square) : null,
            pawns: piece.role == Role.pawn ? pawns.withoutSquare(square) : null,
            knights: piece.role == Role.knight
                ? knights.withoutSquare(square)
                : null,
            bishops: piece.role == Role.bishop
                ? bishops.withoutSquare(square)
                : null,
            rooks: piece.role == Role.rook ? rooks.withoutSquare(square) : null,
            queens:
                piece.role == Role.queen ? queens.withoutSquare(square) : null,
            kings: piece.role == Role.king ? kings.withoutSquare(square) : null,
          )
        : this;
  }

  Board withPromoted(SquareSet promoted) {
    return _copyWith(promoted: promoted);
  }

  Board _copyWith({
    SquareSet? occupied,
    SquareSet? promoted,
    SquareSet? white,
    SquareSet? black,
    SquareSet? pawns,
    SquareSet? knights,
    SquareSet? bishops,
    SquareSet? rooks,
    SquareSet? queens,
    SquareSet? kings,
  }) {
    return Board(
      occupied: occupied ?? this.occupied,
      promoted: promoted ?? this.promoted,
      white: white ?? this.white,
      black: black ?? this.black,
      pawns: pawns ?? this.pawns,
      knights: knights ?? this.knights,
      bishops: bishops ?? this.bishops,
      rooks: rooks ?? this.rooks,
      queens: queens ?? this.queens,
      kings: kings ?? this.kings,
    );
  }

  @override
  String toString() => fen;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Board &&
            other.occupied == occupied &&
            other.promoted == promoted &&
            other.white == white &&
            other.black == black &&
            other.pawns == pawns &&
            other.knights == knights &&
            other.bishops == bishops &&
            other.rooks == rooks &&
            other.queens == queens &&
            other.kings == kings;
  }

  @override
  int get hashCode => Object.hash(
        occupied,
        promoted,
        white,
        black,
        pawns,
        knights,
        bishops,
        rooks,
        queens,
        kings,
      );
}

Piece? _charToPiece(String ch, bool promoted) {
  final role = Role.fromChar(ch);
  if (role != null) {
    return Piece(
      role: role,
      color: ch == ch.toLowerCase() ? Side.black : Side.white,
      promoted: promoted,
    );
  }
  return null;
}
