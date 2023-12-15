import 'package:crea_chess/package/atomic_design/dialog/user/email_verification.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/user/friend_preview.Dart';
import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/relationship_crud.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/relationship_model.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_cubit.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// LATER: if other is not a friend, can only see friends in common

abstract class UserSection extends StatelessWidget {
  const UserSection({super.key});

  static List<UserSection> getNotVerifiedSections() {
    return [
      const UserSectionDetails(isVerified: false),
    ];
  }

  static List<UserSection> getSections(String current, String other) {
    if (current == other) {
      return [
        UserSectionFriends(userId: other),
        const UserSectionDetails(),
      ];
    } else {
      return [UserSectionFriends(userId: other)];
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
    return StreamBuilder<Iterable<RelationshipModel>>(
      stream: relationshipCRUD.friendsOf(userId),
      builder: (context, snapshot) {
        final relations = snapshot.data;
        final List<Widget> friendsPreviews = (relations ?? [])
            .map(
              (relationship) => FriendPreview(
                friendId: (relationship.users ?? [])
                    .where((id) => id != userId)
                    .first,
              ),
            )
            .toList();
        if (context.read<UserCubit>().state?.id == userId) {
          friendsPreviews.add(const FriendPreview(friendId: 'add'));
        }
        return Wrap(
          runSpacing: CCSize.medium,
          spacing: CCSize.medium,
          children: friendsPreviews,
        );
      },
    );
  }
}

class UserSectionDetails extends UserSection {
  const UserSectionDetails({this.isVerified = true, super.key});

  final bool isVerified;

  @override
  String getTitle(AppLocalizations l10n) => l10n.details;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.email),
      title: Text(context.read<AuthenticationCubit>().state?.email ?? ''),
      trailing: isVerified
          ? null
          : const Icon(Icons.priority_high, color: Colors.red),
      onTap: isVerified
          ? null
          : () => showEmailVerificationDialog(context),
    );
  }
}
