import 'dart:async';

import 'package:badges/badges.dart' as badges;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/dialog/relationship/block_user.dart';
import 'package:crea_chess/package/atomic_design/dialog/relationship/cancel_friend_request.dart';
import 'package:crea_chess/package/atomic_design/elevation.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/atomic_design/widget/button.dart';
import 'package:crea_chess/package/atomic_design/widget/feed_card.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/chats/chat_home_page.dart';
import 'package:crea_chess/router/app/friends/search_friend/search_friend_delegate.dart';
import 'package:crea_chess/router/app/user/user_page.dart';
import 'package:crea_chess/router/app/user/widget/relationship_button.dart';
import 'package:crea_chess/router/app/user/widget/user_photo.dart';
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

class FriendSuggestionsCubit extends Cubit<Iterable<RelationshipModel>> {
  FriendSuggestionsCubit() : super([]);

  // This list helps to keep suggested relations in this cubit even after the
  // user decided to send a friend request, which would make this relation not
  // matching the filters anymore
  List<String>? suggestionIds;
  StreamSubscription<Iterable<RelationshipModel>>? _existingRelationsStream;

  static final suggestableStatus = [
    null,
    UserInRelationshipStatus.none,
    UserInRelationshipStatus.cancels,
    UserInRelationshipStatus.isCanceled,
  ];

  Future<void> buildSuggestions(
    String authUid,
    Iterable<String> friendIds,
  ) async {
    if (friendIds.isEmpty) return;

    final friendsOfFriends = <String>[];

    for (final friendId in friendIds) {
      final friendshipsOfFriend =
          await relationshipCRUD.readFriendshipsOf(friendId);
      for (final friendshipOfFriend in friendshipsOfFriend) {
        final friendOfFriend = friendshipOfFriend.otherUser(friendId);
        if (friendOfFriend == null) continue;
        if (friendOfFriend == authUid) continue;
        if (friendIds.contains(friendOfFriend)) continue;
        friendsOfFriends.add(friendOfFriend);
      }
    }

    final suggestedRelationIds =
        friendsOfFriends.map((e) => relationshipCRUD.getId(e, authUid));
    if (suggestedRelationIds.isEmpty) return;

    suggestionIds = null;
    await _existingRelationsStream?.cancel();
    _existingRelationsStream = relationshipCRUD
        .streamFiltered(
      filter: (collection) => collection.where(
        FieldPath.documentId,
        whereIn: suggestedRelationIds,
      ),
    )
        .listen((existingRelations) {
      final existingRelationIds = existingRelations.map((e) => e.id);
      final noRelationIds =
          suggestedRelationIds.whereNot(existingRelationIds.contains);

      final suggestableExistingRelations = suggestionIds == null
          ? existingRelations.where(
              (e) => suggestableStatus.contains(e.statusOf(authUid)),
            )
          : existingRelations.where((e) => suggestionIds!.contains(e.id));

      final suggestions = suggestableExistingRelations.followedBy(
        noRelationIds.map(
          (relationId) {
            final userId = relationId.replaceAll(authUid, '');
            return RelationshipModel(
              id: relationId,
              users: {
                authUid: UserInRelationshipStatus.none,
                userId: UserInRelationshipStatus.none,
              },
            );
          },
        ),
      );
      suggestionIds ??= suggestions.map((e) => e.id).toList();
      emit(suggestions);
    });
  }

  @override
  Future<void> close() {
    _existingRelationsStream?.cancel();
    return super.close();
  }
}

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  static const notifFriendRequests = 'friend-requests';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FriendSuggestionsCubit()),
      ],
      child: Scaffold(
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
    return CCPadding.allLarge(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search bar
          Card(
            clipBehavior: Clip.hardEdge,
            color: context.colorScheme.onInverseSurface,
            elevation: CCElevation.medium,
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
          const FriendRequestCards(),
          // Friends
          const FriendsCard(),
          if (context.select<RelationsCubit, bool>(
            (cubit) => cubit.friendIds.isNotEmpty,
          ))
            const Padding(
              padding: EdgeInsets.only(top: CCSize.medium),
              child: FriendSuggestionsCard(),
            ),
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

class FriendRequestCards extends StatelessWidget {
  const FriendRequestCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authUid = context.read<UserCubit>().state.id;
    final friendRequests =
        context.select<RelationsCubit, Iterable<RelationshipModel>>(
      (cubit) => cubit.state.where(
        (r) => r.statusOf(authUid) == UserInRelationshipStatus.isRequested,
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: friendRequests.map(
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

    return FeedCard(
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
    );
  }
}

class FriendsCard extends StatelessWidget {
  const FriendsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final friendIds = context
        .select<RelationsCubit, Iterable<String>>((cubit) => cubit.friendIds);

    return FeedCard(
      title: context.l10n.friends,
      child: friendIds.isEmpty
          ? const Text("Vous n'avez pas encore d'ami.") // TODO : l10n
          : Center(
              child: Wrap(
                runSpacing: CCSize.medium,
                children: friendIds.map(FriendPreview.new).toList(),
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

class FriendSuggestionsCard extends StatelessWidget {
  const FriendSuggestionsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final suggestionsCubit = context.watch<FriendSuggestionsCubit>();
    final authUid = context.read<UserCubit>().state.id;

    return FeedCard(
      title: 'Suggestions', // TODO : l10n
      actions: [
        CompactIconButton(
          onPressed: () => suggestionsCubit.buildSuggestions(
            authUid,
            context.read<RelationsCubit>().friendIds,
          ),
          icon: const Icon(Icons.refresh),
        ),
      ],
      child: Column(
        children: suggestionsCubit.state.map(
          (relation) {
            final userId = relation.otherUser(authUid);
            if (userId == null) return CCGap.zero;

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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RelationshipButton(
                        authUid: authUid,
                        userId: userId,
                        relation: relation,
                        asIcon: true,
                      ),
                      IconButton(
                        onPressed: FriendSuggestionsCubit.suggestableStatus
                                .contains(relation.statusOf(authUid))
                            ? () {
                                relationshipCRUD.refuseSuggestion(
                                  refuser: authUid,
                                  relationship: relation,
                                );
                                suggestionsCubit.suggestionIds
                                    ?.remove(relation.id);
                              }
                            : null,
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  contentPadding: EdgeInsets.zero,
                );
              },
            );
          },
        ).toList(),
      ),
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
    return FeedCard(
      title: context.l10n.friendRequestSent, // TODO : l10n : plural
      child: Column(
        children: requests.map(
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
                  contentPadding: EdgeInsets.zero,
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
        ).toList(),
      ),
    );
  }
}
