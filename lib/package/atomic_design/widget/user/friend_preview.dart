import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_crud.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_cubit.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_model.dart';
import 'package:crea_chess/route/user/search_friend/search_friend_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FriendPreview extends StatelessWidget {
  const FriendPreview({required this.friendId, super.key});

  final String friendId;

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.read<UserCubit>().state?.id;
    const radius = CCSize.xlarge;

    if (friendId == 'add') {
      return SizedBox(
        height: radius * 2,
        width: radius * 2,
        child: IconButton.outlined(
          onPressed: () => searchFriend(context),
          icon: const Icon(Icons.person_add),
        ),
      );
    }

    return StreamBuilder<UserModel?>(
      stream: userCRUD.stream(documentId: friendId),
      builder: (context, snapshot) {
        final friend = snapshot.data;
        if (friend == null) {
          return const SizedBox(
            height: radius * 2,
            width: radius * 2,
          );
        }
        return InkWell(
          onTap: () {
            if (friendId == currentUserId) {
              while (context.canPop()) {
                context.pop();
              }
            } else {
              context.go('/user/@${friend.usernameLowercase}');
            }
          },
          child: UserPhoto(
            photo: friend.photo,
            radius: radius,
          ),
        );
      },
    );
  }
}
