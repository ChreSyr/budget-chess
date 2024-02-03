import 'package:crea_chess/package/atomic_design/dialog/relationship/answer_friend_request.dart';
import 'package:crea_chess/package/atomic_design/dialog/relationship/cancel_friend_request.dart';
import 'package:crea_chess/package/atomic_design/dialog/relationship/unblock_user.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget? getRelationshipButton(
  BuildContext context,
  RelationshipModel? relation,
) {
  if (relation == null) return null;
  final currentUserId = context.read<UserCubit>().state?.id;
  if (currentUserId == null) return null; // should never happen
  final userId = relation.otherUser(currentUserId);
  if (userId == null) return null; // should never happen
  if (currentUserId == userId) return null;

  switch (relation.status) {
    case RelationshipStatus.canceled:
      return FilledButton.icon(
        icon: const Icon(Icons.person_add),
        label: Text(context.l10n.friendRequestSend),
        onPressed: () {
          relationshipCRUD.sendFriendRequest(
            fromUserId: currentUserId,
            toUserId: userId,
          );
          snackBarNotify(context, context.l10n.friendRequestSent);
        },
      );
    case RelationshipStatus.friends:
      return Container();
    case RelationshipStatus.requestedByFirst:
    case RelationshipStatus.requestedByLast:
      if (relation.requester == userId) {
        return FilledButton.icon(
          onPressed: () => showAnswerFriendRequestDialog(context, userId),
          icon: const Icon(Icons.mail),
          label: Text(context.l10n.friendRequestSend),
        );
      } else {
        return ElevatedButton.icon(
          onPressed: () => showCancelFriendRequestDialog(context, userId),
          icon: const Icon(Icons.send),
          label: Text(context.l10n.friendRequestSent),
        );
      }
    case RelationshipStatus.blockedByFirst:
    case RelationshipStatus.blockedByLast:
      if (relation.blocker == currentUserId) {
        return ElevatedButton.icon(
          onPressed: () => showUnblockUserDialog(context, userId),
          icon: const Icon(Icons.block),
          label: Text(context.l10n.blockedUserVerbose),
        );
      } else {
        return ElevatedButton.icon(
          onPressed: null,
          icon: const Icon(Icons.block),
          label: Text(context.l10n.blockedByUser),
        );
      }
  }
}
