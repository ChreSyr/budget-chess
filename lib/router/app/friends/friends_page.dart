import 'dart:async';

import 'package:badges/badges.dart' as badges;
import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/dialog/relationship/block_user.dart';
import 'package:crea_chess/package/atomic_design/dialog/relationship/cancel_friend_request.dart';
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

    _relationsStream = relationshipCRUD.streamRequestsTo(authUid).listen(emit);
  }

  StreamSubscription<Iterable<RelationshipModel>>? _relationsStream;

  @override
  Future<void> close() {
    _relationsStream?.cancel();
    return super.close();
  }
}

class FriendshipsCubit
    extends AuthUidListenerCubit<Iterable<RelationshipModel>?> {
  FriendshipsCubit() : super(null);

  String? _authUid;
  StreamSubscription<Iterable<RelationshipModel>>? _friendshipsStream;

  @override
  void authUidChanged(String? authUid) {
    _authUid = authUid;

    _friendshipsStream?.cancel();

    if (authUid == null) return emit([]);

    _friendshipsStream = relationshipCRUD.friendshipsOf(authUid).listen(emit);
  }

  @override
  Future<void> close() {
    _friendshipsStream?.cancel();
    return super.close();
  }

  bool get isLoading => state == null;
  Iterable<String> get friendIds => _authUid == null || state == null
      ? []
      : state!.map((e) => e.otherUser(_authUid!)).whereType<String>();
}

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  static const notifFriendRequests = 'friend-requests';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FriendshipsCubit(),
      child: Scaffold(
        backgroundColor: context.colorScheme.surfaceVariant,
        appBar: AppBar(actions: getSideRoutesAppBarActions(context)),
        body: const SingleChildScrollView(child: FriendsFeed()),
      ),
    );
  }
}

class FriendsFeed extends StatelessWidget {
  const FriendsFeed({super.key});

  @override
  Widget build(BuildContext context) {
    final friendshipsCubit = context.watch<FriendshipsCubit>();

    return CCPadding.allLarge(
      child: Column(
        children: [
          // Search bar
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () => searchFriend(context),
              child: CCPadding.allMedium(
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
          CCGap.medium,
          // Friendship requests to this user
          BlocBuilder<FriendRequestsCubit, Iterable<RelationshipModel>>(
            builder: (context, requests) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: requests.map(
                  (request) {
                    final requester = request.requester;
                    if (requester == null) return CCGap.zero;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: CCSize.medium),
                      child: FriendRequestCard(requester, context),
                    );
                  },
                ).toList(),
              );
            },
          ),
          // Friends
          if (!friendshipsCubit.isLoading) FriendsCard(friendshipsCubit),
          // Friendship requests from this user
          StreamBuilder<Iterable<RelationshipModel>>(
            stream: relationshipCRUD.streamRequestsFrom(
              context.read<UserCubit>().state.id,
            ),
            builder: (context, snapshot) {
              final requests = snapshot.data ?? [];
              if (requests.isEmpty) return CCGap.zero;

              return Padding(
                padding: const EdgeInsets.only(top: CCSize.medium),
                child: SentFriendRequestsCard(requests: requests),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FriendRequestCard extends StatelessWidget {
  const FriendRequestCard(this.requester, this.parentContext, {super.key});

  final String requester;
  // Dirty, isn'it ? It's needed for the snack bars, who need a context even if
  // this card doesn't exist anymore
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    final authUid = context.watch<UserCubit>().state.id;

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
                        isConnected: requesterProfile.isConnected,
                      ),
                      CCGap.medium,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              requesterProfile.username,
                              style: context.textTheme.titleLarge,
                            ),
                            CCGap.medium,
                            const badges.Badge(
                              child: Text('Vous demande en ami !'),
                            ), // TODO : l10n
                          ],
                        ),
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

class FriendsCard extends StatelessWidget {
  const FriendsCard(this.friendshipsCubit, {super.key});

  final FriendshipsCubit friendshipsCubit;

  @override
  Widget build(BuildContext context) {
    final friendIds = friendshipsCubit.friendIds;

    return Card(
      child: CCPadding.allMedium(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.l10n.friends,
              style: context.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            CCGap.medium,
            if (friendIds.isEmpty)
              // TODO : l10n
              const Text("Vous n'avez pas encore d'ami.")
            else
              Center(
                child: Wrap(
                  runSpacing: CCSize.medium,
                  children: friendIds.map(FriendPreview.new).toList(),
                ),
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
          width: CCWidgetSize.small,
          child: CCPadding.allXsmall(
            child: GestureDetector(
              onTap: () => UserRoute.pushId(userId: friend.id),
              child: Column(
                children: [
                  UserPhoto(
                    photo: friend.photo,
                    backgroundColor: CardTheme.of(context).color,
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

class SentFriendRequestsCard extends StatelessWidget {
  const SentFriendRequestsCard({
    required this.requests,
    super.key,
  });

  final Iterable<RelationshipModel> requests;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CCPadding.allMedium(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // TODO : l10n : plural
              context.l10n.friendRequestSent,
              style: context.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            CCGap.medium,
            ...requests.map(
              (request) {
                final requester = request.requester;
                if (requester == null) return CCGap.zero;
                final requestedId = request.otherUser(requester);
                if (requestedId == null) return CCGap.zero;

                return StreamBuilder<UserModel?>(
                  stream: userCRUD.stream(documentId: requestedId),
                  builder: (context, snapshot) {
                    final requested = snapshot.data;
                    if (requested == null) return CCGap.zero;
                    return ListTile(
                      contentPadding: const EdgeInsets.only(left: CCSize.small),
                      leading: UserPhoto(
                        photo: requested.photo,
                        isConnected: requested.isConnected,
                        onTap: () => UserRoute.pushId(userId: requestedId),
                      ),
                      title: Text(requested.username),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => showCancelFriendRequestDialog(
                          context,
                          requestedId,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
