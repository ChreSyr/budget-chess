import 'package:chessground/chessground.dart';
import 'package:dartchess_webok/dartchess_webok.dart' as dc_w;

extension DCWRoleExt on dc_w.Role {
  double get sortValue => switch (this) {
        dc_w.Role.king => 100,
        dc_w.Role.queen => 9.5,
        dc_w.Role.rook => 5.63,
        dc_w.Role.bishop => 3.33,
        dc_w.Role.knight => 3.05,
        dc_w.Role.pawn => 1,
      };

  int get intValue => switch (this) {
        dc_w.Role.king => 0,
        dc_w.Role.queen => 9,
        dc_w.Role.rook => 5,
        dc_w.Role.bishop => 3,
        dc_w.Role.knight => 3,
        dc_w.Role.pawn => 1,
      };
}

extension RoleExt on Role {
  double get sortValue => switch (this) {
        Role.king => 100,
        Role.queen => 9.5,
        Role.rook => 5.63,
        Role.bishop => 3.33,
        Role.knight => 3.05,
        Role.pawn => 1,
      };

  double get intValue => switch (this) {
        Role.king => 0,
        Role.queen => 9,
        Role.rook => 5,
        Role.bishop => 3,
        Role.knight => 3,
        Role.pawn => 1,
      };

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
}
