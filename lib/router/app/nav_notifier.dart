import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/router/app/chats/chat_home_page.dart';
import 'package:crea_chess/router/app/friends/friends_page.dart';
import 'package:crea_chess/router/app/shared_cubit/relations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef NavNotifs = Map<String, Map<String, int>>;

extension NavNotifsExt on NavNotifs {
  int count({required String routeName}) {
    try {
      return this[routeName]!.values.reduce((a, b) => a + b);
    } catch (_) {
      return 0;
    }
  }
}

class NavNotifCubit extends Cubit<NavNotifs> {
  NavNotifCubit()
      : super({
          for (var e in [
            FriendsRoute.i,
            ChatHomeRoute.i,
          ].map((route) => route.name))
            e: {},
        });

  void set({
    required String routeName,
    required String notifId,
    required int count,
  }) {
    final newState = NavNotifs.from(state);
    // Will throw an exception if routeId is not a valid main route id
    newState[routeName]![notifId] = count;
    emit(newState);
  }
}

// Managing the notifications here allows for the notifs to be shown from the
// app start, and not just when the route who wants to have a notification badge
// is first loaded (when the user taps on it)
class NavNotifier extends StatelessWidget {
  const NavNotifier({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final authUid = context.read<UserCubit>().state.id;

    return BlocListener<NewMessagesCubit, Iterable<MessageModel>>(
      listener: (context, newMessages) {
        context.read<NavNotifCubit>().set(
              routeName: ChatHomeRoute.i.name,
              notifId: ChatHomePage.notifNewMessages,
              count: newMessages.length,
            );
      },
      child: BlocListener<RelationsCubit, Iterable<RelationshipModel>>(
        listener: (context, relations) {
          context.read<NavNotifCubit>().set(
                routeName: FriendsRoute.i.name,
                notifId: FriendsPage.notifFriendRequests,
                count: relations
                    .where(
                      (r) =>
                          r.statusOf(authUid) ==
                          UserInRelationshipStatus.isRequested,
                    )
                    .length,
              );
        },
        child: child,
      ),
    );
  }
}
