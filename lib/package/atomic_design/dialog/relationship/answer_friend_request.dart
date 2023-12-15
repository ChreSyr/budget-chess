import 'package:crea_chess/package/atomic_design/dialog/relationship/block_user.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/relationship_crud.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_crud.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_cubit.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_model.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void showAnswerFriendRequestDialog(
  BuildContext pageContext,
  String? fromUserId,
) {
  if (fromUserId == null) return;
  final currentUserId = pageContext.read<UserCubit>().state?.id;
  if (currentUserId == null) return; // should never happen
  showDialog<AlertDialog>(
    context: pageContext,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(pageContext.l10n.friendRequestNew),
        content: FutureBuilder<UserModel?>(
          future: userCRUD.read(documentId: fromUserId),
          builder: (context, snapshot) {
            final friend = snapshot.data;
            return ListTile(
              leading: UserPhoto(userId: friend?.id, photo: friend?.photo),
              title: Text(friend?.username ?? ''),
            );
          },
        ),
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.close),
            onPressed: () {
              relationshipCRUD.delete(
                documentId: relationshipCRUD.getId(fromUserId, currentUserId),
              );
              dialogContext.pop();
              showBlockUserDialog(pageContext, fromUserId);
            },
            label: Text(pageContext.l10n.decline),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.check),
            onPressed: () {
              dialogContext.pop();
              relationshipCRUD.makeFriends(fromUserId, currentUserId);
              // LATER: fiest animation on new friend
            },
            label: Text(pageContext.l10n.accept),
          ),
        ],
      );
    },
  );
}
