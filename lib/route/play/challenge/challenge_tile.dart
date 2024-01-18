import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/firestore/challenge/challenge_model.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_crud.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_model.dart';
import 'package:crea_chess/route/play/challenge/card_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChallengeTile extends StatelessWidget {
  const ChallengeTile(this.challenge, {super.key});

  final ChallengeModel challenge;

  @override
  Widget build(BuildContext context) {
    final timeControl = challenge.timeControl;
    final authorId = challenge.authorId ?? '';
    if (authorId.isEmpty) {
      return const ListTile(
        leading: UserPhoto(photo: ''),
        title: Text('Corrupted challenge'),
      );
    }
    return CardTile(
      child: Row(
        children: [
          CCGap.small,
          SizedBox(
            width: CCSize.xlarge,
            child: StreamBuilder<UserModel?>(
              stream: userCRUD.stream(documentId: authorId),
              builder: (context, snapshot) {
                final author = snapshot.data;
                if (author == null) return const UserPhoto(photo: '');
                return GestureDetector(
                  onTap: () => context.go('/user/@${author.usernameLowercase}'),
                  child: UserPhoto.fromId(userId: authorId),
                );
              },
            ),
          ),
          CCGap.small,
          const SizedBox(height: CCSize.large, child: VerticalDivider()),
          CCGap.xsmall,
          const Icon(Icons.attach_money),
          CCGap.small,
          Text(challenge.budget.toString()),
          CCGap.small,
          const SizedBox(height: CCSize.large, child: VerticalDivider()),
          CCGap.xsmall,
          Icon(timeControl.speed.icon),
          CCGap.small,
          Text(timeControl.toString()),
          const Expanded(child: CCGap.small),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
