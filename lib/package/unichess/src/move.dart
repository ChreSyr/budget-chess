// ignore_for_file: always_use_package_imports

import 'package:meta/meta.dart';

import 'board.dart';
import 'models.dart';

/// Base class for a chess move.
///
/// A move can be either a [NormalMove] or a [DropMove].
@immutable
sealed class Move {
  const Move({
    required this.to,
    required this.umn,
  });

  /// The target square of this move.
  final Square to;

  /// The Universal Move Notation of this move.
  ///
  /// Exemples :
  ///   `7:24` for a normal move,
  ///   `49:57:q` for promotion to a queen.
  ///   `q@34` for drop of a queen.
  final String umn;

  /// Gets the UCI notation of this move.
  String uci(BoardSize size);

  /// Constructs a [Move] from an UCI string.
  ///
  /// Returns `null` if UCI string is not valid.
  static Move? fromUci(String str, BoardSize size) {
    if (str[1] == '@' && str.length == 4) {
      final role = Role.fromChar(str[0]);
      final to = size.parseSquare(str.substring(2));
      if (role != null && to != null) return DropMove(to: to, role: role);
    } else if (str.length == 4 || str.length == 5) {
      final from = size.parseSquare(str.substring(0, 2));
      final to = size.parseSquare(str.substring(2, 4));
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

  /// Constructs a [Move] from an UMN string.
  ///
  /// Returns `null` if UMN string is not valid.
  static Move? fromUmn(String str) {
    if (str.contains('@')) {
      // DropMove
      final splitted = str.split('@');
      if (splitted.length == 2) {
        final role = Role.fromChar(splitted.first);
        final to = int.tryParse(splitted[1]);
        if (role != null && to != null) return DropMove(to: to, role: role);
      }
    } else {
      // NormalMove
      final splitted = str.split(':');
      if (splitted.length >= 2) {
        final from = int.tryParse(splitted.first);
        final to = int.tryParse(splitted[1]);
        final promotion =
            splitted.length == 3 ? Role.fromChar(splitted[2]) : null;
        if (from != null && to != null) {
          return NormalMove(from: from, to: to, promotion: promotion);
        }
      }
    }
    return null;
  }

  @override
  String toString() {
    return 'Move($umn)';
  }
}

/// Represents a chess move, possibly a promotion.
@immutable
class NormalMove extends Move {
  /// Represents a chess move, possibly a promotion.
  NormalMove({
    required this.from,
    required super.to,
    this.promotion,
  }) : super(umn: '$from:$to${promotion == null ? '' : ':${promotion.char}'}');

  /// The origin square of this move.
  final Square from;

  /// The role of the promoted piece, if any.
  final Role? promotion;

  /// Gets UCI notation, like `g1f3` for a normal move,
  /// `a7a8q` for promotion to a queen.
  @override
  String uci(BoardSize size) =>
      size.algebraicOf(from) +
      size.algebraicOf(to) +
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
  /// Represents a drop move.
  DropMove({
    required super.to,
    required this.role,
  }) : super(umn: '${role.char}@$to');

  /// The role of the dropped piece.
  final Role role;

  /// Gets UCI notation of the drop, like `Q@f7`.
  @override
  String uci(BoardSize size) =>
      '${role.char.toUpperCase()}@${size.algebraicOf(to)}';

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other.runtimeType == runtimeType && hashCode == other.hashCode;
  }

  @override
  int get hashCode => Object.hash(to, role);
}
