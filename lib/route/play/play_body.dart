import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/firestore/challenge/challenge_crud.dart';
import 'package:crea_chess/package/firebase/firestore/challenge/challenge_model.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_crud.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_model.dart';
import 'package:crea_chess/package/game/time_control.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class HomeBody extends MainRouteBody {
  const HomeBody({super.key}) : super(id: 'home', icon: Icons.play_arrow);

  @override
  String getTitle(AppLocalizations l10n) {
    return l10n.play;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: CCWidgetSize.large4,
      child: ListView(
        shrinkWrap: true,
        children: [
          const ChallengesBoard(),
          CCGap.large,
          FilledButton(
            onPressed: () => context.go('/play/chessground'),
            child: const Text('Play'),
          ),
          CCGap.large,
          FilledButton.icon(
            onPressed: () => context.go('/play/create_challenge'),
            icon: const Icon(Icons.add),
            label: const Text('Create challenge'),
          ),
        ],
      ),
    );
  }
}

class ChallengesBoard extends StatelessWidget {
  const ChallengesBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Iterable<ChallengeModel>>(
      stream: challengeCRUD.streamAll(),
      builder: (context, snapshot) {
        final challenges = snapshot.data;
        return SizedBox(
          height: CCWidgetSize.large4,
          child: challenges == null
              ? const Center(child: CircularProgressIndicator())
              : Column(children: challenges.map(ChallengeTile.new).toList()),
        );
      },
    );
  }
}

class ChallengeTile extends StatelessWidget {
  const ChallengeTile(this.challenge, {super.key});

  final ChallengeModel challenge;

  @override
  Widget build(BuildContext context) {
    final timeControl = TimeControl(
      challenge.time ?? TimeControl.defaultTime,
      challenge.increment ?? TimeControl.defaultIncrement,
    );
    final authorId = challenge.authorId ?? '';
    if (authorId.isEmpty) {
      return const ListTile(
        leading: UserPhoto(photo: ''),
        title: Text('Corrupted challenge'),
      );
    }
    return ListTile(
      leading: StreamBuilder<UserModel?>(
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
      title: Text(
        'Budget : ${challenge.budget}\nTime control : $timeControl',
      ),
      trailing: IconButton(
        icon: const Icon(Icons.check),
        onPressed: () {},
      ),
    );
  }
}
