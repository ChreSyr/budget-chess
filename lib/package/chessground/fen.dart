import 'package:crea_chess/package/chessground/models.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:flutter/widgets.dart';

/// Parse the board part of a FEN string.
Pieces readFen({
  required String fen,
  required BoardSize boardSize,
}) {
  // ignore: omit_local_variable_types
  final Pieces pieces = {};
  var row = boardSize.ranks - 1;
  var col = 0;
  for (final c in fen.characters) {
    switch (c) {
      case ' ':
      case '[':
        return pieces;
      case '/':
        --row;
        if (row < 0) return pieces;
        col = 0;
      case '~':
        final sid = Coord(x: col - 1, y: row, boardSize:boardSize).squareId;
        final piece = pieces[sid];
        if (piece != null) {
          pieces[sid] = piece.copyWith(promoted: true);
        }
      default:
        final code = c.codeUnitAt(0);
        if (code < 57) {
          col += code - 48;
        } else {
          final roleLetter = c.toLowerCase();
          final sid = Coord(x: col, y: row, boardSize:boardSize).squareId;
          pieces[sid] = CGPiece(
            role: _roles[roleLetter]!,
            color: c == roleLetter ? Side.black : Side.white,
          );
          ++col;
        }
    }
  }
  return pieces;
}

const _roles = {
  'p': Role.pawn,
  'r': Role.rook,
  'n': Role.knight,
  'b': Role.bishop,
  'q': Role.queen,
  'k': Role.king,
};
