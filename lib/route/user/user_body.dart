import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/user/relationship_button.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_header.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_profile.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_sections.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:crea_chess/route/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// LATER: welcome and connect page when it is the first opening of the app
// LATER: App Check

class UserBody extends RouteBody {
  const UserBody({this.usernameOrId, super.key});

  /// Can be a user id or usernameLowercase
  final String? usernameOrId;

  @override
  String getTitle(AppLocalizations l10n) => l10n.profile;

  static final data = MainRouteData(
    id: 'user',
    icon: Icons.person,
    getTitle: (l10n) => 'Voir mon profil',
  );
  static const notifEmailNotVerified = 'email-not-verified';
  static const notifPhotoEmpty = 'photo-empty';
  static const notifNameEmpty = 'name-empty';

  @override
  Widget build(BuildContext context) {
    return AuthVerifier(
      builder: (context, authUid) {
        return BlocBuilder<UserCubit, UserModel?>(
          builder: (context, currentUser) {
            // creating or deleting the user
            if (currentUser == null) return const LinearProgressIndicator();

            if (usernameOrId != null &&
                usernameOrId != currentUser.usernameLowercase) {
              Widget builder(BuildContext context, UserModel user) {
                final relationshipWidget = StreamBuilder<RelationshipModel?>(
                  stream: relationshipCRUD.stream(
                    documentId: relationshipCRUD.getId(authUid, user.id),
                  ),
                  builder: (context, snapshot) {
                    final streaming =
                        snapshot.connectionState == ConnectionState.active;
                    final relation = snapshot.data;

                    return (streaming && (user.id) != authUid
                            ? getRelationshipButton(context, relation)
                            : null) ??
                        Container();
                  },
                );

                return UserProfile(
                  header: UserHeader(
                    userId: user.id,
                    banner: user.banner,
                    photo: user.photo,
                    username: user.username,
                    editable: false,
                  ),
                  relationshipWidget: relationshipWidget,
                  tabSections: UserSection.getSections(authUid, user.id),
                );
              }

              return UserStreamBuilder(
                userId: usernameOrId!,
                notFound: UserStreamBuilder(
                  userId: usernameOrId!,
                  idIsUsername: true,
                  builder: builder,
                ),
                builder: builder,
              );
            }

            return UserProfile(
              header: UserHeader(
                userId: authUid,
                banner: currentUser.banner,
                photo: currentUser.photo,
                username: currentUser.username,
                editable: true,
              ),
              tabSections: UserSection.getSections(authUid, authUid),
            );
          },
        );
      },
    );
  }
}

/// Check if the the user is connected and if its email is verified.
///
/// The builder function is called when the email is verified.
class AuthVerifier extends StatelessWidget {
  const AuthVerifier({required this.builder, super.key});

  final Widget Function(BuildContext context, String authId) builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, User?>(
      builder: (context, auth) {
        if (auth == null) {
          return const NotConnectedScreen();
        } else if (!auth.isVerified) {
          // If the email is not verified yet
          return UserProfile(
            header: UserHeader.notVerified(authId: auth.uid),
            tabSections: UserSection.getNotVerifiedSections(),
          );
        } else {
          return builder(context, auth.uid);
        }
      },
    );
  }
}

class NotConnectedScreen extends StatelessWidget {
  const NotConnectedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(context.l10n.notConnected),
          CCGap.large,
          FilledButton.icon(
            onPressed: () => context.push('/sso'),
            icon: const Icon(Icons.login),
            label: Text(context.l10n.signin),
          ),
        ],
      ),
    );
  }
}

class UserStreamBuilder extends StatelessWidget {
  const UserStreamBuilder({
    required this.userId,
    required this.builder,
    this.idIsUsername = false,
    this.notFound,
    super.key,
  });

  final String userId;
  final bool idIsUsername;
  final Widget Function(BuildContext, UserModel) builder;
  final Widget? notFound;

  @override
  Widget build(BuildContext context) {
    if (idIsUsername) {}

    return StreamBuilder<UserModel?>(
      stream: idIsUsername
          ? userCRUD.streamUsername(userId)
          : userCRUD.stream(documentId: userId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorBody(exception: Exception('An error occurred'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        }

        final user = snapshot.data;
        if (user == null) {
          return notFound ??
              ErrorBody(
                exception: Exception('User not found'),
              );
        }

        return builder(context, user);
      },
    );
  }
}
