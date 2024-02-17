// ignore_for_file: public_member_api_docs, invalid_annotation_target

import 'package:crea_chess/package/firebase/export.dart';
import 'package:dartchess_webok/dartchess_webok.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_model.freezed.dart';
part 'game_model.g.dart';

/// Represents a game being currently played
@freezed
class GameModel with _$GameModel {
  const factory GameModel({
    required String id,
    required ChallengeModel challenge,
    required String blackId,
    required String whiteId,
    required GameStatus status,
    String? blackHalfFen, // starting position of black pieces
    String? whiteHalfFen, // starting position of white pieces
    @Default([]) List<String> moves,
    Side? winner, // if status is ended & winner is null : draw
  }) = _GameModel;

  /// Required for the override getter
  const GameModel._();

  factory GameModel.fromJson(Map<String, dynamic> json) =>
      _$GameModelFromJson(json);

  // ---
}
