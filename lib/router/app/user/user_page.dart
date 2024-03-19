import 'package:crea_chess/package/atomic_design/widget/user/relationship_button.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_header.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_profile.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_sections.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/router/app/app_router.dart';
import 'package:crea_chess/router/shared/app_bar_actions.dart';
import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// LATER: welcome and connect page when it is the first opening of the app
// LATER: App Check

class UserRoute extends CCRoute {
  const UserRoute._() : super(name: ':usernameOrId');

  /// Instance
  static const i = UserRoute._();

  @override
  Widget build(BuildContext context, GoRouterState state) => UserPage(
        usernameOrId: state.pathParameters['usernameOrId'],
      );

  static void pushId({required String userId}) => appRouter.pushNamed(
        i.name,
        pathParameters: {'usernameOrId': userId},
      );

  static void pushUsername({required String username}) => appRouter.pushNamed(
        i.name,
        pathParameters: {'usernameOrId': '@$username'},
      );
}

class UserPage extends StatelessWidget {
  const UserPage({this.usernameOrId, super.key});

  /// Can be a user id or usernameLowercase
  final String? usernameOrId;

  static const notifPhotoEmpty = 'photo-empty';
  static const notifNameEmpty = 'name-empty';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: getSideRoutesAppBarActions(context)),
      body: BlocBuilder<UserCubit, UserModel?>(
        builder: (context, currentUser) {
          if (currentUser == null) return const LinearProgressIndicator();

          if (usernameOrId != null &&
              usernameOrId != currentUser.id &&
              usernameOrId?.toLowerCase() != currentUser.usernameLowercase) {
            return UserStreamBuilder(
              userId: usernameOrId!,
              builder: (BuildContext context, UserModel user) {
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
              },
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
            tabSections:
                UserSection.getSections(currentUser.id, currentUser.id),
          );
        },
      ),
    );
  }
}

class UserStreamBuilder extends StatelessWidget {
  /// UserId can be a uid or a username, starting with @
  const UserStreamBuilder({
    required this.userId,
    required this.builder,
    super.key,
  });

  final String userId;
  final Widget Function(BuildContext context, UserModel user) builder;

  @override
  Widget build(BuildContext context) {
    final idIsUsername = userId.startsWith('@');

    return StreamBuilder<UserModel?>(
      stream: idIsUsername
          ? userCRUD.streamUsername(userId.substring(1))
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
          return ErrorBody(exception: Exception('User not found'));
        }

        return builder(context, user);
      },
    );
  }
}
