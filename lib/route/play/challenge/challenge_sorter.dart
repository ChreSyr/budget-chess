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
    return BlocBuilder<ChallengeSorterCubit, ChallengeSorterState>(
      builder: (context, sorter) {
        return Row(
          children: [
            DropdownSelector<Speed?>(
              values: const <Speed?>[null, ...Speed.values],
              onSelected: context.read<ChallengeSorterCubit>().setSpeed,
              initialValue: sorter.speed,
              valueBuilder: (speed) {
                return speed?.name.sentenceCase ?? 'All speed'; // TODO : l10n
              },
            ),
            CCGap.medium,
            DropdownSelector<bool>(
              values: const [true, false],
              onSelected: context.read<ChallengeSorterCubit>().setBudgetAsc,
              initialValue: sorter.budgetAsc,
              valueBuilder: (val) {
                return val
                    ? 'Budget par ordre croissant'
                    : 'Budget par ordre décroissant';
                // TODO : l10n
              },
            ),
          ],
        );
      },
    );
  }
}
