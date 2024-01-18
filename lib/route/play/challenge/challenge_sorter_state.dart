// ignore_for_file: invalid_annotation_target

import 'package:crea_chess/package/firebase/firestore/challenge/challenge_model.dart';
import 'package:crea_chess/package/game/speed.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge_sorter_state.freezed.dart';
part 'challenge_sorter_state.g.dart';

@freezed
class ChallengeSorterState with _$ChallengeSorterState {
  factory ChallengeSorterState({
    Speed? speed,
    @Default(true) bool budgetAsc,
  }) = _ChallengeSorterState;

  factory ChallengeSorterState.fromJson(Map<String, dynamic> json) =>
      _$ChallengeSorterStateFromJson(json);

  /// Required for the override getter
  const ChallengeSorterState._();

  int compare(ChallengeModel a, ChallengeModel b) {
    // final timeControlA = a.timeControl;
    // final timeControlB = b.timeControl;

    // if (speed == null) {
    //   final speedA = timeControlA.speed;
    //   final speedB = timeControlB.speed;
    //   if (speedA != speedB) return speedA.compareTo(speedB);
    // }

    // final timeControlCompared = timeControlA.compareTo(timeControlB);
    // if (timeControlCompared != 0) return timeControlCompared;

    return (budgetAsc ? 1 : -1) * a.budget.compareTo(b.budget);
  }
}
