import 'package:chessground/chessground.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/route/play/game/game_cubit.dart';
import 'package:crea_chess/route/play/setup/board_settings_cubit.dart';
import 'package:crea_chess/route/play/setup/setup_body.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:dartchess_webok/dartchess_webok.dart' as dc;
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:crea_chess/route/play/game/side.dart';

class GameBody extends RouteBody {
  const GameBody({super.key})
      : super(
          padded: false,
          centered: false,
          scrolled: false,
        );

  @override
  String getTitle(AppLocalizations l10n) {
    return 'Game'; // TODO : l10n
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameCubit(
        const GameModel(
          id: 'testing',
          challenge: ChallengeModel(
            id: '0',
            authorId: 'mael',
            budget: 19,
          ),
          whiteId: 'WVJCtjHxhaU4c5beOaN87Rt9E4F2',
          blackId: '2Kp6LTX4TqSVPphhCtloPZ9oPo43',
          blackHalfFen: '8/8/pppppppp/rnbqkbnr',
          status: GameStatus.setup,
        ),
      ),
      child: const _GameBody(),
    );
  }
}

class _GameBody extends StatelessWidget {
  const _GameBody();

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameCubit>().state;
    final authUid = context.watch<AuthenticationCubit>().state?.uid;

    final side = game.blackId == authUid
        ? Side.black
        : game.whiteId == authUid
            ? Side.white
            : null;

    if (side != null && game.status == GameStatus.setup) {
      return SetupBody(side: side);
    }

    final boardSettings = context.watch<BoardSettingsCubit>().state;
    final interactableSide = side?.interactable ?? InteractableSide.none;
    final position = game.position;

    final gameCubit = context.read<GameCubit>();

    return Center(
      child: Board(
        size: MediaQuery.of(context).size.width,
        settings: boardSettings,
        data: BoardData(
          interactableSide: interactableSide,
          validMoves: side?.toDc == position.turn
              ? dc.algebraicLegalMoves(position)
              : IMap(const {}),
          orientation: side ?? Side.white,
          fen: position.fen,
          lastMove: null,
          sideToMove: position.turn == dc.Side.white ? Side.white : Side.black,
          isCheck: position.isCheck,
          premove: null,
        ),
        onMove: gameCubit.onMove,
        onPremove: (move) {},
      ),
    );
  }
}
