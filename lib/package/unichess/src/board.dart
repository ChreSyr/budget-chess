// ignore_for_file: always_use_package_imports

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'attacks.dart';
import 'fen.dart';
import 'models.dart';
import 'position.dart';
import 'square_map.dart';

/// The number of ranks and files of a chessboard.
@immutable
class BoardSize extends SquareMapSize {
  /// The number of ranks and files of a chessboard.
  BoardSize({required super.files, required super.ranks})
      : rankIds = _generateRankIds(ranks),
        fileIds = _generateFileIds(files),
        allSquareIds = _generateAllSquareIds(files, ranks),
        attacks = Attacks(SquareMapSize(files: files, ranks: ranks));

  /// The number of ranks and files of a chessboard.
  ///
  /// The value is the content of the pgn section BoardSize.
  factory BoardSize.fromPgn(String? value) {
    try {
      var splitter = 'x';
      for (final possibleSplitter in ['x', '/']) {
        if (value!.contains(possibleSplitter)) {
          splitter = possibleSplitter;
          break;
        }
      }
      final splitted = value!.split(splitter);
      return BoardSize(
        files: int.parse(splitted.first),
        ranks: int.parse(splitted[1]),
      );
    } catch (_) {
      return BoardSize.standard;
    }
  }

  /// The list of human readable ids of ranks.
  ///
  /// Ex : ['1', '2', '3', ...]
  final List<String> rankIds;

  /// The list of human readable ids of files.
  ///
  /// Ex : ['a', 'b', 'c', ...]
  final List<String> fileIds;

  /// The list of human readable squares of a board with this size.
  ///
  /// Ex : ['a1', 'a2', 'a3', ...]
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

  /// The number of ranks and files of the standard chessboard (8 x 8).
  static final BoardSize standard = BoardSize(ranks: 8, files: 8);

  /// The board part of the initial position in the FEN format,
  /// for standard chess (8 x 8).
  static const standardInitialBoardFEN =
      'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR';

  /// Initial position in the Extended Position Description format,
  /// for standard chess (8 x 8).
  static const standardInitialEPD = '$standardInitialBoardFEN w KQkq -';

  /// Initial position in the FEN format,
  /// for standard chess (8 x 8).
  static const standardInitialFEN = '$standardInitialEPD 0 1';

  /// Empty board part in the FEN format,
  /// for standard chess (8 x 8).
  static const standardEmptyBoardFEN = '8/8/8/8/8/8/8/8';

  /// Empty board in the EPD format,
  /// for standard chess (8 x 8).
  static const standardEmptyEPD = '$standardEmptyBoardFEN w - -';

  /// Empty board in the FEN format,
  /// for standard chess (8 x 8).
  static const standardEmptyFEN = '$standardEmptyEPD 0 1';

  @override
  String toString() => 'BoardSize(files:$files, ranks:$ranks)';
  String get shortString => '${files}x$ranks';

  /// Empty board part in the FEN format.
  String get emptyFen => List.generate(ranks, (_) => files).join('/');

  /// Empty board part in the FEN format,
  /// for a board with half the number of ranks.
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
  factory Board.parseFen(String boardFen, {required BoardSize? size}) {
    if (size == null) {
      final (files, ranks) = FEN.getFilesRanksOf(boardFen);
      size = BoardSize(files: files, ranks: ranks);
    }
    var board = Board.empty(size);
    var rank = size.ranks - 1;
    var file = 0;
    for (var i = 0; i < boardFen.length; i++) {
      final c = boardFen[i];
      if (c == '/' && file == size.files) {
        file = 0;
        rank--;
      } else {
        final code = c.codeUnitAt(0);
        if (code < 57) {
          file += code - 48;
        } else {
          if (file >= size.files || rank < 0) throw const FenError('ERR_BOARD');
          final square = file + rank * size.files;
          final promoted = i + 1 < boardFen.length && boardFen[i + 1] == '~';
          final piece = _charToPiece(c, promoted);
          if (piece == null) throw const FenError('ERR_BOARD');
          if (promoted) i++;
          board = board.setPieceAt(square, piece);
          file++;
        }
      }
    }
    if (rank != 0 || file != size.files) throw const FenError('ERR_BOARD');
    return board;
  }

  /// An empty board represented by several square sets for each piece.
  factory Board.empty(BoardSize size) => Board._(
        size: size,
        attacks: size.attacks,
        occupied: SquareMap.zero,
        promoted: SquareMap.zero,
        white: SquareMap.zero,
        black: SquareMap.zero,
        pawns: SquareMap.zero,
        knights: SquareMap.zero,
        bishops: SquareMap.zero,
        rooks: SquareMap.zero,
        queens: SquareMap.zero,
        kings: SquareMap.zero,
      );

  /// The number of ranks and files
  final BoardSize size;

  /// The calculator of piece attacks
  final Attacks attacks;

  /// All occupied squares.
  final SquareMap occupied;

  /// All squares occupied by pieces known to be promoted.
  ///
  /// This information is relevant in chess variants like [Crazyhouse].
  final SquareMap promoted;

  /// All squares occupied by white pieces.
  final SquareMap white;

  /// All squares occupied by black pieces.
  final SquareMap black;

  /// All squares occupied by pawns.
  final SquareMap pawns;

  /// All squares occupied by knights.
  final SquareMap knights;

  /// All squares occupied by bishops.
  final SquareMap bishops;

  /// All squares occupied by rooks.
  final SquareMap rooks;

  /// All squares occupied by queens.
  final SquareMap queens;

  /// All squares occupied by kings.
  final SquareMap kings;

  /// Standard chess starting position.
  static final standard = Board._(
    size: BoardSize.standard,
    attacks: Attacks.standard,
    occupied: SquareMap.parse('0xffff00000000ffff'),
    promoted: SquareMap.zero,
    white: SquareMap.from(0xffff),
    black: SquareMap.parse('0xffff000000000000'),
    pawns: SquareMap.parse('0x00ff00000000ff00'),
    knights: SquareMap.parse('0x4200000000000042'),
    bishops: SquareMap.parse('0x2400000000000024'),
    rooks: BoardSize.standard.corners,
    queens: SquareMap.parse('0x0800000000000008'),
    kings: SquareMap.parse('0x1000000000000010'),
  );

  /// Racing Kings start position
  static final standardRacingKings = Board._(
    size: BoardSize.standard,
    attacks: Attacks.standard,
    occupied: SquareMap.from(0xffff),
    promoted: SquareMap.zero,
    white: SquareMap.from(0xf0f0),
    black: SquareMap.from(0x0f0f),
    pawns: SquareMap.zero,
    knights: SquareMap.from(0x1818),
    bishops: SquareMap.from(0x2424),
    rooks: SquareMap.from(0x4242),
    queens: SquareMap.from(0x0081),
    kings: SquareMap.from(0x8100),
  );

  /// Horde start Position
  static final standardHorde = Board._(
    size: BoardSize.standard,
    attacks: Attacks.standard,
    occupied: SquareMap.parse('0xffff0066ffffffff'),
    promoted: SquareMap.zero,
    white: SquareMap.from(0x00000066ffffffff),
    black: SquareMap.parse('0xffff000000000000'),
    pawns: SquareMap.parse('0x00ff0066ffffffff'),
    knights: SquareMap.parse('0x4200000000000000'),
    bishops: SquareMap.parse('0x2400000000000000'),
    rooks: SquareMap.parse('0x8100000000000000'),
    queens: SquareMap.parse('0x0800000000000000'),
    kings: SquareMap.parse('0x1000000000000000'),
  );

  /// All squares occupied by rooks and queens.
  SquareMap get rooksAndQueens => rooks | queens;

  /// All squares occupied by bishops and queens.
  SquareMap get bishopsAndQueens => bishops | queens;

  /// Board part of the Forsyth-Edwards-Notation.
  String get fen {
    final buffer = StringBuffer();
    var empty = 0;
    for (var rank = size.ranks - 1; rank >= 0; rank--) {
      for (var file = 0; file < size.files; file++) {
        final square = file + rank * size.files;
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

        if (file == size.files - 1) {
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
        Role.values.map((role) => MapEntry(role, piecesOf(side, role).length)),
      );

  /// A [SquareMap] of all the pieces matching this [Side] and [Role].
  SquareMap piecesOf(Side side, Role role) {
    return bySide(side) & byRole(role);
  }

  /// Gets all squares occupied by [Side].
  SquareMap bySide(Side side) => side == Side.white ? white : black;

  /// Gets all squares occupied by [Role].
  SquareMap byRole(Role role) {
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
  SquareMap byPiece(Piece piece) {
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
  SquareMap attacksTo(Square square, Side attacker, {SquareMap? occupied}) =>
      bySide(attacker) &
      ((size.attacks.ofRook(square, occupied ?? this.occupied) &
              rooksAndQueens) |
          (size.attacks.ofBishop(square, occupied ?? this.occupied) &
              bishopsAndQueens) |
          (size.attacks.ofKnight(square) & knights) |
          (size.attacks.ofKing(square) & kings) |
          (size.attacks.ofPawn(attacker.opposite, square) & pawns));

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

  /// Tags the pieces positioned in the [SquareMap] as promoted.
  Board withPromoted(SquareMap promoted) {
    return _copyWith(promoted: promoted);
  }

  Board _copyWith({
    SquareMap? occupied,
    SquareMap? promoted,
    SquareMap? white,
    SquareMap? black,
    SquareMap? pawns,
    SquareMap? knights,
    SquareMap? bishops,
    SquareMap? rooks,
    SquareMap? queens,
    SquareMap? kings,
  }) {
    return Board._(
      size: size,
      attacks: attacks,
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
