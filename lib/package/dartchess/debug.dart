import 'package:crea_chess/package/dartchess/board.dart';
import 'package:crea_chess/package/dartchess/models.dart';
import 'package:crea_chess/package/dartchess/move.dart';
import 'package:crea_chess/package/dartchess/position.dart';
import 'package:crea_chess/package/dartchess/square_map.dart';
import 'package:crea_chess/package/dartchess/square_set.dart';
import 'package:flutter/material.dart';

/// Takes a string and returns a SquareSet. Useful for debugging/testing purposes.
///
/// Example:
/// ```dart
/// final str = '''
/// . 1 1 1 . . . .
/// . 1 . 1 . . . .
/// . 1 . . 1 . . .
/// . 1 . . . 1 . .
/// . 1 1 1 1 . . .
/// . 1 . . . 1 . .
/// . 1 . . . 1 . .
/// . 1 . . 1 . . .
/// '''
/// final squareSet = makeSquareSet(str);
/// // SquareSet(0x0E0A12221E222212)
/// ```
SquareMap makeSquareMap(String rep, SquareMapSize size) {
  var ret = SquareMap.zero;
  final table = rep
      .split('\n')
      .where((l) => l.isNotEmpty)
      .map((r) => r.split(' '))
      .toList()
      .reversed
      .toList();
  for (var y = size.ranks - 1; y >= 0; y--) {
    for (var x = 0; x < size.files; x++) {
      final repSq = table[y][x];
      if (repSq == '1') {
        ret = ret.withSquare(x + y * size.files);
      }
    }
  }
  return ret;
}

/// Prints the square set as a human readable string format
String humanReadableSquareMap(SquareMap map, SquareMapSize size) {
  final buffer = StringBuffer();
  for (var y = size.ranks - 1; y >= 0; y--) {
    for (var x = 0; x < (size.files); x++) {
      final square = x + y * size.files;
      buffer
        ..write(map.has(square) ? '1' : '.')
        ..write(x < (size.files - 1) ? ' ' : '\n');
    }
  }
  return buffer.toString();
}

/// Takes a string and returns a SquareSet. Useful for debugging/testing purposes.
///
/// Example:
/// ```dart
/// final str = '''
/// . 1 1 1 . . . .
/// . 1 . 1 . . . .
/// . 1 . . 1 . . .
/// . 1 . . . 1 . .
/// . 1 1 1 1 . . .
/// . 1 . . . 1 . .
/// . 1 . . . 1 . .
/// . 1 . . 1 . . .
/// '''
/// final squareSet = makeSquareSet(str);
/// // SquareSet(0x0E0A12221E222212)
/// ```
SquareSet makeSquareSet(String rep, SquareSetSize size) {
  var ret = SquareSet.empty(size);
  final table = rep
      .split('\n')
      .where((l) => l.isNotEmpty)
      .map((r) => r.split(' '))
      .toList()
      .reversed
      .toList();
  for (var y = size.ranks - 1; y >= 0; y--) {
    for (var x = 0; x < size.files; x++) {
      final repSq = table[y][x];
      if (repSq == '1') {
        ret = ret.withSquare(x + y * size.files);
      }
    }
  }
  return ret;
}

/// Prints the square set as a human readable string format
String humanReadableSquareSet(SquareSet sq) {
  final buffer = StringBuffer();
  for (var y = sq.size.ranks - 1; y >= 0; y--) {
    for (var x = 0; x < (sq.size.files); x++) {
      final square = x + y * sq.size.files;
      buffer
        ..write(sq.has(square) ? '1' : '.')
        ..write(x < (sq.size.files - 1) ? ' ' : '\n');
    }
  }
  return buffer.toString();
}

/// Prints the board as a human readable string format
/// TODO
String humanReadableBoard(Board board) {
  final buffer = StringBuffer();
  for (var y = board.size.ranks - 1; y >= 0; y--) {
    for (var x = 0; x < board.size.files; x++) {
      final square = x + y * board.size.files;
      final p = board.pieceAt(square);
      final col = p != null ? p.fenChar : '.';
      buffer
        ..write(col)
        ..write(x < 7 ? (col.length < 2 ? ' ' : '') : '\n');
    }
  }
  return buffer.toString();
}

final _promotionRoles = [Role.queen, Role.rook, Role.knight, Role.bishop];

/// Counts legal move paths of a given length.
///
/// Computing perft numbers is useful for comparing, testing and debugging move
/// generation correctness and performance.
int perft(Position pos, int depth, {bool shouldLog = false}) {
  if (depth < 1) return 1;

  final promotionRoles =
      pos is Antichess ? [..._promotionRoles, Role.king] : _promotionRoles;
  final legalDrops = pos.legalDrops;

  if (!shouldLog && depth == 1 && legalDrops.isEmpty) {
    // Optimization for leaf nodes.
    var nodes = 0;
    for (final entry in pos.legalMoves.entries) {
      final from = entry.key;
      final to = entry.value;
      nodes += to.length;
      if (pos.board.pawns.has(from)) {
        final backrank = pos.board.size.backrankOf(pos.turn.opposite);
        nodes += to.intersect(backrank).length * (promotionRoles.length - 1);
      }
    }
    return nodes;
  } else {
    var nodes = 0;
    for (final entry in pos.legalMoves.entries) {
      final from = entry.key;
      final dests = entry.value;
      // TODO
      final promotions =
          pos.board.size.rankOf(from) == (pos.turn == Side.white ? 6 : 1) &&
              pos.board.pawns.has(from)
          ? promotionRoles
          : [null];
      for (final to in dests.squares) {
        for (final promotion in promotions) {
          final move = NormalMove(from: from, to: to, promotion: promotion);
          final child = pos.playUnchecked(move);
          final children = perft(child, depth - 1);
          if (shouldLog) debugPrint('${move.uci} $children');
          nodes += children;
        }
      }
    }
    if (pos.pockets != null) {
      for (final role in Role.values) {
        if (pos.pockets!.of(pos.turn, role) > 0) {
          for (final to in (role == Role.pawn
                  ? legalDrops.diff(pos.board.size.backranks)
                  : legalDrops)
              .squares) {
            final drop = DropMove(role: role, to: to);
            final child = pos.playUnchecked(drop);
            final children = perft(child, depth - 1);
            if (shouldLog) debugPrint('${drop.uci} $children');
            nodes += children;
          }
        }
      }
    }
    return nodes;
  }
}
