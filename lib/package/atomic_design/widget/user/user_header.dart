import 'package:crea_chess/package/atomic_design/dialog/relationship/block_user.dart';
import 'package:crea_chess/package/atomic_design/dialog/relationship/cancel_relationship.dart';
import 'package:crea_chess/package/atomic_design/modal/modal.dart';
import 'package:crea_chess/package/atomic_design/modal/user/photo.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/edit_button.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_banner.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
        Stack(
          children: [
            const SizedBox(height: CCWidgetSize.xxxlarge),

            // banner
            Stack(
              children: [
                UserBanner(banner),
                if (editable)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child:
                        EditButton(onPressed: () => showBannerModal(context)),
                  ),
              ],
            ),

            // photo
            Positioned(
              left: CCSize.small,
              bottom: 0,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  UserPhoto(
                    photo: photo,
                    radius: CCWidgetSize.xxsmall,
                    backgroundColor: photo == null ? Colors.red[100] : null,
                  ),
                  if (editable)
                    Positioned(
                      right: -CCSize.medium,
                      bottom: 0,
                      child: EditButton(
                        onPressed: () => showPhotoModal(context, userId),
                        priorityHigh: (photo ?? '').isEmpty,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),

        // username
        ListTile(
          leading: const Icon(Icons.alternate_email),
          title: Row(
            children: [
              Text(username ?? ''),
              CCGap.medium,
              CircleAvatar(
                backgroundColor:
                    isConnected == true ? Colors.green : Colors.grey,
                radius: CCSize.xsmall,
              ),
            ],
          ),
          trailing: editable
              ? EditButton(
                  onPressed: editable
                      ? () => context.push('/user/modify_name')
                      : () => showUserActionsModal(context),
                  priorityHigh: editable &&
                      ((username ?? '').isEmpty || username == userId),
                )
              : IconButton(
                  onPressed: () => showUserActionsModal(context),
                  icon: const Icon(Icons.more_horiz),
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
}
