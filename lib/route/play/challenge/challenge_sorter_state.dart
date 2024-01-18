// ignore_for_file: invalid_annotation_target

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
}
