import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/router/app/friends/friends_page.dart';
import 'package:crea_chess/router/app/user/user_page.dart';
import 'package:crea_chess/router/shared/settings_page.dart';
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
            UserRoute.i,
            SettingsRoute.i,
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
    return BlocListener<UserCubit, UserModel?>(
      listener: (context, user) {
        // If user is null, it means the email is not verified. The
        // appropriate notification is managed right above. While the
        // email is not verified, no profile notification should appear.
        context.read<NavNotifCubit>()
          ..set(
            routeName: UserRoute.i.name,
            notifId: UserPage.notifPhotoEmpty,
            count: user != null && (user.photo ?? '').isEmpty ? 1 : 0,
          )
          ..set(
            routeName: UserRoute.i.name,
            notifId: UserPage.notifNameEmpty,
            count: user != null &&
                    (user.username.isEmpty || user.username == user.id)
                ? 1
                : 0,
          );
      },
      child: BlocListener<FriendRequestsCubit, Iterable<RelationshipModel>>(
        listener: (context, requests) {
          context.read<NavNotifCubit>().set(
                routeName: FriendsRoute.i.name,
                notifId: FriendsPage.notifFriendRequests,
                count: requests.length,
              );
        },
        child: child,
      ),
    );
  }
}
