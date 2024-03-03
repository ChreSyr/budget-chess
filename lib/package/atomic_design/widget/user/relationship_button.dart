import 'package:crea_chess/package/atomic_design/dialog/relationship/answer_friend_request.dart';
import 'package:crea_chess/package/atomic_design/dialog/relationship/cancel_friend_request.dart';
import 'package:crea_chess/package/atomic_design/dialog/relationship/unblock_user.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RelationshipButton extends StatelessWidget {
  const RelationshipButton({required this.userId, super.key});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final authUid = context.watch<AuthenticationCubit>().state?.uid;
    if (authUid == null || authUid == userId) return CCGap.zero;

    return StreamBuilder<RelationshipModel?>(
      stream: relationshipCRUD.stream(
        documentId: relationshipCRUD.getId(authUid, userId),
      ),
      builder: (context, snapshot) {
        final relation = snapshot.data;

        if (relation == null) return SendFriendRequestButton(userId: userId);

        switch (relation.status) {
          case RelationshipStatus.canceled:
            return SendFriendRequestButton(userId: userId);
          case RelationshipStatus.friends:
            return CCGap.zero;
          case RelationshipStatus.requestedByFirst:
          case RelationshipStatus.requestedByLast:
            if (relation.requester == userId) {
              return FilledButton.icon(
                onPressed: () => showAnswerFriendRequestDialog(context, userId),
                icon: const Icon(Icons.mail),
                label: const Text('Vous demande en ami !'), // TODO : l10n
              );
            } else {
              return ElevatedButton.icon(
                onPressed: () => showCancelFriendRequestDialog(context, userId),
                icon: const Icon(Icons.send),
                label: Text(context.l10n.friendRequestSend),
              );
            }
          case RelationshipStatus.blockedByFirst:
          case RelationshipStatus.blockedByLast:
            if (relation.blocker == authUid) {
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
      },
    );
  }
}

class SendFriendRequestButton extends StatelessWidget {
  const SendFriendRequestButton({
    required this.userId,
    super.key,
  });

  final String userId;

  @override
  Widget build(BuildContext context) {
    final authUid = context.watch<AuthenticationCubit>().state?.uid;
    if (authUid == null) return CCGap.zero;

    return FilledButton.icon(
      icon: const Icon(Icons.person_add),
      label: Text(context.l10n.friendRequestSend),
      onPressed: () {
        relationshipCRUD.sendFriendRequest(
          fromUserId: authUid,
          toUserId: userId,
        );
        snackBarNotify(context, context.l10n.friendRequestSent);
      },
    );
  }
}
