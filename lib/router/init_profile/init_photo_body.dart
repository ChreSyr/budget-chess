import 'dart:math';

import 'package:crea_chess/package/atomic_design/modal/user/photo.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/widget/body_template.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_cubit.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/shared/emergency_app_bar.dart';
import 'package:crea_chess/router/shared/form/photo_form.dart';
import 'package:crea_chess/router/shared/route_body.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class InitPhotoBody extends RouteBody {
  const InitPhotoBody({super.key});

  @override
  List<Widget> getActions(BuildContext context) {
    return getEmergencyAppBarActions(context);
  }

  @override
  String getTitle(AppLocalizations l10n) => '';

  @override
  Widget build(BuildContext context) {
    final initialPhoto = context.read<UserCubit>().state.photo ??
        'avatar-${avatarNames[Random().nextInt(avatarNames.length)]}';
    final photoFormCubit = PhotoFormCubit(initialPhoto);

    return BlocProvider(
      create: (context) => photoFormCubit,
      child: BlocConsumer<PhotoFormCubit, PhotoForm>(
        listener: (context, form) {
          switch (form.status) {
            case PhotoFormStatus.unexpectedError:
              snackBarError(
                context,
                context.l10n.formError(form.status.name),
              );
              photoFormCubit.clearStatus();
            case PhotoFormStatus.success:
              photoFormCubit.clearStatus();
              context.go('/');
            case _:
              break;
          }
        },
        builder: (context, form) {
          return BodyTemplate(
            loading: form.status == PhotoFormStatus.waiting,
            children: [
              Center(
                child: UserPhoto(
                  photo: form.photo.value,
                  radius: CCSize.xxxlarge,
                ),
              ),
              CCGap.medium,
              const Text(
                // TODO : l10n
                'Choississez un avatar ou une de vos photo !',
                textAlign: TextAlign.center,
              ),
              CCGap.xxlarge,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!kIsWeb) ...[
                    _PhotoAction(
                      icon: Icons.photo_camera,
                      title: context.l10n.pictureTake,
                      onTap: () {
                        photoFormCubit.waitPhoto(() async {
                          final photoRef = await uploadProfilePhoto(
                            ImageSource.camera,
                            photoFormCubit.initialPhoto,
                          );
                          if (photoRef == null) return;
                          photoFormCubit
                              .setPhoto(await photoRef.getDownloadURL());
                        });
                      },
                    ),
                    CCGap.large,
                  ],
                  _PhotoAction(
                    icon: Icons.folder,
                    title: context.l10n.pictureImport,
                    onTap: () {
                      photoFormCubit.waitPhoto(() async {
                        final photoRef = await uploadProfilePhoto(
                          ImageSource.gallery,
                          photoFormCubit.initialPhoto,
                        );
                        if (photoRef == null) return;
                        photoFormCubit
                            .setPhoto(await photoRef.getDownloadURL());
                      });
                    },
                  ),
                  CCGap.large,
                  _PhotoAction(
                    icon: Icons.face,
                    title: context.l10n.avatarChoose,
                    onTap: () {
                      showAvatarModal(
                        context,
                        (avatarName) =>
                            photoFormCubit.setPhoto('avatar-$avatarName'),
                      );
                    },
                  ),
                ],
              ),
              CCGap.xxlarge,
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: form.photo.isValid ? photoFormCubit.submit : null,
                  child: Text(context.l10n.save),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PhotoAction extends StatelessWidget {
  const _PhotoAction({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: CCWidgetSize.xsmall,
      child: Column(
        children: [
          IconButton.filledTonal(
            icon: Icon(icon),
            style: const ButtonStyle(
              iconSize: MaterialStatePropertyAll(CCWidgetSize.xxxsmall),
              padding: MaterialStatePropertyAll(EdgeInsets.all(CCSize.medium)),
            ),
            onPressed: onTap,
          ),
          CCGap.small,
          Text(
            title,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
