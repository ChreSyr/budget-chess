import 'package:crea_chess/package/atomic_design/dialog/relationship/answer_friend_request.dart';
import 'package:crea_chess/package/atomic_design/dialog/relationship/cancel_friend_request.dart';
import 'package:crea_chess/package/atomic_design/dialog/relationship/unblock_user.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/widget/badge.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RelationshipButton extends StatelessWidget {
  const RelationshipButton({
    required this.authUid,
    required this.userId,
    this.relation,
    this.asIcon = false,
    super.key,
  });

  final String authUid;
  final String userId;
  final RelationshipModel? relation;
  final bool asIcon;

  @override
  Widget build(BuildContext context) {
    if (authUid == userId) return CCGap.zero;

    return relation != null
        ? _getButton(context, relation!, asIcon)
        : StreamBuilder<RelationshipModel?>(
            stream: relationshipCRUD.stream(
              documentId: relationshipCRUD.getId(authUid, userId),
            ),
            builder: (context, snapshot) {
              final relation = snapshot.data;

              if (relation == null) {
                return SendFriendRequestButton(
                  userId: userId,
                  asIcon: asIcon,
                );
              }

              return _getButton(context, relation, asIcon);
            },
          );
  }

  Widget _getButton(
    BuildContext context,
    RelationshipModel relation,
    bool asIcon,
  ) {
    switch (relation.statusOf(authUid)) {
      case UserInRelationshipStatus.open:
        return asIcon
            ? const IconButton(
                icon: Icon(Icons.check), // TODO : change
                onPressed: null,
              )
            : CCGap.zero;
      case UserInRelationshipStatus.hasDeletedAccount:
        return CCGap.zero;
      case UserInRelationshipStatus.requests:
        return asIcon
            ? IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => showCancelFriendRequestDialog(context, userId),
              )
            : ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: Text(context.l10n.friendRequestSent),
                onPressed: () => showCancelFriendRequestDialog(context, userId),
              );
      case UserInRelationshipStatus.isRequested:
        return SimpleBadge(
          child: asIcon
              ? IconButton(
                  icon: const Icon(Icons.mail),
                  onPressed: () =>
                      showAnswerFriendRequestDialog(context, userId),
                )
              : FilledButton.icon(
                  icon: const Icon(Icons.mail),
                  label: const Text('Vous demande en ami !'), // TODO : l10n
                  onPressed: () =>
                      showAnswerFriendRequestDialog(context, userId),
                ),
        );
      case UserInRelationshipStatus.blocks:
        return asIcon
            ? IconButton(
                icon: const Icon(Icons.block),
                onPressed: () => showUnblockUserDialog(context, userId),
              )
            : ElevatedButton.icon(
                icon: const Icon(Icons.block),
                label: Text(context.l10n.blockedUserVerbose),
                onPressed: () => showUnblockUserDialog(context, userId),
              );
      case UserInRelationshipStatus.isBlocked:
        return asIcon
            ? const IconButton(
                icon: Icon(Icons.block),
                onPressed: null,
              )
            : ElevatedButton.icon(
                icon: const Icon(Icons.block),
                label: Text(context.l10n.blockedByUser),
                onPressed: null,
              );
      case null:
      case UserInRelationshipStatus.none:
      case UserInRelationshipStatus.refuses:
      case UserInRelationshipStatus.isRefused:
      case UserInRelationshipStatus.cancels:
      case UserInRelationshipStatus.isCanceled:
        return relation.canSendFriendRequest(authUid)
            ? SendFriendRequestButton(userId: userId, asIcon: asIcon)
            : CCGap.zero;
    }
  }
}

class SendFriendRequestButton extends StatelessWidget {
  const SendFriendRequestButton({
    required this.userId,
    this.asIcon = false,
    super.key,
  });

  final String userId;
  final bool asIcon;

  @override
  Widget build(BuildContext context) {
    final authUid = context.watch<UserCubit>().state.id;

    return asIcon
        ? IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              relationshipCRUD.sendFriendRequest(
                fromUserId: authUid,
                toUserId: userId,
              );
              snackBarNotify(context, context.l10n.friendRequestSent);
            },
          )
        : FilledButton.icon(
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
