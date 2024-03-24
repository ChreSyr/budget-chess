import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/feed_card.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/user/relationship_button.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_model.dart';
import 'package:crea_chess/router/app/chats/chat/chat_page.dart';
import 'package:flutter/material.dart';

class UserActionsRow extends StatelessWidget {
  const UserActionsRow({
    required this.currentUser,
    required this.otherUser,
    super.key,
  });

  final UserModel currentUser;
  final UserModel otherUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RelationshipModel?>(
      stream: relationshipCRUD.stream(
        documentId: relationshipCRUD.getId(currentUser.id, otherUser.id),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return CCGap.zero;
        }

        final relation = snapshot.data;
        return Row(
          children: [
            CCGap.small,
            RelationshipButton(
              authUid: currentUser.id,
              userId: otherUser.id,
              relation: relation,
            ),
            if (relation?.statusOf(currentUser.id) !=
                UserInRelationshipStatus.isBlocked) ...[
              CCGap.small,
              UserActionButton(
                onTap: () => ChatRoute.pushId(userId: otherUser.id),
                icon: const Icon(Icons.message),
                text: 'Envoyer un message',
              ),
            ],
          ],
        );
      },
    );
  }
}

class UserActionButton extends StatelessWidget {
  const UserActionButton({
    required this.icon,
    required this.text,
    this.onTap,
    this.color,
    super.key,
  });

  final Widget icon;
  final String text;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: CCWidgetSize.large,
      child: FeedCard(
        onTap: onTap,
        color: color,
        child: Column(
          children: [
            icon,
            CCGap.small,
            Text(
              text,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
