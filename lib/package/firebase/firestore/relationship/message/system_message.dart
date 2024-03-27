import 'package:crea_chess/package/firebase/export.dart';

enum SystemMessage {
  friendshipStart;

  static const id = '#';

  static MessageModel atFriendshipStart({
    required RelationshipModel friendship,
  }) =>
      MessageModel(
        relationshipId: friendship.id,
        id: '',
        authorId: id,
        text: SystemMessage.friendshipStart.name,
        sentAt: DateTime.now(),
        statuses: friendship.copyOfUsers.map(
          (userId, _) => MapEntry(
            userId,
            MessageToUserStatus(updatedAt: DateTime.now()),
          ),
        ),
      );
}
