import 'package:crea_chess/package/firebase/firestore/user/challenge_filter/challenge_filter_model.dart';
import 'package:crea_chess/package/game/speed.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ChallengeFilterCubit extends HydratedCubit<ChallengeFilterModel> {
  ChallengeFilterCubit()
      : super(ChallengeFilterModel(speed: Speed.values.toSet()));

  @override
  ChallengeFilterModel? fromJson(Map<String, dynamic> json) {
    return ChallengeFilterModel.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ChallengeFilterModel state) {
    return state.toJson();
  }

  // ignore: avoid_positional_boolean_parameters
  void setBudgetAsc(bool val) => emit(state.copyWith(budgetAsc: val));

  void toggleSpeed(Speed speed) {
    final speeds = Set<Speed>.from(state.speed);
    if (speeds.contains(speed)) {
      speeds.remove(speed);
    } else {
      speeds.add(speed);
    }
    emit(state.copyWith(speed: speeds));
  }
}
