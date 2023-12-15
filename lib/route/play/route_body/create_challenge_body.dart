import 'package:crea_chess/package/atomic_design/modal/modal_select.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/game/board_size.dart';
import 'package:crea_chess/package/game/speed.dart';
import 'package:crea_chess/package/game/time_control.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/route/play/create_challenge/create_challenge_cubit.dart';
import 'package:crea_chess/route/play/create_challenge/create_challenge_form.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateChallengeBody extends RouteBody {
  const CreateChallengeBody({super.key});

  @override
  String getTitle(AppLocalizations l10n) {
    return 'Create challenge'; // TODO : l10n
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CreateChallengeCubit(),
      child: const _CreateChallengeBody(),
    );
  }
}

class _CreateChallengeBody extends StatelessWidget {
  const _CreateChallengeBody();

  @override
  Widget build(BuildContext context) {
    final createChallengeCubit = context.read<CreateChallengeCubit>();
    return BlocBuilder<CreateChallengeCubit, CreateChallengeForm>(
      builder: (context, form) {
        return SizedBox(
          width: CCWidgetSize.large4,
          child: ListView(
            shrinkWrap: true,
            children: [
              _TitledRow(
                title: context.l10n.timeControl,
                child: OutlinedButton.icon(
                  onPressed: () => ModalSelect.show(
                    context: context,
                    title: 'Taille du plateau', // TODO: l10n
                    choices: [
                      ModalSelectRowData(
                        title: 'Bullet', // TODO: l10n ?
                        titleIcon: Icon(Speed.bullet.icon),
                        choices: const [
                          TimeControl(0, 1),
                          TimeControl(60, 0),
                          TimeControl(60, 1),
                          TimeControl(120, 1),
                        ],
                      ),
                      ModalSelectRowData(
                        title: 'Blitz',
                        titleIcon: Icon(Speed.blitz.icon),
                        choices: const [
                          TimeControl(180, 0),
                          TimeControl(180, 2),
                          TimeControl(300, 0),
                          TimeControl(300, 3),
                        ],
                      ),
                      ModalSelectRowData(
                        title: 'Rapid',
                        titleIcon: Icon(Speed.rapid.icon),
                        choices: const [
                          TimeControl(600, 0),
                          TimeControl(600, 5),
                          TimeControl(900, 0),
                          TimeControl(900, 10),
                        ],
                      ),
                      ModalSelectRowData(
                        title: 'Classical',
                        titleIcon: Icon(Speed.classical.icon),
                        choices: const [
                          TimeControl(1500, 0),
                          TimeControl(1800, 0),
                          TimeControl(1800, 20),
                          TimeControl(3600, 0),
                        ],
                      ),
                    ],
                    selected: form.timeControl.value,
                    onSelected: (TimeControl choice) {
                      createChallengeCubit.setTimeControl(choice);
                      context.pop();
                    },
                  ),
                  icon: Icon(form.timeControl.value.speed.icon),
                  label: Text(form.timeControl.value.toString()),
                ),
              ),
              CCGap.large,
              _TitledRow(
                title: 'Taille du plateau',
                child: OutlinedButton(
                  onPressed: () => ModalSelect.show(
                    context: context,
                    title: 'Taille du plateau',
                    choices: [
                      ModalSelectRowData(
                        title: 'Petit',
                        choices: const [
                          BoardSize(5, 5),
                          BoardSize(6, 6),
                          BoardSize(7, 7),
                        ],
                      ),
                      ModalSelectRowData(
                        title: 'Grand',
                        choices: const [
                          BoardSize(8, 8),
                          BoardSize(9, 9),
                          BoardSize(10, 10),
                        ],
                      ),
                    ],
                    selected: form.boardSize.value,
                    onSelected: (BoardSize choice) {
                      createChallengeCubit.setBoardSize(choice);
                      context.pop();
                    },
                  ),
                  child: Text(form.boardSize.value.toString()),
                ),
              ),
              CCGap.large,
              _TitledRow(
                title: 'Budget',
                child: OutlinedButton(
                  onPressed: () => ModalSelect.show(
                    context: context,
                    title: 'Budget',
                    choices: [
                      ModalSelectRowData(
                        title: 'Maigre',
                        choices: const [18, 21, 24, 27, 30],
                      ),
                      ModalSelectRowData(
                        title: 'Normal',
                        choices: const [33, 36, 39, 42, 45],
                      ),
                    ],
                    selected: form.budget.value,
                    onSelected: (int choice) {
                      createChallengeCubit.setBudget(choice);
                      context.pop();
                    },
                  ),
                  child: Text(form.budget.value.toString()),
                ),
              ),
              CCGap.large,
              FilledButton(
                onPressed: () {}, // TODO : challengeCRUD
                child: const Text('Create challenge'), // TODO : l10n
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TitledRow extends StatelessWidget {
  const _TitledRow({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$title :'),
        const Expanded(
          child: CCGap.medium,
        ),
        SizedBox(
          width: CCWidgetSize.large,
          child: child,
        ),
      ],
    );
  }
}
