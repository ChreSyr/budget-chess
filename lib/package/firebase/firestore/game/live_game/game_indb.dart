import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/game/game/game.dart';
import 'package:crea_chess/package/firebase/firestore/game/live_game/account_preferences.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_indb.freezed.dart';
part 'game_indb.g.dart';

class GamePrefsConverter
    implements JsonConverter<GamePrefs, Map<String, dynamic>> {
  const GamePrefsConverter();

  @override
  GamePrefs fromJson(Map<String, dynamic> json) {
    return GamePrefs.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(GamePrefs data) => data.toJson();
}

@freezed
class GamePrefs with _$GamePrefs {
  const factory GamePrefs({
    required bool showRatings,
    required bool enablePremove,
    required AutoQueen autoQueen,
    required Zen zenMode,
  }) = _GamePrefs;

  /// Required for the override getter
  const GamePrefs._();

  factory GamePrefs.fromJson(Map<String, dynamic> json) =>
      _$GamePrefsFromJson(json);
}

@freezed
class GameStep with _$GameStep {
  const factory GameStep({
    required Position position,
    SanMove? sanMove,
    MaterialDiff? diff,

    /// The remaining white clock time at this step. Only available when the
    /// game is finished.
    Duration? archivedWhiteClock,

    /// The remaining black clock time at this step. Only available when the
    /// game is finished.
    Duration? archivedBlackClock,
  }) = _GameStep;
}

/// Represents a game being currently played
@freezed
class GameInDB with _$GameInDB {
  const factory GameInDB({
    String? id,
    @ChallengeModelConverter() ChallengeModel? challenge,
    String? blackId,
    String? whiteId,
    GameStatus? status,

    /// Starting position of black pieces.
    /// null means black is seting up its pieces.
    String? blackSetupFen,

    /// Starting position of white pieces.
    /// null means white is seting up its pieces.
    String? whiteSetupFen,
    String? sanMoves, // san moves separated by ' '
    Side? winner, // if status is ended & winner is null : draw
    @GamePrefsConverter() GamePrefs? prefs,
  }) = _GameInDB;

  /// Required for the override getter
  const GameInDB._();

  factory GameInDB.fromJson(Map<String, dynamic> json) =>
      _$GameInDBFromJson(json);
}
