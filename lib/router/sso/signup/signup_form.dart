import 'package:crea_chess/package/atomic_design/form/form_error.dart';
import 'package:crea_chess/package/atomic_design/form/input/input_boolean.dart';
import 'package:crea_chess/package/atomic_design/form/input/input_string.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:regexpattern/regexpattern.dart';

part 'signup_form.freezed.dart';

enum SignupStatus {
  inProgress,

  // show progress indicator
  waiting,

  // show error under form fields
  editError,

  // sign up
  signupSuccess,
  unexpectedError,

  // snack bar notified errors
  mailTaken,
}

@freezed
class SignupForm with FormzMixin, _$SignupForm {
  factory SignupForm({
    required InputString email,
    required InputString password,
    required InputBoolean acceptConditions,
    required SignupStatus status,
  }) = _SignupForm;

  /// Required for the override getter
  const SignupForm._();

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [
        email,
        password,
        acceptConditions,
      ];

  String? errorMessage(
    FormzInput<dynamic, FormError> input,
    AppLocalizations l10n,
  ) {
    if (input.error == null) return null;
    if (status != SignupStatus.editError) return null;
    if (!inputs.contains(input)) return null;

    if (input.error == FormError.invalid) {
      if (input is InputString && input.regexPattern == RegexPattern.email) {
        return l10n.formError('notEmail');
      }
      if (input is InputString &&
          input.regexPattern == RegexPattern.passwordNormal3) {
        return l10n.formError('notPassword');
      }
    }

    return l10n.formError(input.error!.name);
  }
}
