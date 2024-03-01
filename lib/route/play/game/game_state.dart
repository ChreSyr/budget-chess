import 'package:crea_chess/package/chessground/export.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/game/live_game/account_preferences.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_state.freezed.dart';

@freezed
class GameState with _$GameState {
  const factory GameState({
    required GameModel game,
    required int stepCursor,
    int? lastDrawOfferAtPly,
    Duration? opponentLeftCountdown,
    CGMove? premove,

    /// Zen mode setting if account preference is set to [Zen.gameAuto]
    bool? zenModeGameSetting,

    /// Game full id used to redirect to the new game of the rematch
    String? redirectGameId,
  }) = _GameState;

  const GameState._();

  // preferences
  bool get isZenModeEnabled =>
      zenModeGameSetting ?? game.prefs?.zenMode == Zen.yes;
  bool get canPremove => game.prefs?.enablePremove ?? true;
  bool get canAutoQueen => game.prefs?.autoQueen == AutoQueen.always;
  bool get canAutoQueenOnPremove => game.prefs?.autoQueen == AutoQueen.premove;

  // game
  Position? get position {
    try {
      return game.steps.lastOrNull?.position;
    } catch (_) {
      return null;
    }
  }
}
