import 'package:chessground/chessground.dart';

extension RoleExt on Role {
  double get value => switch (this) {
        Role.king => 100,
        Role.queen => 9.5,
        Role.rook => 5.63,
        Role.bishop => 3.33,
        Role.knight => 3.05,
        Role.pawn => 1,
      };
}
