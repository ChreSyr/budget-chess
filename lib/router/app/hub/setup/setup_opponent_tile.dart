import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/router/app/user/widget/user_photo.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/router/app/user/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetupOpponentTile extends StatelessWidget {
  const SetupOpponentTile({required this.game, super.key});

  final GameModel game;

  @override
  Widget build(BuildContext context) {
    final authUid = context.watch<UserCubit>().state.id;
    final side = game.sideOf(authUid);
    if (side == null) return CCGap.zero;

    final youValidatedSetup = game.sideHasSetup(side);

    final opponentId = game.playerId(side.opposite);
    final opponentValidatedSetup = game.sideHasSetup(side.opposite);

    return StreamBuilder<UserModel?>(
      stream: userCRUD.stream(documentId: opponentId),
      builder: (context, snapshot) {
        final opponent = snapshot.data;

        return ListTile(
          leading: UserPhoto(
            photo: opponent?.photo,
            onTap: opponent == null
                ? null
                : () => UserRoute.pushId(userId: opponent.id),
            isConnected: opponent?.isConnected,
          ),
          title: opponentValidatedSetup
              // TODO : l10n
              ? Text('${opponent?.username ?? 'Opponent'} is waiting for you !')
              : youValidatedSetup
                  ? Text('Waiting for ${opponent?.username ?? 'opponent'}...')
                  : Text(
                      // ignore: lines_longer_than_80_chars
                      '${opponent?.username ?? 'Opponent'} is choosing a setup...',
                    ),
        );
      },
    );
  }
}
