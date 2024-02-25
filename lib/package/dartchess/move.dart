import 'package:crea_chess/package/dartchess/board.dart';
import 'package:crea_chess/package/dartchess/models.dart';
import 'package:meta/meta.dart';

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
  const DropMove({
    required super.to,
    required this.role,
  });

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
