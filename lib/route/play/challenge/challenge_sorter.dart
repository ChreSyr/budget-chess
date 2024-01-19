import 'package:collection/collection.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/widget/dropdown_selector.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/game/speed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';

class ChallengeSorter extends StatelessWidget {
  const ChallengeSorter({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: BlocConsumer<ChallengeFilterCubit, ChallengeFilterModel?>(
        listener: (context, filter) {
          if (filter == null) {
            final allFilters = context.read<ChallengeFiltersCubit>().state;
            if (allFilters.isEmpty) return;
            context.read<ChallengeFilterCubit>().selectFilter(allFilters.first);
          }
        },
        builder: (context, filter) {
          return Row(
            children: [
              CCGap.small,
              const FilterSelector(),
              CCGap.small,
              DropdownSelector<bool>.uniqueChoice(
                values: const [true, false],
                onSelected: context.read<ChallengeFilterCubit>().setBudgetAsc,
                selectedValue: filter?.budgetAsc,
                valueBuilder: (val) {
                  return Text(
                    val ? 'Par ordre croissant' : 'Par ordre décroissant',
                  );
                  // TODO : l10n
                },
                previewBuilder: (val) {
                  return Transform.flip(
                    flipY: !val,
                    child: const Icon(Icons.filter_list),
                  );
                },
              ),
              CCGap.small,
              DropdownSelector<Speed>.multipleChoices(
                values: Speed.values,
                onSelected: context.read<ChallengeFilterCubit>().toggleSpeed,
                selectedValues: filter?.speed.toList(),
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
            ],
          );
        },
      ),
    );
  }
}

class FilterSelector extends StatelessWidget {
  const FilterSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChallengeFiltersCubit, Iterable<ChallengeFilterModel>>(
      builder: (context, allFilters) {
        return BlocBuilder<ChallengeFilterCubit, ChallengeFilterModel?>(
          builder: (context, filter) {
            return DropdownSelector<ChallengeFilterModel>.uniqueChoice(
              values: allFilters.isEmpty
                  ? [ChallengeFilterModel()]
                  : allFilters.toList(),
              onSelected: context.read<ChallengeFilterCubit>().selectFilter,
              selectedValue: filter,
              valueBuilder: (filter) {
                return Row(
                  children: [
                    Transform.flip(
                      flipY: !filter.budgetAsc,
                      child: const Icon(Icons.filter_list),
                    ),
                    CCGap.medium,
                    ...filter.speed
                        .sorted((a, b) => a.compareTo(b))
                        .map((e) => Icon(e.icon)),
                  ],
                );
              },
              previewBuilder: (filter) {
                return Text(filter.name ?? '0'); // TODO : l10n
              },
            );
          },
        );
      },
    );
  }
}
