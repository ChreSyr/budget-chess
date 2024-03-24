import 'dart:async';

import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/authentication/auth_uid_listener_cubit.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/relationship_crud.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/relationship_model.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_crud.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_model.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/chats/chat/chat_page.dart';
import 'package:crea_chess/router/app/user/user_page.dart';
import 'package:crea_chess/router/shared/app_bar_actions.dart';
import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ChatHomeRoute extends CCRoute {
  const ChatHomeRoute._()
      : super(
          name: 'chatHome',
          path: '/chat',
          icon: Icons.forum,
        );

  /// Instance
  static const i = ChatHomeRoute._();

  @override
  String getTitle(AppLocalizations l10n) => l10n.messages;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ChatHomePage();

  @override
  List<RouteBase> get routes => [ChatRoute.i.goRoute];
}

class RelationsCubit extends AuthUidListenerCubit<Iterable<RelationshipModel>> {
  RelationsCubit() : super([]);

  String? _authUid;
  StreamSubscription<Iterable<RelationshipModel>>? _relationsStream;

  @override
  void authUidChanged(String? authUid) {
    _authUid = authUid;
    _relationsStream?.cancel();
    if (authUid == null) return emit([]);
    _relationsStream = relationshipCRUD
        .streamFiltered(
          filter: (collection) => collection
              .where(
                authUid,
                isNotEqualTo: null,
              )
              .orderBy(
                'lastUserStatusUpdate',
                descending: true,
              ),
        )
        .listen(emit);
  }

  @override
  Future<void> close() {
    _relationsStream?.cancel();
    return super.close();
  }

  Iterable<String> get otherIds => _authUid == null
      ? []
      : state.map((e) => e.otherUser(_authUid!)).whereType<String>();
}

class ChatHomePage extends StatelessWidget {
  const ChatHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ChatHomeRoute.i.getTitle(context.l10n)),
        actions: getSideRoutesAppBarActions(context),
      ),
      body: BlocProvider(
        create: (context) => RelationsCubit(),
        child: BlocBuilder<RelationsCubit, Iterable<RelationshipModel>>(
          builder: (context, relations) {
            final otherIds = context.watch<RelationsCubit>().otherIds;
            return ListView(
              children: otherIds.map((userId) {
                final relation =
                    relations.firstWhere((r) => r.userIds.contains(userId));
                return StreamBuilder<UserModel?>(
                  stream: userCRUD.stream(documentId: userId),
                  builder: (context, snapshot) {
                    final user = snapshot.data;
                    if (user == null) return CCGap.zero;

                    return ListTile(
                      leading: UserPhoto(
                        photo: user.photo,
                        isConnected: user.isConnected,
                        onTap: () => UserRoute.pushId(userId: userId),
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              user.username,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.titleMedium,
                            ),
                          ),
                          CCGap.small,
                          if (relation.lastUserStatusUpdate != null)
                            Text(
                              '${DateFormat(DateFormat.DAY, 'fr').format(relation.lastUserStatusUpdate!).padLeft(2, '0')}/${DateFormat(DateFormat.NUM_MONTH, 'fr').format(relation.lastUserStatusUpdate!).padLeft(2, '0')}/${DateFormat(DateFormat.YEAR, 'fr').format(relation.lastUserStatusUpdate!)}',
                              style: context.textTheme.infoSmall,
                            ),
                        ],
                      ),
                      subtitle: StreamBuilder(
                        stream: messageCRUD.streamFiltered(
                          parentDocumentId: relationshipCRUD.getId(
                            context.read<UserCubit>().state.id,
                            userId,
                          ),
                          filter: (collection) => collection
                              .orderBy(
                                'createdAt',
                                descending: true,
                              )
                              .limit(1),
                        ),
                        builder: (context, snapshot) {
                          final lastMessage = snapshot.data?.firstOrNull;
                          if (lastMessage?.text == null) return CCGap.zero;
                          return Text(
                            lastMessage!.text!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      ),
                      onTap: () => ChatRoute.pushId(userId: userId),
                    );
                  },
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
