import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/router/app/app_router.dart';
import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:flutter/material.dart';
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

    return StreamBuilder<UserModel?>(
      stream: usernameOrId!.startsWith('@')
          ? userCRUD.streamUsername(usernameOrId!.substring(1))
          : userCRUD.stream(documentId: usernameOrId!),
      builder: (context, snapshot) {
        final user = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            title: user == null ? null : Text(user.username),
          ),
          body: const Placeholder(),
        );
      },
    );
  }
}
