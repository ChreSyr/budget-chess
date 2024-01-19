import 'package:collection/collection.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/widget/dropdown_selector.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/game/speed.dart';
import 'package:crea_chess/route/play/challenge/challenge_filter_cubit.dart';
import 'package:crea_chess/route/play/challenge/challenge_filter_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';

class ChallengeSorter extends StatelessWidget {
  const ChallengeSorter({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: BlocBuilder<ChallengeFilterCubit, ChallengeFilterModel>(
        builder: (context, filter) {
          return Column(
            children: [
              Row(
                children: [
                  CCGap.small,
                  // DropdownSelector<String>(
                  //   values: const <Speed?>[null, ...Speed.values],
                  //   onSelected: context.read<ChallengeFilterCubit>().setSpeed,
                  //   initialValue: filter.speed,
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
                  DropdownSelector<Speed>.multipleChoices(
                    values: Speed.values,
                    onSelected:
                        context.read<ChallengeFilterCubit>().toggleSpeed,
                    initiallySelectedValues: filter.speed.toList(),
                    valueBuilder: (speed) {
                      return Row(
                        children: [
                          Icon(speed.icon),
                          CCPadding.allXxsmall(
                            child: Text(speed.name.sentenceCase),
                          ),
                        ],
                      );
                    },
                    previewBuilder: (e) => Row(
                      children: e
                          .sorted((a, b) => a.compareTo(b))
                          .map((s) => Icon(s.icon))
                          .toList(),
                    ),
                  ),
                  CCGap.small,
                  DropdownSelector<bool>.uniqueChoice(
                    values: const [true, false],
                    onSelected:
                        context.read<ChallengeFilterCubit>().setBudgetAsc,
                    initiallySelectedValue: filter.budgetAsc,
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
