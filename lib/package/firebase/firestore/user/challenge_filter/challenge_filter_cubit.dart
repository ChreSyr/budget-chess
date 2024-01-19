import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/game/speed.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ChallengeFilterCubit extends HydratedCubit<ChallengeFilterModel?> {
  ChallengeFilterCubit() : super(null);

  @override
  ChallengeFilterModel? fromJson(Map<String, dynamic> json) {
    return ChallengeFilterModel.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ChallengeFilterModel? state) {
    return state?.toJson();
  }

  Future<void> _updateFilter(ChallengeFilterModel filter) async {
    try {
      await challengeFilterCRUD.update(
        parentDocumentId: filter.userId ?? '',
        documentId: filter.id ?? '',
        data: filter,
      );
      emit(filter);
    } catch (_) {
      return;
    }
  }

  // ignore: avoid_positional_boolean_parameters
  void setBudgetAsc(bool val) {
    if (state == null) return;
    _updateFilter(state!.copyWith(budgetAsc: val));
  }

  void selectFilter(ChallengeFilterModel? filter) => emit(filter);

  void toggleSpeed(Speed speed) {
    if (state == null) return;
    final speeds = Set<Speed>.from(state!.speed);
    if (speeds.contains(speed)) {
      speeds.remove(speed);
    } else {
      speeds.add(speed);
    }
    if (speeds.isEmpty) return;
    _updateFilter(state!.copyWith(speed: speeds));
  }
}
