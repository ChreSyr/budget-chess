import 'package:crea_chess/package/chessground/export.dart';
import 'package:crea_chess/package/unichess/unichess.dart';

extension SideExt on Side {
  InteractableSide get interactable => switch (this) {
        Side.white => InteractableSide.white,
        Side.black => InteractableSide.black,
      };

  Side get toDartchess => switch (this) {
        Side.white => Side.white,
        Side.black => Side.black,
      };
}

extension DCSideExt on Side {
  Side get toChessground => switch (this) {
        Side.white => Side.white,
        Side.black => Side.black,
      };
}
