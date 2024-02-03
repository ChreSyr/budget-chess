// ignore_for_file: public_member_api_docs, invalid_annotation_target

import 'package:crea_chess/package/game/speed.dart';
import 'package:crea_chess/package/game/time_control.dart';
import 'package:dartchess_webok/dartchess_webok.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge_model.freezed.dart';
part 'challenge_model.g.dart';

@freezed
class ChallengeModel with _$ChallengeModel {
  const factory ChallengeModel({
    required String id,
    DateTime? createdAt,
    DateTime? acceptedAt,
    String? authorId,
    @Default(Rule.chess) Rule rule,
    @Default(180) int time, // in seconds
    @Default(2) int increment, // in seconds
    @Default(8) int boardWidth,
    @Default(8) int boardHeight,
    @Default(39) int budget,
  }) = _ChallengeModel;

  /// Required for the override getter
  const ChallengeModel._();

  factory ChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeModelFromJson(json);

  // ---

  TimeControl get timeControl => TimeControl(time, increment);
  Speed get speed => timeControl.speed;
}
