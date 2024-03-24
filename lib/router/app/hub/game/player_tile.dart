import 'package:crea_chess/package/atomic_design/dialog/yes_no.dart';
import 'package:crea_chess/package/atomic_design/widget/crown.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/lichess/lichess_icons.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:crea_chess/router/app/hub/game/game_cubit.dart';
import 'package:crea_chess/router/app/hub/game/side.dart';
import 'package:crea_chess/router/app/user/user_page.dart';
import 'package:crea_chess/router/app/user/widget/user_photo.dart';
import 'package:crea_chess/router/shared/settings/settings_page.dart';
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

    final currentUser = context.watch<UserCubit>().state;
    final editable = currentUser.id == userId;

    Widget buildWithUser(UserModel? user) {
        final username = Text(user?.username ?? '');
        final won = side != null && side == winner;

        return ListTile(
          leading: UserPhoto(
            photo: user?.photo,
            isConnected: user?.isConnected,
          onTap: user == null ? null : () => UserRoute.pushId(userId: user.id),
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
        trailing: kDebugMode && !editable
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
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(LichessIcons.flag),
                    onPressed: () => showYesNoDialog(
                      pageContext: context,
                      title: 'Voulez-vous abandonner la partie en cours ?',
                      onYes: () => liveGameCRUD.resign(
                        game: game,
                        userId: currentUser.id,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () => BoardSettingsCard.showAsModal(context),
                  ),
                ],
              ),
        );

    }

    if (editable) return buildWithUser(currentUser);

    return StreamBuilder<UserModel?>(
      stream: userCRUD.stream(documentId: userId),
      builder: (context, snapshot) => buildWithUser(snapshot.data),
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
