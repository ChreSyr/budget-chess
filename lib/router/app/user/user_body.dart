import 'package:crea_chess/package/atomic_design/widget/user/relationship_button.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_header.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_profile.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_sections.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/app_router.dart';
import 'package:crea_chess/router/shared/route_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  static const notifPhotoEmpty = 'photo-empty';
  static const notifNameEmpty = 'name-empty';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserModel?>(
      builder: (context, currentUser) {
        // creating or deleting the user
        if (currentUser == null) return const LinearProgressIndicator();

        if (usernameOrId != null &&
            usernameOrId != currentUser.usernameLowercase) {
          Widget builder(BuildContext context, UserModel user) {
            return UserProfile(
              header: UserHeader(
                userId: user.id,
                banner: user.banner,
                photo: user.photo,
                username: user.username,
                isConnected: user.isConnected,
                editable: false,
              ),
              relationshipWidget: RelationshipButton(userId: user.id),
              tabSections: UserSection.getSections(currentUser.id, user.id),
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
            userId: currentUser.id,
            banner: currentUser.banner,
            photo: currentUser.photo,
            username: currentUser.username,
            isConnected: currentUser.isConnected,
            editable: true,
          ),
          tabSections: UserSection.getSections(currentUser.id, currentUser.id),
        );
      },
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