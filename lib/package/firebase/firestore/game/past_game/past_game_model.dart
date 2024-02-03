// ignore_for_file: public_member_api_docs, invalid_annotation_target

import 'package:crea_chess/package/firebase/export.dart';
import 'package:dartchess_webok/dartchess_webok.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'past_game_model.freezed.dart';
part 'past_game_model.g.dart';

/// Represents a game who ended
@freezed
class PastGameModel with _$PastGameModel {
  const factory PastGameModel({
    required String id,
    required ChallengeModel challenge,
    required String blackId,
    required String whiteId,
    required String pgn,
    required GameStatus status,
    Side? winner, // if status is ended & winner is null : draw
  }) = _PastGameModel;

  /// Required for the override getter
  const PastGameModel._();

  factory PastGameModel.fromJson(Map<String, dynamic> json) =>
      _$PastGameModelFromJson(json);

  // ---
}
