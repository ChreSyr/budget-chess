import 'dart:async';

import 'package:crea_chess/package/atomic_design/dialog/relationship/answer_friend_request.dart';
import 'package:crea_chess/package/atomic_design/dialog/relationship/cancel_friend_request.dart';
import 'package:crea_chess/package/atomic_design/dialog/relationship/unblock_user.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/widget/simple_badge.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class QueriedUsersCubit extends Cubit<Iterable<UserModel>> {
  QueriedUsersCubit() : super([]);

  StreamSubscription<Iterable<UserModel>>? _streamSubscription;
  String _query = '';

  Future<void> setQuery(String query) async {
    final newQuery = query.toLowerCase();
    if (_query == newQuery) return;

    _query = newQuery;
    await _streamSubscription?.cancel();

    if (_query.isEmpty) return emit([]);

    // The character \uf8ff used in the query is a very high code point in
    //the Unicode range (it is a Private Usage Area [PUA] code).
    // Because it is after most regular characters in Unicode, the query
    // matches all values that start with queryText.
    _streamSubscription = userCRUD
        .streamFiltered(
          filter: (collection) => collection
              .where('usernameLowercase', isGreaterThanOrEqualTo: _query)
              .where('usernameLowercase', isLessThan: '$_query\uf8ff'),
        )
        .listen(emit);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}

void searchFriend(BuildContext context) {
  showSearch(
    context: context,
    delegate: FriendSearchDelegate(
      context.l10n,
      currentUser: context.read<UserCubit>().state,
    ),
  );
}

class FriendSearchDelegate extends SearchDelegate<String?> {
  FriendSearchDelegate(AppLocalizations l10n, {this.currentUser})
      : super(searchFieldLabel: l10n.searchUsername);

  final UserModel? currentUser;

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: theme.colorScheme.brightness == Brightness.dark
            ? Colors.grey[900]
            : null,
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          const InputDecorationTheme(border: InputBorder.none),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
        context.read<QueriedUsersCubit>().setQuery('');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    context.read<QueriedUsersCubit>().setQuery(query);

    return BlocBuilder<QueriedUsersCubit, Iterable<UserModel>>(
      builder: (context, users) {
        // if (users.isEmpty) return const LinearProgressIndicator();
        // if (query.isEmpty) return Container();
        return ListView(
          children: users
              .where((user) => user != currentUser)
              .map<Widget>((user) => getUserTile(context, user))
              .toList(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}

Widget getUserTile(BuildContext context, UserModel user) {
  final currentUserId = context.read<UserCubit>().state?.id;
  if (currentUserId == null) return Container(); // should never happen
  final userId = user.id;
  final relationshipId = relationshipCRUD.getId(currentUserId, userId);

  return StreamBuilder<RelationshipModel?>(
    stream: relationshipCRUD.stream(documentId: relationshipId),
    builder: (context, snapshot) {
      Widget getTrailing() {
        final relationship = snapshot.data;
        final sendRequestButton = IconButton(
          icon: const Icon(Icons.person_add),
          onPressed: () {
            relationshipCRUD.sendFriendRequest(
              fromUserId: currentUserId,
              toUserId: userId,
            );
            snackBarNotify(context, context.l10n.friendRequestSent);
          },
        );

        if (relationship == null) return sendRequestButton;
        switch (relationship.status) {
          case null:
          case RelationshipStatus.canceled:
            return sendRequestButton;
          case RelationshipStatus.requestedByFirst:
          case RelationshipStatus.requestedByLast:
            final canAccept = relationship.isRequestedBy(userId);
            return canAccept
                ? SimpleIconButtonBadge(
                    child: IconButton(
                      onPressed: () => showAnswerFriendRequestDialog(
                        context,
                        relationship.requester,
                      ),
                      icon: const Icon(Icons.mail),
                    ),
                  )
                : IconButton(
                    onPressed: () => showCancelFriendRequestDialog(
                      context,
                      userId,
                    ),
                    icon: const Icon(Icons.send),
                  );
          case RelationshipStatus.friends:
            return const IconButton(
              icon: Icon(Icons.check),
              onPressed: null,
            );
          case RelationshipStatus.blockedByFirst:
          case RelationshipStatus.blockedByLast:
            return IconButton(
              icon: const Icon(Icons.block),
              onPressed: relationship.isBlockedBy(userId)
                  ? null
                  : () => showUnblockUserDialog(context, userId),
            );
        }
      }

      final trailing = getTrailing();

      return ListTile(
        leading: UserPhoto(photo: user.photo),
        title: Text(user.username ?? ''),
        trailing: trailing,
        onTap: () => context.go('/user/@${user.usernameLowercase}'),
      );
    },
  );
}
