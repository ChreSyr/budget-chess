import 'package:crea_chess/package/atomic_design/field/input_decoration.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/widget/body_template.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/form/form_error.dart';
import 'package:crea_chess/package/form/input/input_string.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:regexpattern/regexpattern.dart';

part 'profile_completer.freezed.dart';

enum ProfileFormStatus {
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
class ProfileForm with FormzMixin, _$ProfileForm {
  factory ProfileForm({
    required InputString name,
    required InputString photo,
    required ProfileFormStatus status,
  }) = _ProfileForm;

  /// Required for the override getter
  const ProfileForm._();

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [name, photo];

  String? errorMessage(
    FormzInput<dynamic, FormError> input,
    AppLocalizations l10n,
  ) {
    if (input.error == null) return null;
    if (status != ProfileFormStatus.editError) return null;
    if (!inputs.contains(input)) return null;

    if (input.error == FormError.invalid) {
      if (input == name) return l10n.formError('notUsername');
    }

    return l10n.formError(input.error!.name);
  }
}

class ProfileFormCubit extends Cubit<ProfileForm> {
  ProfileFormCubit(this.initialUser)
      : super(
          ProfileForm(
            name: InputString.dirty(
              string: initialUser.username,
              isRequired: true,
              regexPattern: RegexPattern.usernameV2,
            ),
            photo: InputString.dirty(
              string: initialUser.photo ?? '',
              isRequired: true,
            ),
            status: ProfileFormStatus.inProgress,
          ),
        );

  final UserModel initialUser;

  void clearFailure() {
    emit(state.copyWith(status: ProfileFormStatus.inProgress));
  }

  void setName(String name) {
    emit(state.copyWith(name: state.name.copyWith(string: name)));
  }

  void setPhoto(String photo) {
    emit(state.copyWith(name: state.photo.copyWith(string: photo)));
  }

  Future<void> submit() async {
    var newUsername = state.name.value;
    if (newUsername.startsWith('@')) newUsername = newUsername.substring(1);

    if (newUsername == initialUser.username) {
      return emit(state.copyWith(status: ProfileFormStatus.success));
    }

    if (state.isNotValid) {
      return emit(state.copyWith(status: ProfileFormStatus.editError));
    }

    emit(state.copyWith(status: ProfileFormStatus.waiting));

    try {
      if (await userCRUD.usernameIsTaken(newUsername)) {
        emit(state.copyWith(status: ProfileFormStatus.usernameTaken));
        return;
      }

      await userCRUD.userCubit.setUsername(username: newUsername);
      emit(state.copyWith(status: ProfileFormStatus.success));
    } catch (_) {
      emit(state.copyWith(status: ProfileFormStatus.unexpectedError));
    }
  }
}

class ProfileCompleter extends StatelessWidget {
  const ProfileCompleter({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
    if (user != null && user.profileCompleted == false) {
      return Scaffold(
        body: BlocProvider(
          create: (context) => ProfileFormCubit(user),
          child: _ProfileCompleter(user),
        ),
      );
    }
    return child;
  }
}

class _ProfileCompleter extends StatelessWidget {
  const _ProfileCompleter(this.user);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final profileFormCubit = context.read<ProfileFormCubit>();
    final textController = TextEditingController(text: user.username);

    return BlocConsumer<ProfileFormCubit, ProfileForm>(
      listener: (context, form) {
        switch (form.status) {
          case ProfileFormStatus.usernameTaken:
          case ProfileFormStatus.unexpectedError:
            snackBarError(
              context,
              context.l10n.formError(form.status.name),
            );
            profileFormCubit.clearFailure();
          case ProfileFormStatus.success:
            while (context.canPop()) {
              context.pop();
            }
          case _:
            break;
        }
      },
      builder: (context, form) {
        if (textController.text != form.name.value) {
          textController.text = form.name.value;
        }

        return BodyTemplate(
          loading: form.status == ProfileFormStatus.waiting,
          emoji: '👀',
          title: context.l10n.chooseGoodUsername,
          children: [
            // mail field
            TextFormField(
              autofocus: true,
              controller: textController,
              decoration: CCInputDecoration(
                errorText: form.errorMessage(form.name, context.l10n),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => profileFormCubit.setName(''),
                ),
              ),
              onChanged: profileFormCubit.setName,
            ),

            CCGap.xlarge,

            // sign in button
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: profileFormCubit.submit,
                child: Text(context.l10n.save),
              ),
            ),
          ],
        );
      },
    );
  }
}
