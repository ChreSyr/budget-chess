import 'package:crea_chess/package/atomic_design/dialog/relationship/answer_friend_request.dart';
import 'package:crea_chess/package/atomic_design/dialog/user/delete_account.dart';
import 'package:crea_chess/package/atomic_design/widget/simple_badge.dart';
import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/relationship_crud.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/relationship_model.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_cubit.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_model.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class RouteBody extends StatelessWidget {
  const RouteBody({
    this.padded = true,
    this.centered = true,
    this.scrolled = true,
    super.key,
  });

  final bool padded;
  final bool centered;
  final bool scrolled;

  String getTitle(AppLocalizations l10n);

  List<Widget>? getActions(BuildContext context) => null;
}

enum _MenuChoices {
  signin(whenLoggedOut: true),
  signout(whenLoggedOut: false),
  deleteAccount(whenLoggedOut: false);

  const _MenuChoices({required this.whenLoggedOut});

  final bool whenLoggedOut;

  String getLocalization(AppLocalizations l10n) {
    switch (this) {
      case _MenuChoices.signin:
        return l10n.signin;
      case _MenuChoices.signout:
        return l10n.signout;
      case _MenuChoices.deleteAccount:
        return l10n.deleteAccount;
    }
  }

  IconData getIcon() {
    switch (this) {
      case _MenuChoices.signin:
        return Icons.login;
      case _MenuChoices.signout:
        return Icons.logout;
      case _MenuChoices.deleteAccount:
        return Icons.delete_forever;
    }
  }
}

abstract class MainRouteBody extends RouteBody {
  const MainRouteBody({
    required this.id,
    required this.icon,
    super.padded,
    super.centered,
    super.scrolled,
    super.key,
  });

  final String id;
  final IconData icon;

  @override
  List<Widget> getActions(BuildContext context) {
    return [
      Row(
        children: [
          BlocBuilder<UserCubit, UserModel?>(
            builder: (context, user) {
              if (user == null || user.id == null) return Container();
              return StreamBuilder<Iterable<RelationshipModel>>(
                stream: relationshipCRUD.requestsAbout(user.id!),
                builder: (context, snapshot) {
                  final requests = snapshot.data ?? [];
                  final requestsTo =
                      requests.where((e) => !e.isRequestedBy(user.id!));
                  return MenuAnchor(
                    builder: (
                      BuildContext context,
                      MenuController controller,
                      Widget? _,
                    ) {
                      final iconButton = IconButton(
                        onPressed: () => controller.isOpen
                            ? controller.close()
                            : controller.open(),
                        icon: const Icon(Icons.notifications),
                      );
                      if (requestsTo.isEmpty) {
                        return iconButton;
                      } else {
                        return SimpleIconButtonBadge(child: iconButton);
                      }
                    },
                    menuChildren: requestsTo.isEmpty
                        ? [
                            MenuItemButton(
                              leadingIcon: const Icon(Icons.done_all),
                              onPressed: () {},
                              child: const Text('Aucune notification'),
                            ),
                          ]
                        : requestsTo
                            .map(
                              (e) => MenuItemButton(
                                leadingIcon: const Icon(Icons.mail),
                                onPressed: () {
                                  final requester = e.requester;
                                  return showAnswerFriendRequestDialog(
                                    context,
                                    requester,
                                  );
                                },
                                child: Text(context.l10n.friendRequest),
                              ),
                            )
                            .toList(),
                  );
                },
              );
            },
          ),
          BlocBuilder<AuthenticationCubit, User?>(
            builder: (context, auth) {
              final isLoggedOut = auth == null;
              void signout() {
                authenticationCRUD.signOut();
                context
                  ..go('/user')
                  ..push('/sso');
              }

              return MenuAnchor(
                builder: (
                  BuildContext context,
                  MenuController controller,
                  Widget? _,
                ) {
                  return IconButton(
                    onPressed: () => controller.isOpen
                        ? controller.close()
                        : controller.open(),
                    icon: const Icon(Icons.more_vert),
                  );
                },
                menuChildren: _MenuChoices.values
                    .where((e) => isLoggedOut == e.whenLoggedOut)
                    .map(
                      (e) => MenuItemButton(
                        leadingIcon: Icon(e.getIcon()),
                        onPressed: () {
                          switch (e) {
                            case _MenuChoices.signin:
                              context.push('/sso');
                            case _MenuChoices.signout:
                              signout();
                            case _MenuChoices.deleteAccount:
                              showDeleteAccountDialog(context, auth!);
                          }
                        },
                        style: switch (e) {
                          _MenuChoices.deleteAccount => ButtonStyle(
                              iconColor: MaterialStateColor.resolveWith(
                                (states) => Colors.red,
                              ),
                              foregroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.red,
                              ),
                            ),
                          _ => null,
                        },
                        child: Text(e.getLocalization(context.l10n)),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    ];
  }
}
