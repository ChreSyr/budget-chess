import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/dartchess/export.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/route/play/game/game_cubit.dart';
import 'package:crea_chess/route/play/game/side.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerTile extends StatelessWidget {
  const PlayerTile({
    required this.userId,
    super.key,
  });

  final String userId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
      stream: userCRUD.stream(documentId: userId),
      builder: (context, snapshot) {
        final user = snapshot.data;

        return ListTile(
          leading: UserPhoto(photo: user?.photo),
          title: Text(user?.username ?? ''),
          trailing: Builder(
            builder: (context) {
              final gameCubit = context.watch<GameCubit>();
              final game = gameCubit.state;
              final position = game.position;

              final side = game.blackId == userId
                  ? Side.black
                  : game.whiteId == userId
                      ? Side.white
                      : null;
              final sideToMove = position.turn.toChessground;

              return IconButton.outlined(
                onPressed: sideToMove == side
                    ? () {
                        final move = _getRandomMove(position);
                        if (move == null) return;
                        gameCubit.onDartchessMove(move);
                      }
                    : null,
                icon: const Icon(Icons.play_arrow),
              );
            },
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
