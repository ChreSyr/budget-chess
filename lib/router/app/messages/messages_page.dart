import 'dart:async';

import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/authentication/auth_uid_listener_cubit.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/relationship_crud.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/relationship_model.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_crud.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_model.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/user/user_page.dart';
import 'package:crea_chess/router/shared/app_bar_actions.dart';
import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MessagesRoute extends CCRoute {
  const MessagesRoute._() : super(name: '/messages', icon: Icons.forum);

  /// Instance
  static const i = MessagesRoute._();

  @override
  String getTitle(AppLocalizations l10n) => l10n.messages;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MessagesPage();
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
          filter: (collection) => collection.where(
            authUid,
            isNotEqualTo: null,
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

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MessagesRoute.i.getTitle(context.l10n)),
        actions: getSideRoutesAppBarActions(context),
      ),
      backgroundColor: context.colorScheme.surfaceVariant,
      body: BlocProvider(
        create: (context) => RelationsCubit(),
        child: BlocBuilder<RelationsCubit, Iterable<RelationshipModel>>(
          builder: (context, relations) {
            final otherIds = context.watch<RelationsCubit>().otherIds;
            return ListView(
              children: [
                const Center(
                  child: Text(
                    'Messages page is coming soon !\n\nFeel free to make suggestions !\n\nYou can contact the player Mael_Mainsard ;)',
                    textAlign: TextAlign.center,
                  ),
                ),
                ...otherIds.map((userId) {
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
                        title: Text(user.username),
                      );
                    },
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}
