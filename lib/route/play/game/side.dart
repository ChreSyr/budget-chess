import 'package:chessground/chessground.dart';
import 'package:dartchess_webok/dartchess_webok.dart' as dc;

extension SideExt on Side {
  InteractableSide get interactable => switch (this) {
        Side.white => InteractableSide.white,
        Side.black => InteractableSide.black,
      };

  dc.Side get toDartchess => switch (this) {
        Side.white => dc.Side.white,
        Side.black => dc.Side.black,
      };
}

extension DCSideExt on dc.Side {
  Side get toChessground => switch (this) {
        dc.Side.white => Side.white,
        dc.Side.black => Side.black,
      };
}
