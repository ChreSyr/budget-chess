import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/user/relationship_button.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_header.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_profile.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_sections.dart';
import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/relationship_crud.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/relationship_model.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_crud.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_cubit.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_model.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/route/nav_notif_cubit.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:crea_chess/route/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// LATER: welcome and connect page when it is the first opening of the app
// LATER: App Check

class UserBody extends MainRouteBody {
  const UserBody({this.routeUsernameLowercase, super.key})
      : super(id: routeId, icon: Icons.person, centered: false, padded: false);

  final String? routeUsernameLowercase;

  @override
  String getTitle(AppLocalizations l10n) => l10n.profile;

  static const routeId = 'user';
  static const notifEmailNotVerified = 'email-not-verified';
  static const notifPhotoEmpty = 'photo-empty';
  static const notifNameEmpty = 'name-empty';

  @override
  Widget build(BuildContext context) {
    return AuthVerifier(
      builder: (context, authId) {
        return IncompleteProfileNotifier(
          builder: (context, currentUser) {
            // creating the user, may never happen, or very very shortly
            if (currentUser == null) return const CircularProgressIndicator();

            if (routeUsernameLowercase != null &&
                routeUsernameLowercase != currentUser.usernameLowercase) {
              return StreamBuilder<Iterable<UserModel>>(
                stream: userCRUD.streamUsername(routeUsernameLowercase!),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return ErrorBody(
                      exception: Exception('An error occurred'),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LinearProgressIndicator();
                  }

                  final user = snapshot.data?.firstOrNull;
                  if (user == null) {
                    return ErrorBody(
                      exception: Exception('Username not found'),
                    );
                  }
                  if (user.id == null) {
                    return ErrorBody(exception: Exception('User id is empty'));
                  }
                  final userId = user.id!;

                  final relationshipWidget = StreamBuilder<RelationshipModel?>(
                    stream: relationshipCRUD.stream(
                      documentId: relationshipCRUD.getId(authId, userId),
                    ),
                    builder: (context, snapshot) {
                      final streaming =
                          snapshot.connectionState == ConnectionState.active;
                      final relation = snapshot.data ??
                          RelationshipModel(users: [userId, authId]);

                      return (streaming && userId != authId
                              ? getRelationshipButton(context, relation)
                              : null) ??
                          Container();
                    },
                  );

                  return UserProfile(
                    header: UserHeader(
                      userId: userId,
                      banner: user.banner,
                      photo: user.photo,
                      username: user.username,
                      editable: false,
                    ),
                    relationshipWidget: relationshipWidget,
                    tabSections: UserSection.getSections(authId, userId),
                  );
                },
              );
            }

            return UserProfile(
              header: UserHeader(
                userId: authId,
                banner: currentUser.banner,
                photo: currentUser.photo,
                username: currentUser.username,
                editable: true,
              ),
              tabSections: UserSection.getSections(authId, authId),
            );
          },
        );
      },
    );

    // return BlocBuilder<AuthenticationCubit, User?>(
    //   builder: (context, auth) {
    //     if (auth != null && !auth.isVerified) {
    //       context.read<NavNotifCubit>().add(id, notifEmailNotVerified);
    //     } else {
    //       context.read<NavNotifCubit>().remove(id, notifEmailNotVerified);
    //     }

    //     if (auth == null) {
    //       // Note : if auth is null, cannot see users profiles.
    //       // LATER : Keep it ?
    //       return Column(
    //         children: [
    //           const Text('Vous n\'êtes pas connecté'), // TODO : l10n
    //           CCGap.large,
    //           FilledButton.icon(
    //             onPressed: () => context.push('/sso'),
    //             icon: const Icon(Icons.login),
    //             label: Text(context.l10n.signin),
    //           ),
    //         ],
    //       );
    //     } else if (!auth.isVerified) {
    //       // If the email is not confirmed yet
    //       // LATER: rethink : authenticated simply with phone ?
    //       return UserProfile(
    //         header: UserHeader.notVerified(authId: auth.uid),
    //         tabSections: UserSection.getNotVerifiedSections(),
    //       );
    //     }

    //     final authId = auth.uid;

    //     if (routeUsername != null) {
    //       return StreamBuilder<Iterable<UserModel>>(
    //         stream: userCRUD.streamUsername(routeUsername!),
    //         builder: (context, snapshot) {
    //           final user = snapshot.data?.firstOrNull;
    //           if (snapshot.hasError) return UsernameNoFoundBody();
    //           if (user == null) return const LinearProgressIndicator();
    //           if (user.id == null) {
    //             return ErrorBody(exception: Exception('User id is empty'));
    //           }
    //           final userId = user.id!;

    //           final relationshipWidget = StreamBuilder<RelationshipModel?>(
    //             stream: relationshipCRUD.stream(
    //               documentId: relationshipCRUD.getId(authId, userId),
    //             ),
    //             builder: (context, snapshot) {
    //               final streaming =
    //                   snapshot.connectionState == ConnectionState.active;
    //               final relation = snapshot.data ??
    //                   RelationshipModel(users: [userId, authId]);

    //               return (streaming && userId != authId
    //                       ? getRelationshipButton(context, relation)
    //                       : null) ??
    //                   Container();
    //             },
    //           );

    //           return UserProfile(
    //             header: UserHeader(
    //               userId: userId,
    //               banner: user.banner,
    //               photo: user.photo,
    //               username: user.username,
    //               editable: false,
    //             ),
    //             relationshipWidget: relationshipWidget,
    //             tabSections: UserSection.getSections(authId, userId),
    //           );
    //         },
    //       );
    //     }

    //     return BlocConsumer<UserCubit, UserModel?>(
    //       listener: (context, user) {
    //         if (user == null) {
    //           context.read<NavNotifCubit>().remove(id, notifPhotoEmpty);
    //           context.read<NavNotifCubit>().remove(id, notifNameEmpty);
    //         } else {
    //           if ((user.photo ?? '').isEmpty) {
    //             context.read<NavNotifCubit>().add(id, notifPhotoEmpty);
    //           } else {
    //             context.read<NavNotifCubit>().remove(id, notifPhotoEmpty);
    //           }
    //           if ((user.username ?? '').isEmpty || user.username == user.id) {
    //             context.read<NavNotifCubit>().add(id, notifNameEmpty);
    //           } else {
    //             context.read<NavNotifCubit>().remove(id, notifNameEmpty);
    //           }
    //         }
    //       },
    //       builder: (context, user) {
    //         // creating the user
    //         if (user == null) return const CircularProgressIndicator();

    //         return UserProfile(
    //           header: UserHeader(
    //             userId: userId,
    //             banner: user.banner,
    //             photo: user.photo,
    //             username: user.username,
    //             editable: true,
    //           ),
    //           tabSections: UserSection.getSections(authId, userId),
    //         );
    //       },
    //     );
    //   },
    // );
  }
}

class AuthVerifier extends StatelessWidget {
  const AuthVerifier({required this.builder, super.key});

  final Widget Function(BuildContext context, String authId) builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, User?>(
      builder: (context, auth) {
        if (auth != null && !auth.isVerified) {
          // TODO : cubit.set(routeId, notifId, isNotified)
          context
              .read<NavNotifCubit>()
              .add(UserBody.routeId, UserBody.notifEmailNotVerified);
        } else {
          context
              .read<NavNotifCubit>()
              .remove(UserBody.routeId, UserBody.notifEmailNotVerified);
        }

        if (auth == null) {
          // Note : if auth is null, cannot see users profiles.
          // LATER : Keep it ?
          return Column(
            children: [
              const Text("Vous n'êtes pas connecté"), // TODO : l10n
              CCGap.large,
              FilledButton.icon(
                onPressed: () => context.push('/sso'),
                icon: const Icon(Icons.login),
                label: Text(context.l10n.signin),
              ),
            ],
          );
        } else if (!auth.isVerified) {
          // If the email is not confirmed yet
          // LATER: rethink : authenticated simply with phone ?
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

class IncompleteProfileNotifier extends StatelessWidget {
  const IncompleteProfileNotifier({required this.builder, super.key});

  final Widget Function(BuildContext, UserModel?) builder;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserModel?>(
      listener: (context, user) {
        // TODO : maybe in UserCubit ?
        // Notifications management center
        if (user == null) {
          // Here, the email is not verified. Notif is managed by AuthVerifier.
          // While it is not verified, no other notification should appear.
          context
              .read<NavNotifCubit>()
              .remove(UserBody.routeId, UserBody.notifPhotoEmpty);
          context
              .read<NavNotifCubit>()
              .remove(UserBody.routeId, UserBody.notifNameEmpty);
        } else {
          if ((user.photo ?? '').isEmpty) {
            context
                .read<NavNotifCubit>()
                .add(UserBody.routeId, UserBody.notifPhotoEmpty);
          } else {
            context
                .read<NavNotifCubit>()
                .remove(UserBody.routeId, UserBody.notifPhotoEmpty);
          }
          if ((user.username ?? '').isEmpty || user.username == user.id) {
            context
                .read<NavNotifCubit>()
                .add(UserBody.routeId, UserBody.notifNameEmpty);
          } else {
            context
                .read<NavNotifCubit>()
                .remove(UserBody.routeId, UserBody.notifNameEmpty);
          }
        }
      },
      builder: builder,
    );
  }
}
