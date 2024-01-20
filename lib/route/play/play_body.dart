import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/route/play/challenge/challenges_board.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class HomeBody extends MainRouteBody {
  const HomeBody({super.key})
      : super(
          id: 'home',
          icon: Icons.play_arrow,
          padded: false,
          scrolled: false,
        );

  @override
  String getTitle(AppLocalizations l10n) {
    return l10n.play;
  }

  @override
  List<Widget> getActions(BuildContext context) {
    return [
      FilledButton(
        onPressed: () => context.go('/play/chessground'),
        child: const Text('Play'),
      ),
      ...super.getActions(context),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChallengeFiltersCubit(),
        ),
        BlocProvider(
          create: (context) => ChallengeFilterCubit(),
        ),
      ],
      child: const ChallengesBoard(),
    );
  }
}
