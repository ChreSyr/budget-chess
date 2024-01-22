import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/game/speed.dart';
import 'package:dartchess_webok/dartchess_webok.dart';
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
    if (filter.isLocal) {
      return emit(filter);
    }
    try {
      await challengeFilterCRUD.update(
        parentDocumentId: filter.userId,
        documentId: filter.id,
        data: filter,
      );
      emit(filter);
    } catch (_) {
      return;
    }
  }

  Future<void> createFilter(ChallengeFilterModel filter) async {
    if (filter.isLocal) return;
    await challengeFilterCRUD.create(
      parentDocumentId: filter.userId,
      documentId: filter.id,
      data: filter,
    );
    emit(filter);
  }

  void selectFilter(ChallengeFilterModel? filter) => emit(filter);

  void toggleRule(Rule rule) {
    if (state == null) return;
    final rules = Set<Rule>.from(state!.rules);
    if (rules.contains(rule)) {
      rules.remove(rule);
    } else {
      rules.add(rule);
    }
    _updateFilter(state!.copyWith(rules: rules));
  }

  void toggleSpeed(Speed speed) {
    if (state == null) return;
    final speeds = Set<Speed>.from(state!.speeds);
    if (speeds.contains(speed)) {
      speeds.remove(speed);
    } else {
      speeds.add(speed);
    }
    _updateFilter(state!.copyWith(speeds: speeds));
  }
}
