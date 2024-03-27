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
        sentTo: friendship.userIds.toSet(),
      );
}
