import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/route/hub/challenge/challenges_board.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class HubBody extends RouteBody {
  const HubBody({super.key}) : super(isBottomRoute: true);

  static final MainRouteData data = MainRouteData(
    id: 'hub',
    icon: Icons.home,
    getTitle: (l10n) => l10n.hub,
  );

  @override
  String getTitle(AppLocalizations l10n) {
    return l10n.hub;
  }

  @override
  List<Widget> getActions(BuildContext context) {
    return [
      OutlinedButton(
        onPressed: () => context.push('/hub/chessground'),
        child: const Text('Test'), // TODO : remove
      ),
      CCGap.medium,
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
