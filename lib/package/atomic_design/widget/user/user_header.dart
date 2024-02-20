import 'dart:io';

import 'package:crea_chess/package/atomic_design/dialog/relationship/block_user.dart';
import 'package:crea_chess/package/atomic_design/dialog/relationship/cancel_relationship.dart';
import 'package:crea_chess/package/atomic_design/modal/modal.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/atomic_design/widget/edit_button.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_banner.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    required this.editable,
    super.key,
  });

  factory UserHeader.notVerified({required String authId}) => UserHeader(
        userId: authId,
        banner: null,
        photo: null,
        username: null,
        editable: false,
      );

  final String userId;
  final String? banner;
  final String? photo;
  final String? username;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topCenter, children: [
      const SizedBox(height: 250),
      UserBanner(banner),
      Positioned(
        top: 60,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            UserPhoto(
              photo: photo,
              radius: CCWidgetSize.xxsmall,
              backgroundColor: photo == null ? Colors.red[100] : null,
            ),
            if (editable)
              Positioned(
                child: EditButton(
                  onPressed: () => showPhotoModal(context),
                  priorityHigh: (photo ?? '').isEmpty,
                ),
              ),
          ],
        ),
      ),
      Positioned(
          bottom: 10,
          child: Text(
            username ?? '',
            style: CCTextStyle.titleLarge(context),
          ))
    ]);
  }

  void showUserActionsModal(BuildContext context) {
    final currentUserId = context.read<UserCubit>().state?.id;
    if (currentUserId == null) return; // should never happen

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
            documentId: relationshipCRUD.getId(currentUserId, userId),
          ),
          builder: (modalContext, snapshot) {
            final relationship = snapshot.data;
            if (relationship?.status == RelationshipStatus.friends) {
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
      ],
    );
  }

  void showBannerModal(BuildContext context) {
    Modal.show(
      context: context,
      sections: [
        GridView.count(
          shrinkWrap: true,
          childAspectRatio: 3,
          crossAxisCount: 2,
          crossAxisSpacing: CCSize.large,
          mainAxisSpacing: CCSize.large,
          children: bannerNames
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    userCRUD.userCubit.setBanner(banner: e);
                    context.pop();
                  },
                  child: UserBanner(e),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  void showPhotoModal(BuildContext context) {
    return Modal.show(
      context: context,
      sections: [
        if (!kIsWeb)
          ListTile(
            leading: const Icon(Icons.add_a_photo),
            title: Text(context.l10n.pictureTake),
            onTap: () {
              context.pop();
              uploadProfilePhoto(ImageSource.camera);
            },
          ),
        ListTile(
          leading: const Icon(Icons.drive_folder_upload),
          title: Text(context.l10n.pictureImport),
          onTap: () {
            context.pop();
            uploadProfilePhoto(ImageSource.gallery);
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(context.l10n.avatarChoose),
          onTap: () {
            context.pop();
            showAvatarModal(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.landscape),
          title: Text(context.l10n.bannerChoose),
          onTap: () {
            context.pop();
            showBannerModal(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.edit),
          title: Text(context.l10n.nameChoose),
          onTap: () {
            if (editable) {
              context.pop();
              context.push('/user/modify_name');
            } else {
              showUserActionsModal(context);
            }
          },
        ),
      ],
    );
  }

  void showAvatarModal(BuildContext context) {
    Modal.show(
      context: context,
      sections: [
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: CustomScrollView(
            primary: false,
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(CCSize.large),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: CCSize.medium,
                    mainAxisSpacing: CCSize.medium,
                    crossAxisCount: 4,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final e = avatarNames[index];
                      return GestureDetector(
                        onTap: () {
                          userCRUD.userCubit.setPhoto(photo: 'avatar-$e');
                          context.pop();
                        },
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/avatar/$e.jpg'),
                        ),
                      );
                    },
                    childCount: avatarNames.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> uploadProfilePhoto(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile == null) return;

    final photoRef = FirebaseStorage.instance.getUserPhotoRef(userId);
    await photoRef.putFile(File(pickedFile.path));
    await userCRUD.userCubit.setPhoto(photo: await photoRef.getDownloadURL());
  }
}
