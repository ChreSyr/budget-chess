import 'package:crea_chess/package/atomic_design/field/input_decoration.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
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

enum ProfileFormStep {
  start,
  username,
  photo;

  factory ProfileFormStep.init(UserModel user) {
    if (user.username.isEmpty || user.username == user.id) {
      return start;
    } else if (user.photo == null || user.photo!.isEmpty) {
      return photo;
    } else {
      // the profile is already completed
      return username;
    }
  }
}

@freezed
class ProfileForm with FormzMixin, _$ProfileForm {
  factory ProfileForm({
    required InputString name,
    required InputString photo,
    required ProfileFormStatus status,
    required ProfileFormStep step,
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
            step: ProfileFormStep.init(initialUser),
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

  Future<void> submitName() async {
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
        appBar: AppBar(),
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
        return CCPadding.allXxlarge(
          child: SizedBox(
            width: CCWidgetSize.large4,
            child: Column(
              children: [
                if (form.status == ProfileFormStatus.waiting)
                  const LinearProgressIndicator(),

                const UsernameField(),

                CCGap.xlarge,

                // sign in button
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(
                    onPressed: profileFormCubit.submitName,
                    child: Text(context.l10n.save),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class UsernameField extends StatelessWidget {
  const UsernameField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileFormCubit>();
    final textController =
        TextEditingController(text: cubit.initialUser.username);

    return BlocBuilder<ProfileFormCubit, ProfileForm>(
      builder: (context, form) {
        if (textController.text != form.name.value) {
          textController.text = form.name.value;
        }

        return Column(
          children: [
            Row(
              children: [
                Expanded(child: Text(context.l10n.chooseGoodUsername)),
                const Text(
                  '👀',
                  style: TextStyle(fontSize: CCWidgetSize.xxsmall),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            CCGap.small,
            TextFormField(
              autofocus: true,
              controller: textController,
              decoration: CCInputDecoration(
                labelText: 'Username', // TODO : l10n
                errorText: form.errorMessage(form.name, context.l10n),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => cubit.setName(''),
                ),
              ),
              onChanged: cubit.setName,
            ),
          ],
        );
      },
    );
  }
}
