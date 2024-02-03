// ignore_for_file: public_member_api_docs, invalid_annotation_target

import 'package:crea_chess/package/firebase/export.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_game_model.freezed.dart';
part 'live_game_model.g.dart';

/// Represents a game being currently played
@freezed
class LiveGameModel with _$LiveGameModel {
  const factory LiveGameModel({
    required String id,
    required ChallengeModel challenge,
    required String blackId,
    required String whiteId,
    required GameStatus status,
  }) = _LiveGameModel;

  /// Required for the override getter
  const LiveGameModel._();

  factory LiveGameModel.fromJson(Map<String, dynamic> json) =>
      _$LiveGameModelFromJson(json);

  // ---
}
