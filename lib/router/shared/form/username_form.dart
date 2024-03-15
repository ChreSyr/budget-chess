import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/atomic_design/form/form_error.dart';
import 'package:crea_chess/package/atomic_design/form/input/input_string.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:regexpattern/regexpattern.dart';

part 'username_form.freezed.dart';

enum UsernameFormStatus {
  inProgress,

  // show progress indicator
  waiting,

  // show error under form fields
  editError,

  // show error in snack bar
  usernameTaken,
  unexpectedError,

  // name modified
  success,
}

@freezed
class UsernameForm with FormzMixin, _$UsernameForm {
  factory UsernameForm({
    required InputString name,
    required UsernameFormStatus status,
  }) = _UsernameForm;

  /// Required for the override getter
  const UsernameForm._();

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [name];

  String? errorMessage(
    FormzInput<dynamic, FormError> input,
    AppLocalizations l10n,
  ) {
    if (input.error == null) return null;
    if (status != UsernameFormStatus.editError) return null;
    if (!inputs.contains(input)) return null;

    if (input.error == FormError.invalid) {
      if (input == name) return l10n.formError('notUsername');
    }

    return l10n.formError(input.error!.name);
  }
}

class UsernameFormCubit extends Cubit<UsernameForm> {
  UsernameFormCubit(this.initialName)
      : super(
          UsernameForm(
            name: InputString.dirty(
              string: initialName,
              isRequired: true,
              regexPattern: RegexPattern.usernameV2,
            ),
            status: UsernameFormStatus.inProgress,
          ),
        );

  String initialName;

  void clearStatus() {
    emit(state.copyWith(status: UsernameFormStatus.inProgress));
  }

  void setName(String name) {
    emit(state.copyWith(name: state.name.copyWith(string: name)));
  }

  Future<void> submit() async {
    var newUsername = state.name.value;
    if (newUsername.startsWith('@')) newUsername = newUsername.substring(1);

    if (state.isNotValid) {
      return emit(state.copyWith(status: UsernameFormStatus.editError));
    }

    if (newUsername == initialName) {
      return emit(state.copyWith(status: UsernameFormStatus.success));
    }

    emit(state.copyWith(status: UsernameFormStatus.waiting));

    try {
      if (await userCRUD.usernameIsTaken(newUsername)) {
        emit(state.copyWith(status: UsernameFormStatus.usernameTaken));
        return;
      }

      await userCRUD.userCubit.setUsername(username: newUsername);
      emit(state.copyWith(status: UsernameFormStatus.success));
      initialName = newUsername;
    } catch (_) {
      emit(state.copyWith(status: UsernameFormStatus.unexpectedError));
    }
  }
}
