import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/dialog/ok_dialog.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/button.dart';
import 'package:crea_chess/package/atomic_design/widget/feed_card.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/hub/create_challenge/create_challenge_page.dart';
import 'package:crea_chess/router/app/user/user_page.dart';
import 'package:crea_chess/router/app/user/widget/user_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyChallengesCard extends StatelessWidget {
  const MyChallengesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final authUid = context.read<UserCubit>().state.id;

    return StreamBuilder<Iterable<ChallengeModel>>(
      stream: challengeCRUD.streamFiltered(
        filter: (collection) =>
            collection.where('authorId', isEqualTo: authUid),
      ),
      builder: (context, snapshot) {
        final myChallenges = snapshot.data?.toList() ?? [];
        return FeedCard(
          title: myChallenges.isEmpty
              ? 'Prêt à lancer un défi ?'
              : "Recherche d'adversaire", // TODO : l10n
          actions: myChallenges.length > 1
              ? [
                  CompactIconButton(
                    onPressed: () => showOkDialog(
                      pageContext: context,
                      title: null,
                      content: Text(context.l10n.tipChallengesRemoved),
                    ),
                    icon: const Icon(Icons.info_outline),
                  ),
                ]
              : [],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListView.separated(
                itemBuilder: (context, index) {
                  final challenge = myChallenges[index];
                  return SizedBox(
                    height: CCWidgetSize.xxxsmall,
                    child: Row(
                      children: [
                        CCGap.small,
                        UserPhoto.fromId(
                          userId: challenge.authorId ?? '',
                          radius: CCSize.medium,
                          onTap: () => UserRoute.pushId(
                              userId: challenge.authorId ?? ''),
                          showConnectedIndicator: true,
                        ),
                        CCGap.medium,
                        const Icon(Icons.attach_money),
                        CCGap.small,
                        Text(challenge.budget.toString()),
                        const Expanded(child: CCGap.small),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () =>
                              challengeCRUD.delete(documentId: challenge.id),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  color: context.colorScheme.onBackground,
                  height: 0,
                ),
                itemCount: myChallenges.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
              CCGap.medium,
              FilledButton(
                onPressed: myChallenges.length > 7
                    ? null
                    : () => context.pushNamed(CreateChallengeRoute.i.name),
                child: const Text('Créer une partie'),
              ),
            ],
          ),
        );
      },
    );
  }
}
