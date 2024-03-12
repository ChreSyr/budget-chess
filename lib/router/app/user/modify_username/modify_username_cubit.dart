import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/form/input/input_string.dart';
import 'package:crea_chess/router/app/user/modify_username/modify_username_form.dart';
import 'package:crea_chess/router/app/user/modify_username/modify_username_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexpattern/regexpattern.dart';

class ModifyUsernameCubit extends Cubit<ModifyUsernameForm> {
  ModifyUsernameCubit(this.initialName)
      : super(
          ModifyUsernameForm(
            name: InputString.dirty(
              string: initialName,
              isRequired: true,
              regexPattern: RegexPattern.usernameV2,
            ),
            status: ModifyUsernameStatus.inProgress,
          ),
        );

  final String initialName;

  void clearFailure() {
    emit(state.copyWith(status: ModifyUsernameStatus.inProgress));
  }

  void setName(String name) {
    emit(state.copyWith(name: state.name.copyWith(string: name)));
  }

  Future<void> submit() async {
    var newUsername = state.name.value;
    if (newUsername.startsWith('@')) newUsername = newUsername.substring(1);

    if (newUsername == initialName) {
      return emit(state.copyWith(status: ModifyUsernameStatus.success));
    }

    if (state.isNotValid) {
      return emit(state.copyWith(status: ModifyUsernameStatus.editError));
    }

    emit(state.copyWith(status: ModifyUsernameStatus.waiting));

    try {
      if (await userCRUD.usernameIsTaken(newUsername)) {
        emit(state.copyWith(status: ModifyUsernameStatus.usernameTaken));
        return;
      }

      await userCRUD.userCubit.setUsername(username: newUsername);
      emit(state.copyWith(status: ModifyUsernameStatus.success));
    } catch (_) {
      emit(state.copyWith(status: ModifyUsernameStatus.unexpectedError));
    }
  }
}
