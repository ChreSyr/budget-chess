import 'package:crea_chess/package/form/form_error.dart';
import 'package:crea_chess/package/form/input/input_int.dart';
import 'package:crea_chess/package/form/input/input_select.dart';
import 'package:crea_chess/package/game/time_control.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:crea_chess/route/play/create_challenge/create_challenge_status.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_challenge_form.freezed.dart';

@freezed
class CreateChallengeForm with FormzMixin, _$CreateChallengeForm {
  factory CreateChallengeForm({
    required InputSelect<Rule> rule,
    required InputSelect<TimeControl> timeControl,
    required InputInt budget,
    required InputSelect<BoardSize> boardSize,
    required CreateChallengeStatus status,
  }) = _CreateChallengeForm;

  /// Required for the override getter
  const CreateChallengeForm._();

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [
        rule,
        timeControl,
        budget,
        boardSize,
      ];

  String? errorMessage(
    FormzInput<dynamic, FormError> input,
    AppLocalizations l10n,
  ) {
    if (input.error == null) return null;
    if (status != CreateChallengeStatus.editError) return null;
    if (!inputs.contains(input)) return null;

    return l10n.formError(input.error!.name);
  }
}
