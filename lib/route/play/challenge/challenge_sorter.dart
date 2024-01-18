import 'package:crea_chess/package/atomic_design/widget/dropdown_selector.dart';
import 'package:crea_chess/package/game/speed.dart';
import 'package:crea_chess/route/play/challenge/challenge_sorter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChallengeSorter extends StatelessWidget {
  const ChallengeSorter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChallengeSorterCubit, Speed?>(
      builder: (context, speed) {
        return DropdownSelector(
          values: const <Speed?>[null, ...Speed.values],
          onSelected: context.read<ChallengeSorterCubit>().setSpeed,
          initialValue: speed,
          valueBuilder: (speed) {
            return speed?.name ?? 'Speed'; // TODO : l10n
          },
        );
      },
    );
  }
}
