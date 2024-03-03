import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/field/input_decoration.dart';
import 'package:crea_chess/package/atomic_design/modal/user/photo.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/form/form_error.dart';
import 'package:crea_chess/package/form/input/input_string.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
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
  start(0),
  username(1),
  photo(2);

  const ProfileFormStep(this.value);

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

  final int value;
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

  Future<void> waitPhoto(Future<void> Function() getPhoto) async {
    emit(
      state.copyWith(
        status: ProfileFormStatus.waiting,
        step: ProfileFormStep.photo,
      ),
    );
    await getPhoto();
    emit(
      state.copyWith(
        status: ProfileFormStatus.inProgress,
        step: ProfileFormStep.photo,
      ),
    );
  }

  void setPhoto(String photo) {
    emit(state.copyWith(photo: state.photo.copyWith(string: photo)));
  }

  void tempReset() => emit(state.copyWith(step: ProfileFormStep.start));

  void submitStart() => emit(state.copyWith(step: ProfileFormStep.username));

  Future<void> submitName() async {
    var newUsername = state.name.value;
    if (newUsername.startsWith('@')) newUsername = newUsername.substring(1);

    if (newUsername == initialUser.username) {
      return emit(
        state.copyWith(
          status: ProfileFormStatus.success,
          step: ProfileFormStep.photo,
        ),
      );
    }

    if (state.name.isNotValid) {
      return emit(
        state.copyWith(
          status: ProfileFormStatus.editError,
          step: ProfileFormStep.username,
        ),
      );
    }

    emit(
      state.copyWith(
        status: ProfileFormStatus.waiting,
        step: ProfileFormStep.username,
      ),
    );

    try {
      if (await userCRUD.usernameIsTaken(newUsername)) {
        emit(state.copyWith(status: ProfileFormStatus.usernameTaken));
        return;
      }

      await userCRUD.userCubit.setUsername(username: newUsername);
      emit(
        state.copyWith(
          status: ProfileFormStatus.success,
          step: ProfileFormStep.photo,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: ProfileFormStatus.unexpectedError));
    }
  }

  Future<void> submitPhoto() async {
    final newPhoto = state.photo.value;

    if (newPhoto == initialUser.photo) {
      return emit(
        state.copyWith(
          status: ProfileFormStatus.success,
        ),
      );
    }

    if (state.photo.isNotValid) {
      return emit(
        state.copyWith(
          status: ProfileFormStatus.editError,
        ),
      );
    }

    emit(
      state.copyWith(
        status: ProfileFormStatus.waiting,
      ),
    );

    try {
      await userCRUD.userCubit.setPhoto(photo: newPhoto);
      emit(
        state.copyWith(
          status: ProfileFormStatus.success,
        ),
      );
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
    var oldStep = profileFormCubit.state.step;
    final scrollController = ScrollController();

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
        if (oldStep != form.step) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // Delay the scroll to give TextField enough time to complete
            // autofocus
            Future.delayed(const Duration(milliseconds: 500), () {
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            });
          });
          oldStep = form.step;
        }
      },
      builder: (context, form) {
        return SingleChildScrollView(
          controller: scrollController,
          child: CCPadding.horizontalXxlarge(
            child: SizedBox(
              width: CCWidgetSize.large4,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(CCSize.xlarge),
                      topRight: Radius.circular(CCSize.xlarge),
                      bottomLeft: Radius.circular(CCSize.xlarge),
                      bottomRight: Radius.circular(CCWidgetSize.xlarge),
                    ),
                    child: Stack(
                      children: [
                        Image.asset('assets/images/signin.jpg'),
                        CCPadding.allMedium(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome to', // TODO : l10n
                                style:
                                    CCTextStyle.displaySmall(context)?.copyWith(
                                  color: CCColor.background(context),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Budget Chess', // TODO : l10n
                                style:
                                    CCTextStyle.titleLarge(context)?.copyWith(
                                  color: CCColor.background(context),
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  CCGap.xxlarge,
                  OutlinedButton(
                    onPressed: profileFormCubit.submitStart,
                    // TODO : l10n
                    child: const Text("Let's start by creating your profile !"),
                  ),
                  CCGap.xxlarge,
                  CCGap.xxlarge,
                  const UsernameField(),
                  const PhotoField(),
                ],
              ),
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
        if (form.step.value < ProfileFormStep.username.value) {
          return CCGap.zero;
        }

        if (textController.text != form.name.value) {
          textController.text = form.name.value;
        }

        return Column(
          children: [
            if (form.status == ProfileFormStatus.waiting &&
                form.step == ProfileFormStep.username)
              const LinearProgressIndicator(),
            const Text(
              '👀',
              style: TextStyle(fontSize: CCSize.xxlarge),
              textAlign: TextAlign.center,
            ),
            Text(
              context.l10n.chooseGoodUsername,
              textAlign: TextAlign.center,
            ),
            CCGap.large,
            TextFormField(
              autofocus: form.step == ProfileFormStep.username,
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
              onFieldSubmitted: (_) => cubit.submitName(),
            ),
            CCGap.xxlarge,
            FilledButton(
              onPressed: form.name.isValid
                  ? () {
                      cubit.submitName();
                      FocusScope.of(context).unfocus();
                    }
                  : null,
              child: Text(context.l10n.next),
            ),
            CCGap.xxlarge,
            CCGap.xxlarge,
          ],
        );
      },
    );
  }
}

class PhotoField extends StatelessWidget {
  const PhotoField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ProfileFormCubit>();
    final form = cubit.state;

    if (form.step.value < ProfileFormStep.photo.value) {
      return CCGap.zero;
    }

    return Column(
      children: [
        if (form.status == ProfileFormStatus.waiting &&
            form.step == ProfileFormStep.photo)
          const LinearProgressIndicator(),
        UserPhoto(
          photo: form.photo.value,
          radius: CCSize.xxxlarge,
        ),
        CCGap.medium,
        const Text(
          // TODO : l10n
          'Choississez un avatar ou une de vos photo !',
          textAlign: TextAlign.center,
        ),
        CCGap.large,
        if (!kIsWeb)
          ListTile(
            leading: const Icon(Icons.add_a_photo),
            title: Text(context.l10n.pictureTake),
            onTap: () {
              cubit.waitPhoto(() async {
                final photoRef = await uploadProfilePhoto(
                  ImageSource.camera,
                  cubit.initialUser.id,
                );
                if (photoRef == null) return;
                cubit.setPhoto(await photoRef.getDownloadURL());
              });
            },
          ),
        ListTile(
          leading: const Icon(Icons.drive_folder_upload),
          title: Text(context.l10n.pictureImport),
          onTap: () {
            cubit.waitPhoto(() async {
              final photoRef = await uploadProfilePhoto(
                ImageSource.gallery,
                cubit.initialUser.id,
              );
              if (photoRef == null) return;
              cubit.setPhoto(await photoRef.getDownloadURL());
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(context.l10n.avatarChoose),
          onTap: () {
            showAvatarModal(
              context,
              (avatarName) => cubit.setPhoto('avatar-$avatarName'),
            );
          },
        ),
        CCGap.xxlarge,
        FilledButton(
          onPressed: form.photo.isValid ? cubit.submitPhoto : null,
          child: Text(context.l10n.save),
        ),
        CCGap.xxlarge,
        CCGap.xxlarge,
        CCGap.xxlarge,
        CCGap.xxlarge,
        CCGap.xxlarge,
        CCGap.xxlarge,
      ],
    );
  }
}
