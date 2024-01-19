import 'package:crea_chess/package/atomic_design/widget/dropdown_selector.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/game/speed.dart';
import 'package:crea_chess/route/play/challenge/challenge_sorter_cubit.dart';
import 'package:crea_chess/route/play/challenge/challenge_sorter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';

class ChallengeSorter extends StatelessWidget {
  const ChallengeSorter({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: BlocBuilder<ChallengeSorterCubit, ChallengeSorterState>(
        builder: (context, sorter) {
          return Column(
            children: [
              Row(
                children: [
                  CCGap.small,
                  // DropdownSelector<String>(
                  //   values: const <Speed?>[null, ...Speed.values],
                  //   onSelected: context.read<ChallengeSorterCubit>().setSpeed,
                  //   initialValue: sorter.speed,
                  //   valueBuilder: (speed) {
                  //     return speed?.name.sentenceCase ??
                  //         'All speed'; // TODO : l10n
                  //   },
                  // ),
                  Text(
                    'Parties rapides', // TODO : default-1
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  CCGap.small,
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.expand_more),
                  ),
                ],
              ),
              Row(
                children: [
                  CCGap.small,
                  DropdownSelector<Speed?>.multipleChoices(
                    values: const <Speed?>[null, ...Speed.values],
                    onSelected: context.read<ChallengeSorterCubit>().setSpeed,
                    initiallySelectedValues: [sorter.speed],
                    valueBuilder: (speed) {
                      return Icon(speed?.icon);
                    },
                  ),
                  CCGap.small,
                  DropdownSelector<bool>.uniqueChoice(
                    values: const [true, false],
                    onSelected:
                        context.read<ChallengeSorterCubit>().setBudgetAsc,
                    initiallySelectedValue: sorter.budgetAsc,
                    valueBuilder: (val) {
                      return Text(val
                          ? 'Budget par ordre croissant'
                            : 'Budget par ordre décroissant',
                      );
                      // TODO : l10n
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
