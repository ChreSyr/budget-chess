import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/atomic_design/border.dart';
import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/package/unichess/src/models.dart';
import 'package:crea_chess/router/app/user/user_page.dart';
import 'package:crea_chess/router/app/user/widget/user_sections.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HistoryCubit extends Cubit<Iterable<GameModel>> {
  HistoryCubit({required this.userId}) : super([]) {
    _gamesStream = liveGameCRUD
        .streamFiltered(
          filter: (collection) => collection
              .where(
                Filter.or(
                  Filter('whiteId', isEqualTo: userId),
                  Filter('blackId', isEqualTo: userId),
                ),
              )
              .orderBy('challenge.acceptedAt', descending: true)
              .limit(50),
        )
        .listen(emit);
  }

  final String userId;
  StreamSubscription<Iterable<GameModel>>? _gamesStream;

  @override
  Future<void> close() {
    _gamesStream?.cancel();
    return super.close();
  }
}

class UserSectionGames extends UserSection {
  const UserSectionGames({required this.user, super.key});

  final UserModel user;

  @override
  String getTitle(AppLocalizations l10n) {
    return 'Games'; // TODO : l10n
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocProvider(
        create: (context) => HistoryCubit(userId: user.id),
        child: BlocBuilder<HistoryCubit, Iterable<GameModel>>(
          builder: (context, games) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                border: const TableBorder(
                  horizontalInside: BorderSide(
                    width: .1,
                    color: Colors.grey,
                  ),
                ),
                headingRowHeight: CCWidgetSize.xxxsmall,
                dataRowMinHeight: CCWidgetSize.xxsmall,
                dataRowMaxHeight: CCWidgetSize.xxsmall,
                columnSpacing: CCSize.large,
                horizontalMargin: CCSize.small,
                columns: const [
                  DataColumn(label: Text('Résultat'), numeric: true),
                  DataColumn(label: Text('Joueurs')),
                  DataColumn(
                    label: Padding(
                      padding: EdgeInsets.all(CCSize.small),
                      child: Icon(Icons.attach_money),
                    ),
                  ),
                  DataColumn(label: Center(child: Text('Date'))),
                ],
                rows: games.map(
                  (game) {
                    final userSide = game.sideOf(user.id);
                    return DataRow(
                      cells: [
                        DataCell(_ResultCell(game: game, userSide: userSide)),
                        DataCell(_PlayersCell(game: game, user: user)),
                        DataCell(
                          Center(
                            child: CCPadding.allSmall(
                              child: Text(game.challenge.budget.toString()),
                            ),
                          ),
                        ),
                        if (game.challenge.acceptedAt == null)
                          const DataCell(CCGap.zero)
                        else
                          DataCell(
                            CCPadding.allSmall(
                              child: Text(
                                '${DateFormat(DateFormat.DAY, 'fr').format(game.challenge.acceptedAt!).padLeft(2, '0')} ${DateFormat(DateFormat.ABBR_MONTH + '\n' + DateFormat.YEAR, 'fr').format(game.challenge.acceptedAt!)}',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PlayersCell extends StatelessWidget {
  const _PlayersCell({required this.game, required this.user});

  final GameModel game;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final userIsWhite = game.sideOf(user.id) == Side.white;
    final opponentId = game.otherPlayer(user.id);
    if (opponentId == null) return CCGap.zero;

    return SizedBox(
      height: CCWidgetSize.xxsmall,
      width: CCWidgetSize.large,
      child: UserStreamBuilder(
        userId: opponentId,
        indicateLoad: false,
        builder: (context, opponent) {
          final white = userIsWhite ? user : opponent;
          final black = userIsWhite ? opponent : user;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox.square(
                    dimension: CCSize.small,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: CCBorderRadiusCircular.xsmall,
                        border: Border.all(
                          color: context.colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ),
                  CCGap.xsmall,
                  Text(white.username),
                ],
              ),
              Row(
                children: [
                  SizedBox.square(
                    dimension: CCSize.small,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: CCBorderRadiusCircular.xsmall,
                        border: Border.all(
                          color: context.colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ),
                  CCGap.xsmall,
                  Text(black.username),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ResultCell extends StatelessWidget {
  const _ResultCell({
    required this.game,
    required this.userSide,
  });

  final GameModel game;
  final Side? userSide;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (userSide == null) {
          return CCGap.zero;
        } else if (game.winner == null) {
          if (game.finished) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: CCBorderRadiusCircular.xsmall,
              ),
              child: Icon(
                CupertinoIcons.equal,
                color: context.colorScheme.background,
              ),
            );
          } else {
            return Container(
              decoration: const BoxDecoration(
                borderRadius: CCBorderRadiusCircular.xsmall,
              ),
              child: const Icon(
                Icons.more_horiz,
                color: Colors.grey,
              ),
            );
          }
        } else if (game.winner == userSide) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: CCBorderRadiusCircular.xsmall,
            ),
            child: Icon(
              Icons.add,
              color: context.colorScheme.background,
            ),
          );
        } else {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: CCBorderRadiusCircular.xsmall,
            ),
            child: Icon(
              Icons.remove,
              color: context.colorScheme.background,
            ),
          );
        }
      },
    );
  }
}
