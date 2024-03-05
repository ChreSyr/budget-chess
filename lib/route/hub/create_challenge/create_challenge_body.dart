import 'package:crea_chess/package/atomic_design/modal/modal_select.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_cubit.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/package/lichess/rule.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:crea_chess/route/hub/create_challenge/create_challenge_cubit.dart';
import 'package:crea_chess/route/hub/create_challenge/create_challenge_form.dart';
import 'package:crea_chess/route/hub/create_challenge/create_challenge_status.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateChallengeBody extends RouteBody {
  const CreateChallengeBody({super.key});

  @override
  String getTitle(AppLocalizations l10n) => l10n.challengeCreate;

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
    final authId = context.read<UserCubit>().state.id;

    Widget ruleBuilder(Rule e) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            e.icon,
            CCGap.small,
            Text(
              e.explain(context.l10n),
              style: CCTextStyle.bold,
            ),
          ],
        );

    return Center(
      child: CCPadding.horizontalXxlarge(
        child: SizedBox(
          width: CCWidgetSize.large4,
          child: BlocConsumer<CreateChallengeCubit, CreateChallengeForm>(
            listener: (context, state) {
              switch (state.status) {
                case CreateChallengeStatus.editError:
                case CreateChallengeStatus.requestError:
                  createChallengeCubit.clearStatus();
                  snackBarError(context, context.l10n.errorOccurred);
                case CreateChallengeStatus.requestSuccess:
                  createChallengeCubit.clearStatus();
                  context.pop();
                case _:
              }
            },
            builder: (context, form) {
              return ListView(
                shrinkWrap: true,
                children: [
                  _TitledRow(
                    title: 'Rules', // TODO : l10n
                    child: OutlinedButton(
                      onPressed: null,
                      // onPressed: () => ModalSelect.show(
                      //   context: context,
                      //   title: context.l10n.boardSize,
                      //   choices: [
                      //     ModalSelectRowData(
                      //       title: 'Standard', // TODO : l10n
                      //       choices: const [
                      //         Rule.chess,
                      //       ],
                      //       choiceBuilder: ruleBuilder,
                      //     ),
                      //     ModalSelectRowData(
                      //       title: 'Variants',
                      //       choices: Rule.values.toList()..remove(Rule.chess),
                      //       choiceBuilder: ruleBuilder,
                      //     ),
                      //   ],
                      //   selected: form.rule.value,
                      //   onSelected: (Rule rule) {
                      //     createChallengeCubit.setRule(rule);
                      //     // Strang bug on web
                      //     Navigator.pop(context);
                      //   },
                      // ),
                      child: ruleBuilder(form.rule.value),
                    ),
                  ),
                  CCGap.large,
                  _TitledRow(
                    title: context.l10n.timeControl,
                    child: OutlinedButton.icon(
                      onPressed: null,
                      // onPressed: () => ModalSelect.show(
                      //   context: context,
                      //   title: context.l10n.boardSize,
                      //   choices: [
                      //     ModalSelectRowData(
                      //       title: 'Bullet',
                      //       titleIcon: Icon(Speed.bullet.icon),
                      //       choices: const [
                      //         TimeControl(0, 1),
                      //         TimeControl(60, 0),
                      //         TimeControl(60, 1),
                      //         TimeControl(120, 1),
                      //       ],
                      //     ),
                      //     ModalSelectRowData(
                      //       title: 'Blitz',
                      //       titleIcon: Icon(Speed.blitz.icon),
                      //       choices: const [
                      //         TimeControl(180, 0),
                      //         TimeControl(180, 2),
                      //         TimeControl(300, 0),
                      //         TimeControl(300, 3),
                      //       ],
                      //     ),
                      //     ModalSelectRowData(
                      //       title: 'Rapid',
                      //       titleIcon: Icon(Speed.rapid.icon),
                      //       choices: const [
                      //         TimeControl(600, 0),
                      //         TimeControl(600, 5),
                      //         TimeControl(900, 0),
                      //         TimeControl(900, 10),
                      //       ],
                      //     ),
                      //     ModalSelectRowData(
                      //       title: 'Classical',
                      //       titleIcon: Icon(Speed.classical.icon),
                      //       choices: const [
                      //         TimeControl(1500, 0),
                      //         TimeControl(1800, 0),
                      //         TimeControl(1800, 20),
                      //         TimeControl(3600, 0),
                      //       ],
                      //     ),
                      //   ],
                      //   selected: form.timeControl.value,
                      //   onSelected: (TimeControl choice) {
                      //     createChallengeCubit.setTimeControl(choice);
                      //     // Strang bug on web
                      //     Navigator.pop(context);
                      //   },
                      // ),
                      icon: Icon(form.timeControl.value.speed.icon),
                      label: Text(form.timeControl.value.toString()),
                    ),
                  ),
                  CCGap.large,
                  _TitledRow(
                    title: 'Taille du plateau', // TODO : l10n
                    child: OutlinedButton(
                      onPressed: null,
                      // () => ModalSelect.show(
                      //   context: context,
                      //   title: 'Taille du plateau', // TODO : l10n
                      //   choices: [
                      //     ModalSelectRowData(
                      //       title: 'Petit', // TODO : l10n
                      //       choices: const [
                      //         BoardSize(5, 5),
                      //         BoardSize(6, 6),
                      //         BoardSize(7, 7),
                      //       ],
                      //     ),
                      //     ModalSelectRowData(
                      //       title: 'Grand', // TODO : l10n
                      //       choices: const [
                      //         BoardSize(8, 8),
                      //         BoardSize(9, 9),
                      //         BoardSize(10, 10),
                      //       ],
                      //     ),
                      //   ],
                      //   selected: form.boardSize.value,
                      //   onSelected: (BoardSize choice) {
                      //     createChallengeCubit.setBoardSize(choice);
                      //     context.pop();
                      //   },
                      // ),
                      child: Text(
                        // ignore: lines_longer_than_80_chars
                        '${form.boardSize.value.ranks} x ${form.boardSize.value.files}',
                      ),
                    ),
                  ),
                  CCGap.large,
                  _TitledRow(
                    title: 'Budget', // TODO : l10n
                    child: OutlinedButton(
                      onPressed: () => ModalSelect.show(
                        context: context,
                        title: 'Budget', // TODO : l10n
                        choices: [
                          ModalSelectRowData(
                            title: 'Maigre', // TODO : l10n
                            choices: const [18, 21, 24, 27, 30],
                          ),
                          ModalSelectRowData(
                            title: 'Normal', // TODO : l10n
                            choices: const [33, 36, 39, 42, 45],
                          ),
                        ],
                        selected: form.budget.value,
                        onSelected: (int choice) {
                          createChallengeCubit.setBudget(choice);
                          // Strang bug on web
                          Navigator.pop(context);
                        },
                      ),
                      child: Text(form.budget.value.toString()),
                    ),
                  ),
                  CCGap.large,
                  FilledButton(
                    onPressed: () =>
                        createChallengeCubit.submit(authorId: authId),
                    child: Text(context.l10n.challengeCreate),
                  ),
                ],
              );
            },
          ),
        ),
      ),
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
          width: CCWidgetSize.xxxlarge,
          child: child,
        ),
      ],
    );
  }
}
