// ignore_for_file: invalid_annotation_target

import 'package:crea_chess/package/firebase/firestore/game/challenge/challenge_model.dart';
import 'package:crea_chess/package/game/speed.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge_filter_model.freezed.dart';
part 'challenge_filter_model.g.dart';

@freezed
class ChallengeFilterModel with _$ChallengeFilterModel {
  factory ChallengeFilterModel({
    @Default(ChallengeFilterModel._local) String userId,
    @Default(ChallengeFilterModel._local) String id,
    @Default({Speed.bullet, Speed.blitz, Speed.rapid, Speed.classical})
    Set<Speed> speeds,
    @Default({Rule.chess}) Set<Rule> rules,
  }) = _ChallengeSorterState;

  /// Required for the override getter
  const ChallengeFilterModel._();

  factory ChallengeFilterModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeFilterModelFromJson(json);

  // ---

  static const String _local = 'local';

  static ChallengeFilterModel sorter = ChallengeFilterModel(
    speeds: Speed.values.toSet(),
    rules: Rule.values.toSet(),
  );

  static ChallengeFilterModel default1 = ChallengeFilterModel(
    speeds: {Speed.bullet, Speed.blitz},
  );

  static ChallengeFilterModel default2 = ChallengeFilterModel(
    speeds: {Speed.blitz, Speed.rapid},
  );

  static ChallengeFilterModel default3 = ChallengeFilterModel(
    speeds: {},
  );

  static List<ChallengeFilterModel> defaults = [
    ChallengeFilterModel.default1,
    ChallengeFilterModel.default2,
    ChallengeFilterModel.default3,
  ];

  bool get isEmpty => rules.isEmpty && speeds.isEmpty;

  bool get isLocal =>
      userId == ChallengeFilterModel._local ||
      id == ChallengeFilterModel._local;

  bool accept(ChallengeModel challenge) {
    return (rules.isEmpty || rules.contains(challenge.rule)) &&
        (speeds.isEmpty || speeds.contains(challenge.speed));
  }

  int compare(ChallengeModel a, ChallengeModel b) {
    final timeControlA = a.timeControl;
    final timeControlB = b.timeControl;

    final speedA = timeControlA.speed;
    final speedB = timeControlB.speed;
    if (speedA != speedB) return speedA.compareTo(speedB);

    final timeControlCompared = timeControlA.compareTo(timeControlB);
    if (timeControlCompared != 0) return timeControlCompared;

    return 0;
  }
}
