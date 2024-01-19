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
    return BlocBuilder<ChallengeFilterCubit, ChallengeFilterModel?>(
      builder: (context, filter) {
        return Row(
          children: [
            CCGap.small,
            const FilterSelector(),
            if (filter != null) ...[
              CCGap.small,
              DropdownSelector<bool>.uniqueChoice(
                values: const [true, false],
                onSelected: context.read<ChallengeFilterCubit>().setBudgetAsc,
                selectedValue: filter.budgetAsc,
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
                showArrow: false,
              ),
              CCGap.small,
              DropdownSelector<Speed>.multipleChoices(
                values: Speed.values,
                onSelected: context.read<ChallengeFilterCubit>().toggleSpeed,
                selectedValues: filter.speed.toList(),
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
                showArrow: false,
              ),
            ]
          ],
        );
      },
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
        final authId = context.read<AuthenticationCubit>().state?.uid;
        if (authId == null) {
          allFilters = [ChallengeFilterModel()];
        } else {
          if (allFilters.isEmpty) {
            challengeFilterCRUD.create(
              parentDocumentId: authId,
              documentId: '1',
              data: ChallengeFilterModel(speed: {Speed.bullet, Speed.blitz}),
            );
          }
          if (allFilters.length < 2) {
            challengeFilterCRUD.create(
              parentDocumentId: authId,
              documentId: '2',
              data: ChallengeFilterModel(speed: {Speed.blitz, Speed.rapid}),
            );
          }
          if (allFilters.length < 3) {
            challengeFilterCRUD.create(
              parentDocumentId: authId,
              documentId: '3',
              data: ChallengeFilterModel(speed: {Speed.classical}),
            );
          }
        }
        return BlocBuilder<ChallengeFilterCubit, ChallengeFilterModel?>(
          builder: (context, filter) {
            return DropdownSelector<ChallengeFilterModel?>.uniqueChoice(
              values: [null, ...allFilters],
              onSelected: context.read<ChallengeFilterCubit>().selectFilter,
              selectedValue: filter,
              valueBuilder: (filter) {
                if (filter == null) return const Icon(Icons.filter_alt_off);
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
              previewBuilder: (filter) => Icon(
                filter == null ? Icons.filter_alt_off : Icons.filter_alt,
              ),
            );
          },
        );
      },
    );
  }
}
