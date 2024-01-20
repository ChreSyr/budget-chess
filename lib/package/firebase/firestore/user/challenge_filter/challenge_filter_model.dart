// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/firebase/firestore/challenge/challenge_model.dart';
import 'package:crea_chess/package/game/speed.dart';
import 'package:dartchess_webok/dartchess_webok.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge_filter_model.freezed.dart';
part 'challenge_filter_model.g.dart';

@freezed
class ChallengeFilterModel with _$ChallengeFilterModel {
  factory ChallengeFilterModel({
    String? userId,
    String? id,
    @Default({Speed.bullet, Speed.blitz, Speed.rapid, Speed.classical})
    Set<Speed> speeds,
    @Default({Rules.chess}) Set<Rules> rules,
  }) = _ChallengeSorterState;

  /// Required for the override getter
  const ChallengeFilterModel._();

  factory ChallengeFilterModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeFilterModelFromJson(json);

  factory ChallengeFilterModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    return ChallengeFilterModel.fromJson(doc.data() ?? {})
        .copyWith(userId: doc.reference.parent.parent?.id, id: doc.id);
  }

  Map<String, dynamic> toFirestore() {
    return toJson()
      ..removeWhere(
        (key, value) => key == 'id' || key == 'userId' || value == null,
      );
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