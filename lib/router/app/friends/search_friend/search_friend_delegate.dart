import 'dart:async';

import 'package:crea_chess/package/atomic_design/widget/user/relationship_button.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/user/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    // The character \uf8ff used in the query is a very medium code point in
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
    final authUid = context.read<UserCubit>().state.id;

    return BlocBuilder<QueriedUsersCubit, Iterable<UserModel>>(
      builder: (context, users) {
        return ListView(
          children: users
              .where((user) => user != currentUser)
              .map<Widget>(
                (user) => ListTile(
                  leading: UserPhoto(
                    photo: user.photo,
                    isConnected: user.isConnected,
                  ),
                  title: Text(user.username),
                  trailing: RelationshipButton(
                    authUid: authUid,
                    userId: user.id,
                    asIcon: true,
                  ),
                  onTap: () => UserRoute.pushId(userId: user.id),
                ),
              )
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
