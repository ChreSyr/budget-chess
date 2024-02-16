import 'package:chessground/chessground.dart';
import 'package:crea_chess/package/lichess/lichess_icons.dart';
import 'package:dartchess_webok/dartchess_webok.dart' as dc_w;
import 'package:flutter/material.dart';

extension DCWRoleExt on dc_w.Role {
  int get cost => switch (this) {
        dc_w.Role.king => 0,
        dc_w.Role.queen => 9,
        dc_w.Role.rook => 5,
        dc_w.Role.bishop => 3,
        dc_w.Role.knight => 3,
        dc_w.Role.pawn => 1,
      };
}

extension RoleExt on Role {
  double get _sortValue => switch (this) {
        Role.king => 0,
        Role.queen => 9.5,
        Role.rook => 5.63,
        Role.bishop => 3.33,
        Role.knight => 3.05,
        Role.pawn => 1,
      };
  static List<Role> sortedValues = List.from(Role.values)
    ..sort((r1, r2) => r1._sortValue.compareTo(r2._sortValue));

  int get cost => _sortValue.toInt();

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

  IconData get icon {
    switch (this) {
      case Role.pawn:
        return LichessIcons.chess_pawn;
      case Role.knight:
        return LichessIcons.chess_knight;
      case Role.bishop:
        return LichessIcons.chess_bishop;
      case Role.rook:
        return LichessIcons.chess_rook;
      case Role.queen:
        return LichessIcons.chess_queen;
      case Role.king:
        return LichessIcons.chess_king;
    }
  }
}
