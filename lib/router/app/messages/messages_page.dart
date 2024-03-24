import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/chat/widgets/chat.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/router/app/app_router.dart';
import 'package:crea_chess/router/app/messages/sending_messages/sending_messages_cubit.dart';
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
          return Scaffold(
            appBar: AppBar(
              title: user == null ? null : Text(user.username),
            ),
            body: user == null
                ? const LinearProgressIndicator()
                : ChatScreen(
                    authUid: context.read<UserCubit>().state.id,
                    otherId: user.id,
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
            return Chat(
              messages: (snapshot.data?.toList() ?? []) +
                  sendingMesssages.messages
                      .where(
                        (message) => message.relationshipId == relationshipId,
                      )
                      .toList(),
              onSendPressed: (text) async {
                context.read<SendingMessagesCubit>().send(
                      authorId: widget.authUid,
                      receiverId: widget.otherId,
                      text: text,
                    );
              },
              user: currentUser,
            );
          },
        );
      },
    );
  }
}
