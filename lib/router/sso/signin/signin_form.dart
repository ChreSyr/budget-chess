import 'package:crea_chess/package/atomic_design/form/form_error.dart';
import 'package:crea_chess/package/atomic_design/form/input/input_string.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signin_form.freezed.dart';

enum SigninStatus {
  inProgress,

  // show progress indicator
  waiting,

  // show error under form fields
  editError,

  // sign in
  signinSuccess,

  // reset password
  invalidMailForResetPassword,
  resetPasswordSuccess,

  // snack bar notified errors
  invalidCredentials,
  tooManyRequests,
  unexpectedError,
}

@freezed
class SigninForm with FormzMixin, _$SigninForm {
  factory SigninForm({
    required InputString email,
    required InputString password,
    required SigninStatus status,
  }) = _SigninForm;

  /// Required for the override getter
  const SigninForm._();

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [
        email,
        password,
      ];

  String? errorMessage(
    FormzInput<dynamic, FormError> input,
    AppLocalizations l10n,
  ) {
    if (input.error == null) return null;
    if (status == SigninStatus.invalidMailForResetPassword && input == email) {
      return l10n.formError(input.error!.name);
    }
    if (status != SigninStatus.editError) return null;
    if (!inputs.contains(input)) return null;

    if (input.error == FormError.invalid && input == email) {
      return l10n.formError('notEmail');
    }

    return l10n.formError(input.error!.name);
  }
}
