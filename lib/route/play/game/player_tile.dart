import 'dart:math';

import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/dartchess/export.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/route/play/game/fireworks.dart';
import 'package:crea_chess/route/play/game/game_cubit.dart';
import 'package:crea_chess/route/play/game/side.dart';
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
          leading: UserPhoto(photo: user?.photo),
          title: won
              ? Stack(
                  clipBehavior: Clip.none,
                  children: [
                    username,
                    Positioned(
                      left: -25,
                      top: -26,
                      child: SizedBox(
                        height: CCWidgetSize.xxxsmall,
                        width: CCWidgetSize.xxxsmall,
                        child: Stack(
                          children: [
                            Center(
                              child: FireworksExplosion(
                                size: CCWidgetSize.xxxsmall.toInt(),
                                fireworks: const [
                                  FireworkData(
                                    particlesWidth: 2,
                                    startCoef: 0.1,
                                    endCoef: 0.9,
                                  ),
                                  FireworkData(
                                    color: Colors.blue,
                                    particlesWidth: 2,
                                    startCoef: 0.4,
                                    rotateAngle: pi / 8,
                                  ),
                                  FireworkData(
                                    color: Colors.yellow,
                                    particlesCount: 16,
                                    particlesWidth: 2,
                                    startCoef: 0.5,
                                    rotateAngle: pi / 16,
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Transform.rotate(
                                angle: -.5,
                                child: const Text('👑'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : username,
          trailing: IconButton.outlined(
            onPressed: sideToMove == side && position != null
                ? () {
                    final move = _getRandomMove(position);
                    if (move == null) return;
                    gameCubit.onMove(move);
                  }
                : null,
            icon: const Icon(Icons.play_arrow),
          ),
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
    // if (allMoves.isNotEmpty) {
    return (allMoves..shuffle()).firstOrNull;
    // final newPosition = position.playUnchecked(mv);
    // lastMove =
    //     Move(from: toAlgebraic(mv.from), to: toAlgebraic(mv.to));
    // fen = position.fen;
    // validMoves = algebraicLegalMoves(position);
    // lastPos = position;
    // }
  }
}
