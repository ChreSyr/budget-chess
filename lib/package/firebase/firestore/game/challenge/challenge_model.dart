// ignore_for_file: public_member_api_docs, invalid_annotation_target

import 'package:crea_chess/package/dartchess/export.dart';
import 'package:crea_chess/package/game/speed.dart';
import 'package:crea_chess/package/game/time_control.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge_model.freezed.dart';
part 'challenge_model.g.dart';

class ChallengeModelConverter
    implements JsonConverter<ChallengeModel, Map<String, dynamic>> {
  const ChallengeModelConverter();

  @override
  ChallengeModel fromJson(Map<String, dynamic> json) {
    return ChallengeModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(ChallengeModel data) => data.toJson();
}

@freezed
class ChallengeModel with _$ChallengeModel {
  factory ChallengeModel({
    required String id,
    DateTime? createdAt,
    DateTime? acceptedAt,
    String? authorId,
    @Default(Rule.chess) Rule rule,
    @Default(180) int time, // in seconds
    @Default(2) int increment, // in seconds
    @protected @BoardSizeConverter() BoardSize? boardSizeProtected,
    @Default(39) int budget,
  }) = _ChallengeModel;

  /// Required for the override getter
  const ChallengeModel._();

  BoardSize get boardSize => boardSizeProtected ?? BoardSize.standard;

  factory ChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeModelFromJson(json);

  // ---

  TimeControl get timeControl => TimeControl(time, increment);
  Speed get speed => timeControl.speed;

  bool get isAccepted => acceptedAt != null;

  BoardSize get setupSize => BoardSize(
        ranks: boardSize.ranks ~/ 2,
        files: boardSize.files,
      );
}
