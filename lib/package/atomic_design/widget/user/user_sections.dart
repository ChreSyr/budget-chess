import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/chat/flutter_chat_ui/widgets/chat.dart';
import 'package:crea_chess/package/chat/message/message_model.dart';
import 'package:crea_chess/package/chat/message/messsage_crud.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/friends/search_friend/search_friend_delegate.dart';
import 'package:crea_chess/router/app/user/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// LATER: if other is not a friend, can only see friends in common

abstract class UserSection extends StatelessWidget {
  const UserSection({super.key});

  static List<UserSection> getSections(String current, String other) {
    if (current == other) {
      return [
        UserSectionFriends(userId: other),
        UserSectionGames(userId: other),
      ];
    } else {
      return [
        UserSectionMessages(currentUserId: current, otherId: other),
        UserSectionFriends(userId: other),
        UserSectionGames(userId: other),
      ];
    }
  }

  String getTitle(AppLocalizations l10n);
}

class UserSectionMessages extends UserSection {
  const UserSectionMessages({
    required this.currentUserId,
    required this.otherId,
    super.key,
  });

  final String currentUserId;
  final String otherId;

  @override
  String getTitle(AppLocalizations l10n) {
    return l10n.messages;
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserId == otherId) return Container(); // should never happen
    return ChatSection(currentUserId: currentUserId, otherId: otherId);
  }
}

class UserSectionFriends extends UserSection {
  const UserSectionFriends({required this.userId, super.key});

  final String userId;

  @override
  String getTitle(AppLocalizations l10n) => l10n.friends;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CCPadding.allMedium(
        child: StreamBuilder<Iterable<RelationshipModel>>(
          stream: relationshipCRUD.streamFriendshipsOf(userId),
          builder: (context, snapshot) {
            final relations = snapshot.data;
            const radius = CCSize.xlarge;
            final friendsPreviews = (relations ?? []).map(
              (relationship) {
                final friendId = relationship.otherUser(userId);
                if (friendId == null) return CCGap.zero;
                return UserPhoto.fromId(
                  userId: friendId,
                  radius: radius,
                  onTap: () {
                    if (friendId == userId) {
                      while (context.canPop()) {
                        context.pop();
                      }
                    } else {
                      UserRoute.pushId(userId: friendId);
                    }
                  },
                );
              },
            ).toList();
            if (context.read<UserCubit>().state.id == userId) {
              friendsPreviews.add(
                SizedBox(
                  height: radius * 2,
                  width: radius * 2,
                  child: IconButton.outlined(
                    onPressed: () => searchFriend(context),
                    icon: const Icon(Icons.person_add),
                  ),
                ),
              );
            }
            return Wrap(
              runSpacing: CCSize.medium,
              spacing: CCSize.medium,
              children: friendsPreviews,
            );
          },
        ),
      ),
    );
  }
}

class ChatSection extends StatefulWidget {
  const ChatSection({
    required this.currentUserId,
    required this.otherId,
    super.key,
  });

  final String currentUserId;
  final String otherId;

  @override
  State<ChatSection> createState() => _ChatSectionState();
}

class _ChatSectionState extends State<ChatSection> {
  Future<void> _handleMessageTap(BuildContext _, MessageModel message) async {
    // if (message is types.FileMessage) {
    //   var localPath = message.uri;

    //   if (message.uri.startsWith('http')) {
    //     try {
    //       final updatedMessage = message.copyWith(isLoading: true);
    //       FirebaseChatCore.instance.updateMessage(
    //         updatedMessage,
    //         widget.room.id,
    //       );

    //       final client = http.Client();
    //       final request = await client.get(Uri.parse(message.uri));
    //       final bytes = request.bodyBytes;
    //       final documentsDir = (await getApplicationDocumentsDirectory())
    //              .path;
    //       localPath = '$documentsDir/${message.name}';

    //       if (!File(localPath).existsSync()) {
    //         final file = File(localPath);
    //         await file.writeAsBytes(bytes);
    //       }
    //     } finally {
    //       final updatedMessage = message.copyWith(isLoading: false);
    //       FirebaseChatCore.instance.updateMessage(
    //         updatedMessage,
    //         widget.room.id,
    //       );
    //     }
    //   }

    //   await OpenFilex.open(localPath);
    // }
  }

  Future<void> _handleSendPressed(String text) async {
    final relationshipId = relationshipCRUD.getId(
      widget.currentUserId,
      widget.otherId,
    );
    final message = MessageModel.fromText(
      authorId: widget.currentUserId,
      text: text,
    );
    try {
      await messageCRUD.create(
        parentDocumentId: relationshipId,
        documentId: null,
        data: message,
      );
    } catch (_) {
      // ignore: use_build_context_synchronously
      snackBarError(context, context.l10n.errorOccurred);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<UserCubit>().state;

    final relationshipId = relationshipCRUD.getId(
      widget.currentUserId,
      widget.otherId,
    );

    return StreamBuilder<Iterable<MessageModel>>(
      stream: messageCRUD.streamFiltered(
        parentDocumentId: relationshipId,
        filter: (collection) => collection.orderBy(
          'createdAt',
          descending: true,
        ),
      ),
      builder: (context, snapshot) {
        return Chat(
          messages: snapshot.data?.toList() ?? [],
          onMessageTap: _handleMessageTap,
          onSendPressed: _handleSendPressed,
          user: currentUser,
        );
      },
    );
  }
}

class UserSectionGames extends UserSection {
  const UserSectionGames({required this.userId, super.key});

  final String userId;

  @override
  String getTitle(AppLocalizations l10n) {
    return 'Games'; // TODO : l10n
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Iterable<GameModel>>(
      stream: liveGameCRUD.streamFiltered(
        filter: (collection) => collection.where(
          Filter.or(
            Filter('whiteId', isEqualTo: userId),
            Filter('blackId', isEqualTo: userId),
          ),
        ),
      ),
      builder: (context, snapshot) {
        final games = snapshot.data;

        // TODO : GamesHistory

        return CCPadding.allLarge(
          child: Text('There is ${games?.length ?? 0} games in history'),
        );
      },
    );
  }
}
