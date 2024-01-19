// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/firebase/firestore/challenge/challenge_model.dart';
import 'package:crea_chess/package/game/speed.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge_filter_model.freezed.dart';
part 'challenge_filter_model.g.dart';

@freezed
class ChallengeFilterModel with _$ChallengeFilterModel {
  factory ChallengeFilterModel({
    String? id,
    @Default({}) Set<Speed> speed,
    @Default(true) bool budgetAsc,
  }) = _ChallengeSorterState;

  /// Required for the override getter
  const ChallengeFilterModel._();

  factory ChallengeFilterModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeFilterModelFromJson(json);

  factory ChallengeFilterModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    return ChallengeFilterModel.fromJson(doc.data() ?? {}).copyWith(id: doc.id);
  }

  Map<String, dynamic> toFirestore() {
    return toJson()..removeWhere((key, value) => key == 'id' || value == null);
  }

  int compare(ChallengeModel a, ChallengeModel b) {
    final timeControlA = a.timeControl;
    final timeControlB = b.timeControl;

    final speedA = timeControlA.speed;
    final speedB = timeControlB.speed;
    if (speedA != speedB) return speedA.compareTo(speedB);

    final timeControlCompared = timeControlA.compareTo(timeControlB);
    if (timeControlCompared != 0) return timeControlCompared;

    final budgetAscCompared =
        (budgetAsc ? 1 : -1) * a.budget.compareTo(b.budget);
    if (budgetAscCompared != 0) return budgetAscCompared;

    return 0;
  }
}
