import 'package:collection/collection.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/export.dart';
import 'package:crea_chess/router/app/app_router.dart';
import 'package:crea_chess/router/app/chats/chat/cubit/messages_cubit.dart';
import 'package:crea_chess/router/app/chats/chat/cubit/sending_messages_cubit.dart';
import 'package:crea_chess/router/app/chats/chat/widget/chat.dart';
import 'package:crea_chess/router/app/chats/chat/widget/input/input.dart';
import 'package:crea_chess/router/app/chats/chat/widget/unread_header.dart';
import 'package:crea_chess/router/app/shared_cubit/relations_cubit.dart';
import 'package:crea_chess/router/app/user/user_page.dart';
import 'package:crea_chess/router/app/user/widget/user_photo.dart';
import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChatRoute extends CCRoute {
  const ChatRoute._() : super(name: 'chat', path: ':usernameOrId');

  /// Instance
  static const i = ChatRoute._();

  @override
  Widget build(BuildContext context, GoRouterState state) => ChatPage(
        usernameOrId: state.pathParameters['usernameOrId'],
      );

  static void pushId({required String userId}) => appRouter.pushNamed(
        i.name,
        pathParameters: {'usernameOrId': userId},
      );

  static void pushUsername({required String username}) => appRouter.pushNamed(
        i.name,
        pathParameters: {'usernameOrId': '@$username'},
      );
}

class ChatPage extends StatelessWidget {
  const ChatPage({required this.usernameOrId, super.key});

  final String? usernameOrId;

  @override
  Widget build(BuildContext context) {
    if (usernameOrId == null) {
      return ErrorPage(exception: Exception('Missing argument : usernameOrId'));
    }

    return StreamBuilder<UserModel?>(
      stream: usernameOrId!.startsWith('@')
          ? userCRUD.streamUsername(usernameOrId!.substring(1))
          : userCRUD.stream(documentId: usernameOrId!),
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const LinearProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: InkWell(
              onTap: () => UserRoute.pushId(userId: user.id),
              child: CCPadding.allSmall(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    UserPhoto(
                      photo: user.photo,
                      isConnected: user.isConnected,
                      radius: CCSize.medium,
                    ),
                    CCGap.small,
                    Text(user.username),
                  ],
                ),
              ),
            ),
          ),
          body: ChatScreen(
            authUid: context.read<UserCubit>().state.id,
            otherId: user.id,
          ),
        );
      },
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    required this.authUid,
    required this.otherId,
    super.key,
  });

  final String authUid;
  final String otherId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final relationshipId = relationshipCRUD.getId(
      widget.authUid,
      widget.otherId,
    );
    MessagesCubit.i.relationshipIdChanged(relationshipId);

    String? firstUnreadMessageId;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: MessagesCubit.i),
        BlocProvider.value(value: SendingMessagesCubit.i),
      ],
      child: Builder(
        builder: (context) {
          final allRelations = context.watch<RelationsCubit>().state;
          final isBlocked = allRelations.any(
            (r) => r.id == relationshipId && r.blocker == widget.otherId,
          );

          return BlocConsumer<SendingMessagesCubit, SendingMessages>(
            listener: (context, state) {
              if (state.status == SendingStatus.error) {
                // TODO : l10n
                snackBarError(context, 'Error while sending message');
                context.read<SendingMessagesCubit>().clearStatus();
              }
            },
            builder: (context, sendingMessages) {
              final messages = context.watch<MessagesCubit>().state.toList();
              final messageIds = messages.map((e) => e.id);
              final failedMessages = sendingMessages.messages
                  .where((message) => message.relationshipId == relationshipId)
                  .where((message) => !messageIds.contains(message.id))
                  .toList();
              firstUnreadMessageId ??= messages
                  .lastWhereOrNull((m) => m.notSeenBy(widget.authUid))
                  ?.id;
              for (final message in messages) {
                if (message.notSeenBy(widget.authUid)) {
                  messageCRUD.updateSeenStatus(
                    message: message,
                    userId: widget.authUid,
                    seenStatus: MessageSeenStatus.seen,
                  );
                }
              }
              if (failedMessages.isNotEmpty) {
                messages
                  ..addAll(failedMessages)
                  ..sort(
                    (a, b) => a.sentAt == null
                        ? 0
                        : b.sentAt?.compareTo(a.sentAt!) ?? 0,
                  );
              }

              return Chat(
                messages: messages,
                onSendPressed: (text) async {
                  await context.read<SendingMessagesCubit>().send(
                        authorId: widget.authUid,
                        receiverId: widget.otherId,
                        text: text,
                      );
                },
                user: context.read<UserCubit>().state,
                scrollToUnreadOptions: ScrollToUnreadOptions(
                  firstUnreadMessageId: firstUnreadMessageId,
                  scrollOnOpen: true,
                ),
                isBlocked: isBlocked,
                inputOptions: const InputOptions(autofocus: true),
              );
            },
          );
        },
      ),
    );
  }
}
