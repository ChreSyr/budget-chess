import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/route/friends/friends_body.dart';
import 'package:crea_chess/route/user/user_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef NavNotifs = Map<String, Map<String, int>>;

extension NavNotifsExt on NavNotifs {
  int count({required String routeId}) {
    try {
      return this[routeId]!.values.reduce((a, b) => a + b);
    } catch (_) {
      return 0;
    }
  }
}

class NavNotifCubit extends Cubit<NavNotifs> {
  NavNotifCubit()
      : super({
          for (var e in [
            FriendsBody.data,
            UserBody.data,
          ].map((e) => e.id))
            e: {},
        });

  void set({
    required String routeId,
    required String notifId,
    required int count,
  }) {
    final newState = NavNotifs.from(state);
    // Will throw an exception if routeId is not a valid main route id
    newState[routeId]![notifId] = count;
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
    return BlocListener<AuthenticationCubit, User?>(
      listener: (context, auth) {
        context.read<NavNotifCubit>().set(
              routeId: UserBody.data.id,
              notifId: UserBody.notifEmailNotVerified,
              count: auth != null && !auth.isVerified ? 1 : 0,
            );
      },
      child: BlocListener<UserCubit, UserModel?>(
        listener: (context, user) {
          // If user is null, it means the email is not verified. The
          // appropriate notification is managed right above. While the
          // email is not verified, no profile notification should appear.
          context.read<NavNotifCubit>()
            ..set(
              routeId: UserBody.data.id,
              notifId: UserBody.notifPhotoEmpty,
              count: user != null && (user.photo ?? '').isEmpty ? 1 : 0,
            )
            ..set(
              routeId: UserBody.data.id,
              notifId: UserBody.notifNameEmpty,
              count: user != null &&
                      (user.username.isEmpty || user.username == user.id)
                  ? 1
                  : 0,
            );
        },
        child: BlocListener<FriendRequestsCubit, Iterable<RelationshipModel>>(
          listener: (context, requests) {
            context.read<NavNotifCubit>().set(
                  routeId: FriendsBody.data.id,
                  notifId: FriendsBody.notifFriendRequests,
                  count: requests.length,
                );
          },
          child: child,
        ),
      ),
    );
  }
}
