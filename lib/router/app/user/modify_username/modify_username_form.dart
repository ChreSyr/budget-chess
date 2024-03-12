import 'package:crea_chess/package/form/form_error.dart';
import 'package:crea_chess/package/form/input/input_string.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/user/modify_username/modify_username_status.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'modify_username_form.freezed.dart';

@freezed
class ModifyUsernameForm with FormzMixin, _$ModifyUsernameForm {
  factory ModifyUsernameForm({
    required InputString name,
    required ModifyUsernameStatus status,
  }) = _ModifyUsernameForm;

  /// Required for the override getter
  const ModifyUsernameForm._();

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [name];

  String? errorMessage(
    FormzInput<dynamic, FormError> input,
    AppLocalizations l10n,
  ) {
    if (input.error == null) return null;
    if (status != ModifyUsernameStatus.editError) return null;
    if (!inputs.contains(input)) return null;

    if (input.error == FormError.invalid) {
      if (input == name) return l10n.formError('notUsername');
    }

    return l10n.formError(input.error!.name);
  }
}
