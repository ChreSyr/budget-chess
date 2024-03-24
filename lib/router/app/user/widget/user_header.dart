import 'package:crea_chess/package/atomic_design/dialog/relationship/block_user.dart';
import 'package:crea_chess/package/atomic_design/dialog/relationship/cancel_relationship.dart';
import 'package:crea_chess/package/atomic_design/modal/modal.dart';
import 'package:crea_chess/package/atomic_design/modal/user/photo.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/user/modify_username_page.dart';
import 'package:crea_chess/router/app/user/widget/user_banner.dart';
import 'package:crea_chess/router/app/user/widget/user_photo.dart';
import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({
    required this.userId,
    required this.banner,
    required this.photo,
    required this.username,
    required this.isConnected,
    required this.editable,
    super.key,
  });

  factory UserHeader.notVerified({required String authId}) => UserHeader(
        userId: authId,
        banner: null,
        photo: null,
        username: null,
        isConnected: null,
        editable: false,
      );

  final String userId;
  final String? banner;
  final String? photo;
  final String? username;
  final bool? isConnected;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: CCWidgetSize.xxxlarge,
          child: Stack(
            children: [
              // banner
              UserBanner(banner, editable: editable),

              // photo
              Positioned(
                left: CCSize.small,
                bottom: 0,
                child: UserPhoto(
                  photo: photo,
                  radius: CCWidgetSize.xxsmall,
                  isConnected: isConnected == true,
                  onTap: editable
                      ? () => showMyActionsModal(context, onlyPhotos: true)
                      : null,
                ),
              ),
            ],
          ),
        ),

        // username
        ListTile(
          leading: const Icon(Icons.alternate_email),
          title: Text(username ?? ''),
          trailing: IconButton(
            onPressed: () => editable
                ? showMyActionsModal(context)
                : showUserActionsModal(context),
            icon: Icon(editable ? Icons.edit : Icons.more_horiz),
          ),
        ),
      ],
    );
  }

  void showUserActionsModal(BuildContext context) {
    final authUid = context.read<UserCubit>().state.id;

    return Modal.show(
      context: context,
      sections: [
        ListTile(
          leading: const Icon(Icons.block),
          title: Text(context.l10n.block),
          onTap: () {
            context.pop();
            showBlockUserDialog(context, userId);
          },
        ),
        StreamBuilder<RelationshipModel?>(
          stream: relationshipCRUD.stream(
            documentId: relationshipCRUD.getId(authUid, userId),
          ),
          builder: (modalContext, snapshot) {
            final relationship = snapshot.data;
            if (relationship?.statusOf(authUid) ==
                UserInRelationshipStatus.open) {
              return ListTile(
                leading: const Icon(Icons.person_remove),
                title: Text(context.l10n.friendRemove),
                onTap: () {
                  modalContext.pop();
                  showCancelRelationshipDialog(context, userId);
                },
              );
            } else {
              return Container();
            }
          },
        ),
        CCGap.large,
      ],
    );
  }

  void showMyActionsModal(BuildContext context, {bool onlyPhotos = false}) {
    return Modal.show(
      context: context,
      sections: [
        if (!kIsWeb)
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: Text(context.l10n.pictureTake),
            onTap: () async {
              context.pop();
              final photoRef =
                  await uploadProfilePhoto(ImageSource.camera, userId);
              if (photoRef == null) return;
              await userCRUD.userCubit
                  .setPhoto(photo: await photoRef.getDownloadURL());
            },
          ),
        ListTile(
          leading: const Icon(Icons.folder),
          title: Text(context.l10n.pictureImport),
          onTap: () async {
            context.pop();
            final photoRef =
                await uploadProfilePhoto(ImageSource.gallery, userId);
            if (photoRef == null) return;
            await userCRUD.userCubit
                .setPhoto(photo: await photoRef.getDownloadURL());
          },
        ),
        ListTile(
          leading: const Icon(Icons.face),
          title: Text(context.l10n.avatarChoose),
          onTap: () {
            context.pop();
            showAvatarModal(
              context,
              (avatarName) =>
                  userCRUD.userCubit.setPhoto(photo: 'avatar-$avatarName'),
            );
          },
        ),
        if (!onlyPhotos)
          ListTile(
            leading: const Icon(Icons.landscape),
            title: Text(context.l10n.bannerChoose),
            onTap: () {
              context.pop();
              showBannerModal(context);
            },
          ),
        if (!onlyPhotos)
          ListTile(
            leading: const Icon(Icons.edit),
            title: Text(context.l10n.usernameModify),
            onTap: () {
              context
                ..pop()
                ..pushRoute(ModifyUsernameRoute.i);
            },
          ),
        CCGap.large,
      ],
    );
  }
}
