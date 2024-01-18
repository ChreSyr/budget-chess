import 'package:crea_chess/package/game/speed.dart';
import 'package:crea_chess/route/play/challenge/challenge_sorter_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ChallengeSorterCubit extends HydratedCubit<ChallengeSorterState> {
  ChallengeSorterCubit() : super(ChallengeSorterState());

  @override
  ChallengeSorterState? fromJson(Map<String, dynamic> json) {
    return ChallengeSorterState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ChallengeSorterState state) {
    return state.toJson();
  }

  // ignore: avoid_positional_boolean_parameters
  void setBudgetAsc(bool val) => emit(state.copyWith(budgetAsc: val));

  void setSpeed(Speed? speed) => emit(state.copyWith(speed: speed));
}
