import 'dart:async';

import 'package:crea_chess/package/atomic_design/dialog/relationship/block_user.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/friends/search_friend/search_friend_delegate.dart';
import 'package:crea_chess/router/app/user/user_page.dart';
import 'package:crea_chess/router/shared/app_bar_actions.dart';
import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FriendsRoute extends CCRoute {
  const FriendsRoute._() : super(name: '/friends', icon: Icons.people);

  /// Instance
  static const i = FriendsRoute._();

  @override
  String getTitle(AppLocalizations l10n) => l10n.friends;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const FriendsPage();
}

class FriendRequestsCubit
    extends AuthUidListenerCubit<Iterable<RelationshipModel>> {
  FriendRequestsCubit() : super([]);

  @override
  void authUidChanged(String? authUid) {
    _relationsStream?.cancel();

    if (authUid == null) return emit([]);

    _relationsStream = relationshipCRUD.requestsTo(authUid).listen(emit);
  }

  StreamSubscription<Iterable<RelationshipModel>>? _relationsStream;

  @override
  Future<void> close() {
    _relationsStream?.cancel();
    return super.close();
  }
}

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  static const notifFriendRequests = 'friend-requests';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FriendsRoute.i.getTitle(context.l10n)),
        actions: getSideRoutesAppBarActions(context),
      ),
      body: CCPadding.horizontalMedium(
        child: Column(
          children: [
            // Search bar
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () => searchFriend(context),
                child: CCPadding.allSmall(
                  child: Row(
                    children: [
                      Text(
                        // TODO : l10n
                        'Rechercher un joueur',
                        style: context.textTheme.bodyLarge,
                      ),
                      const Expanded(child: CCGap.medium),
                      const Icon(Icons.search),
                    ],
                  ),
                ),
              ),
            ),
            // Friendship requests
            BlocBuilder<FriendRequestsCubit, Iterable<RelationshipModel>>(
              builder: (context, requests) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: requests
                      .map(
                        (request) => FriendRequestCard(
                          request,
                          context,
                        ),
                      )
                      .toList(),
                );
              },
            ),
            CCGap.medium,
            // Friend previews
            Center(
              child: BlocBuilder<UserCubit, UserModel>(
                builder: (context, user) {
                  final authUid = user.id;
                  return StreamBuilder<Iterable<RelationshipModel>>(
                    stream: relationshipCRUD.friendshipsOf(authUid),
                    builder: (context, snapshot) {
                      final friendships = snapshot.data ?? [];
                      return Wrap(
                        children: friendships.map((e) {
                          final friendId = e.otherUser(authUid);
                          if (friendId == null) return CCGap.zero;
                          return FriendPreview(friendId);
                        }).toList(),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FriendRequestCard extends StatelessWidget {
  const FriendRequestCard(this.request, this.parentContext, {super.key});

  final RelationshipModel request;
  // Dirty, isn'it ? It's needed for the snack bars, who need a context even if
  // this card doesn't exist anymore
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    final authUid = context.watch<UserCubit>().state.id;

    final requester = request.requester;
    if (requester == null) return CCGap.zero;

    if (request.otherUser(requester) != authUid) {
      return const SizedBox.shrink();
    }

    return Card(
      child: CCPadding.allMedium(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => UserRoute.pushId(userId: requester),
              child: StreamBuilder<UserModel?>(
                stream: userCRUD.stream(documentId: requester),
                builder: (context, snapshot) {
                  final requesterProfile = snapshot.data;
                  if (requesterProfile == null) return CCGap.zero;

                  return Row(
                    children: [
                      UserPhoto(
                        photo: requesterProfile.photo,
                        radius: CCSize.xlarge,
                      ),
                      CCGap.medium,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            requesterProfile.username,
                            style: context.textTheme.titleLarge,
                          ),
                          CCGap.medium,
                          const Text('Vous demande en ami !'), // TODO : l10n
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            CCGap.medium,
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      relationshipCRUD.refuseFriendRequest(
                        refuserId: authUid,
                        requesterId: requester,
                      );
                      showBlockUserDialog(parentContext, requester);
                    },
                    icon: const Icon(Icons.close),
                    label: Text(context.l10n.decline), // TODO : refuse
                  ),
                ),
                CCGap.medium,
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () =>
                        relationshipCRUD.makeFriends(requester, authUid),
                    icon: const Icon(Icons.check),
                    label: Text(context.l10n.accept),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FriendPreview extends StatelessWidget {
  const FriendPreview(this.friendId, {super.key});

  final String friendId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
      stream: userCRUD.stream(documentId: friendId),
      builder: (context, snapshot) {
        final friend = snapshot.data;
        if (friend == null) return CCGap.zero;

        return SizedBox(
          width: CCWidgetSize.medium,
          child: CCPadding.allXsmall(
            child: GestureDetector(
              onTap: () => UserRoute.pushId(userId: friend.id),
              child: Column(
                children: [
                  UserPhoto(
                    photo: friend.photo,
                    radius: CCSize.xlarge,
                    isConnected: friend.isConnected,
                  ),
                  CCGap.small,
                  Text(
                    friend.username,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
