import 'package:crea_chess/package/chessground/models.dart';
import 'package:crea_chess/package/dartchess/export.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/form/input/input_int.dart';
import 'package:crea_chess/package/form/input/input_select.dart';
import 'package:crea_chess/package/game/time_control.dart';
import 'package:crea_chess/route/play/create_challenge/create_challenge_form.dart';
import 'package:crea_chess/route/play/create_challenge/create_challenge_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateChallengeCubit extends Cubit<CreateChallengeForm> {
  CreateChallengeCubit()
      : super(
          CreateChallengeForm(
            rule: const InputSelect<Rule>.dirty(value: Rule.chess),
            timeControl: const InputSelect<TimeControl>.dirty(
              value: TimeControl(180, 2),
            ),
            budget: const InputInt.dirty(value: 39),
            boardSize: InputSelect.dirty(value: BoardSize(ranks: 8, files: 8)),
            status: CreateChallengeStatus.inProgress,
          ),
        );

  void clearStatus() =>
      emit(state.copyWith(status: CreateChallengeStatus.inProgress));

  void setRule(Rule rule) {
    emit(state.copyWith(rule: state.rule.copyWith(value: rule)));
  }

  void setTimeControl(TimeControl value) {
    emit(state.copyWith(timeControl: state.timeControl.copyWith(value: value)));
  }

  void setBudget(int value) {
    emit(state.copyWith(budget: state.budget.copyWith(value: value)));
  }

  void setBoardSize(BoardSize value) {
    emit(state.copyWith(boardSize: state.boardSize.copyWith(value: value)));
  }

  void submit({required String authorId}) {
    if (state.isNotValid) {
      return emit(state.copyWith(status: CreateChallengeStatus.editError));
    }

    emit(state.copyWith(status: CreateChallengeStatus.requestWaiting));

    try {
      challengeCRUD.create(
        data: ChallengeModel(
          id: '', // will not be stored in firebase
          createdAt: DateTime.now(),
          authorId: authorId,
          rule: state.rule.value,
          time: state.timeControl.value.time,
          increment: state.timeControl.value.increment,
          boardSize: state.boardSize.value,
          budget: state.budget.value,
        ),
      );
      emit(state.copyWith(status: CreateChallengeStatus.requestSuccess));
    } on Exception catch (_) {
      emit(state.copyWith(status: CreateChallengeStatus.requestError));
    }
  }
}
