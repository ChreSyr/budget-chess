import 'package:crea_chess/package/atomic_design/widget/crown.dart';
import 'package:crea_chess/router/app/user/widget/user_photo.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:crea_chess/router/app/hub/game/game_cubit.dart';
import 'package:crea_chess/router/app/hub/game/side.dart';
import 'package:crea_chess/router/app/user/user_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerTile extends StatelessWidget {
  const PlayerTile({
    required this.userId,
    this.winner,
    super.key,
  });

  final String userId;
  final Side? winner;

  @override
  Widget build(BuildContext context) {
    final gameCubit = context.watch<GameCubit>();
    final gameState = gameCubit.state;

    // TODO : loading
    if (gameState == null) return const SizedBox.shrink();

    final game = gameState.game;
    final position = gameState.position;

    final side = game.blackId == userId
        ? Side.black
        : game.whiteId == userId
            ? Side.white
            : null;
    final sideToMove = position?.turn.toChessground;

    return StreamBuilder<UserModel?>(
      stream: userCRUD.stream(documentId: userId),
      builder: (context, snapshot) {
        final user = snapshot.data;

        final username = Text(user?.username ?? '');
        final won = side != null && side == winner;

        return ListTile(
          leading: UserPhoto(
            photo: user?.photo,
            isConnected: user?.isConnected,
            onTap: user == null
                ? null
                : () => UserRoute.pushId(userId: user.id),
          ),
          title: won
              ? Stack(
                  clipBehavior: Clip.none,
                  children: [
                    username,
                    const Positioned(
                      left: -(Crown.size / 2),
                      top: -(Crown.size / 2),
                      child: Crown(),
                    ),
                  ],
                )
              : username,
          trailing: kDebugMode
              ? IconButton.outlined(
                  onPressed: sideToMove == side && position != null
                      ? () {
                          final move = _getRandomMove(position);
                          if (move == null) return;
                          gameCubit.onMove(move);
                        }
                      : null,
                  icon: const Icon(Icons.play_arrow),
                )
              : null,
        );
      },
    );
  }

  Move? _getRandomMove(Position position) {
    if (position.isGameOver) return null;
    final allMoves = [
      for (final entry in position.legalMoves.entries)
        for (final dest in entry.value.squares)
          NormalMove(from: entry.key, to: dest),
    ];
    return (allMoves..shuffle()).firstOrNull;
  }
}
