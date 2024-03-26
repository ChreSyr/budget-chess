import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/friends/search_friend/search_friend_delegate.dart';
import 'package:crea_chess/router/app/user/user_page.dart';
import 'package:crea_chess/router/app/user/widget/user_photo.dart';
import 'package:crea_chess/router/app/user/widget/user_section_games.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// LATER: if other is not a friend, can only see friends in common

abstract class UserSection extends StatelessWidget {
  const UserSection({super.key});

  static List<UserSection> getSections(String authUid, UserModel user) {
    if (authUid == user.id) {
      return [
        UserSectionFriends(userId: user.id),
        UserSectionGames(user: user),
      ];
    } else {
      return [
        UserSectionFriends(userId: user.id),
        UserSectionGames(user: user),
      ];
    }
  }

  String getTitle(AppLocalizations l10n);
}

class UserSectionFriends extends UserSection {
  const UserSectionFriends({required this.userId, super.key});

  final String userId;

  @override
  String getTitle(AppLocalizations l10n) => l10n.friends;

  @override
  Widget build(BuildContext context) {
    return CCPadding.allMedium(
      child: StreamBuilder<Iterable<RelationshipModel>>(
        stream: relationshipCRUD.streamFriendshipsOf(userId),
        builder: (context, snapshot) {
          final relations = snapshot.data;
          const radius = CCSize.xlarge;
          final friendsPreviews = (relations ?? []).map(
            (relationship) {
              final friendId = relationship.otherUser(userId);
              if (friendId == null) return CCGap.zero;
              return UserPhoto.fromId(
                userId: friendId,
                radius: radius,
                onTap: () {
                  if (friendId == userId) {
                    while (context.canPop()) {
                      context.pop();
                    }
                  } else {
                    UserRoute.pushId(userId: friendId);
                  }
                },
              );
            },
          ).toList();
          if (context.read<UserCubit>().state.id == userId) {
            friendsPreviews.add(
              SizedBox(
                height: radius * 2,
                width: radius * 2,
                child: IconButton.outlined(
                  onPressed: () => searchFriend(context),
                  icon: const Icon(Icons.person_add),
                ),
              ),
            );
          }
          return Wrap(
            runSpacing: CCSize.medium,
            spacing: CCSize.medium,
            children: friendsPreviews,
          );
        },
      ),
    );
  }
}
