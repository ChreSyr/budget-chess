import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/lichess/rule.dart';
import 'package:crea_chess/route/play/challenge/card_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChallengeTile extends StatelessWidget {
  const ChallengeTile(this.challenge, {super.key});

  final ChallengeModel challenge;

  @override
  Widget build(BuildContext context) {
    final authUid = context.read<AuthenticationCubit>().state?.uid;
    final timeControl = challenge.timeControl;
    final authorId = challenge.authorId ?? '';
    if (authorId.isEmpty) return Container(); // corrupted challenge
    return CardTile(
      child: Row(
        children: [
          CCGap.small,
          UserPhoto.fromId(
            userId: authorId,
            radius: CCSize.medium,
            onTap: () => context.push('/user/@$authorId'),
          ),
          CCGap.small,
          const SizedBox(height: CCSize.large, child: VerticalDivider()),
          CCGap.xsmall,
          challenge.rule.icon,
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
            icon: Icon(authUid == authorId ? Icons.close : Icons.check),
            onPressed: authUid == authorId
                ? () => challengeCRUD.delete(documentId: challenge.id)
                : () {},
          ),
        ],
      ),
    );
  }
}
