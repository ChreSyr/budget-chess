import 'package:crea_chess/package/atomic_design/dialog/pop_dialog.dart';
import 'package:crea_chess/package/atomic_design/dialog/relationship/block_user.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showAnswerFriendRequestDialog(
  BuildContext pageContext,
  String? requesterId,
) {
  if (requesterId == null) return;
  final currentUserId = pageContext.read<UserCubit>().state?.id;
  if (currentUserId == null) return; // should never happen
  showDialog<AlertDialog>(
    context: pageContext,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(pageContext.l10n.friendRequestNew),
        content: FutureBuilder<UserModel?>(
          future: userCRUD.read(documentId: requesterId),
          builder: (context, snapshot) {
            final friend = snapshot.data;
            return ListTile(
              leading: UserPhoto(photo: friend?.photo),
              title: Text(friend?.username ?? ''),
            );
          },
        ),
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.close),
            onPressed: () {
              relationshipCRUD.refuseFriendRequest(
                refuserId: currentUserId,
                requesterId: requesterId,
              );
              popDialog(dialogContext);
              showBlockUserDialog(pageContext, requesterId);
            },
            label: Text(pageContext.l10n.decline),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.check),
            onPressed: () {
              popDialog(dialogContext);
              relationshipCRUD.makeFriends(requesterId, currentUserId);
              // LATER: fiest animation on new friend
            },
            label: Text(pageContext.l10n.accept),
          ),
        ],
      );
    },
  );
}
