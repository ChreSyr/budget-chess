import 'dart:async';

import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/chat/models/typing_indicator_mode.dart';
import 'package:crea_chess/package/chat/widgets/chat.dart';
import 'package:crea_chess/package/chat/widgets/typing_indicator.dart';
import 'package:crea_chess/package/chat/widgets/unread_header.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/router/app/app_router.dart';
import 'package:crea_chess/router/app/messages/sending_messages/sending_messages_cubit.dart';
import 'package:crea_chess/router/app/user/user_page.dart';
import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MessagesRoute extends CCRoute {
  const MessagesRoute._() : super(name: 'messages', path: ':usernameOrId');

  /// Instance
  static const i = MessagesRoute._();

  @override
  Widget build(BuildContext context, GoRouterState state) => MessagesPage(
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

class ChatPartnerCubit extends Cubit<UserModel?> {
  ChatPartnerCubit(String partnerId) : super(null) {
    _parterStream = userCRUD.stream(documentId: partnerId).listen(emit);
  }

  late StreamSubscription<UserModel?> _parterStream;

  @override
  Future<void> close() {
    _parterStream.cancel();
    return super.close();
  }
}

class MessagesPage extends StatelessWidget {
  const MessagesPage({required this.usernameOrId, super.key});

  final String? usernameOrId;

  @override
  Widget build(BuildContext context) {
    if (usernameOrId == null) {
      return ErrorPage(exception: Exception('Missing argument : usernameOrId'));
    }

    return BlocProvider(
      create: (context) => SendingMessagesCubit(),
      child: StreamBuilder<UserModel?>(
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
          return BlocProvider(
            create: (context) => ChatPartnerCubit(user.id),
            child: Scaffold(
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
            ),
          );
        },
      ),
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
    final currentUser = context.read<UserCubit>().state;

    final relationshipId = relationshipCRUD.getId(
      widget.authUid,
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
        return BlocConsumer<SendingMessagesCubit, SendingMessages>(
          listener: (context, state) {
            if (state.status == SendingStatus.error) {
              // TODO : l10n
              snackBarError(context, 'Error while sending message');
              context.read<SendingMessagesCubit>().clearStatus();
            }
          },
          builder: (context, sendingMesssages) {
            final failedMessages = sendingMesssages.messages
                .where(
                  (message) => message.relationshipId == relationshipId,
                )
                .toList();
            final messages = snapshot.data?.toList() ?? [];
            if (failedMessages.isNotEmpty) {
              messages
                ..addAll(failedMessages)
                ..sort(
                  (a, b) => a.createdAt == null
                      ? 0
                      : b.createdAt?.compareTo(a.createdAt!) ?? 0,
                );
            }

            return Chat(
              messages: messages,
              onSendPressed: (text) async {
                context.read<SendingMessagesCubit>().send(
                      authorId: widget.authUid,
                      receiverId: widget.otherId,
                      text: text,
                    );
              },
              user: currentUser,
              scrollToUnreadOptions: ScrollToUnreadOptions(
                lastReadMessageId: messages.lastOrNull?.id, // TODO
                scrollOnOpen: true,
              ),
              typingIndicatorOptions: TypingIndicatorOptions(
                typingMode: TypingIndicatorMode.both,
                typingUsers: [currentUser, currentUser, currentUser],
              ),
            );
          },
        );
      },
    );
  }
}
