import 'package:collection/collection.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/widget/dropdown_selector.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/game/speed.dart';
import 'package:dartchess_webok/dartchess_webok.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';

class ChallengeSorter extends StatelessWidget {
  const ChallengeSorter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, User?>(
      listener: (context, auth) {
        if (auth == null) {
          context.read<ChallengeFilterCubit>().selectFilter(null);
        }
      },
      child: BlocBuilder<ChallengeFilterCubit, ChallengeFilterModel?>(
        builder: (context, filter) {
          return Row(
            children: [
              CCGap.small,
              const FilterSelector(),
              if (filter != null) ...[
                CCGap.small,
                DropdownSelector<Rules>.multipleChoices(
                  values: Rules.values,
                  onSelected: context.read<ChallengeFilterCubit>().toggleRule,
                  selectedValues: filter.rules.toList(),
                  valueBuilder: (val) {
                    switch (val) {
                      case Rules.chess:
                        return Row(
                          children: [
                            const Icon(Icons.attach_money),
                            // TODO : Rules.explain(l10n)
                            CCPadding.allXxsmall(
                              child: const Text('Budget Chess'),
                            ),
                          ],
                        );
                    }
                  },
                  previewBuilder: getRulesPreview,
                  showArrow: false,
                ),
                CCGap.small,
                DropdownSelector<Speed>.multipleChoices(
                  values: Speed.values,
                  onSelected: context.read<ChallengeFilterCubit>().toggleSpeed,
                  selectedValues: filter.speeds.toList(),
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
                  previewBuilder: getSpeedsPreview,
                  showArrow: false,
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

Widget getRulesPreview(Iterable<Rules> val) => Row(
      // LATER : sort rules with compareTo
      children: val.map((e) {
        switch (e) {
          case Rules.chess:
            return const Icon(Icons.attach_money);
        }
      }).toList(),
    );

Widget getSpeedsPreview(Iterable<Speed> e) => Row(
      children:
          e.sorted((a, b) => a.compareTo(b)).map((s) => Icon(s.icon)).toList(),
    );

class FilterSelector extends StatelessWidget {
  const FilterSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChallengeFiltersCubit, Iterable<ChallengeFilterModel>>(
      builder: (context, allFilters) {
        final authId = context.read<AuthenticationCubit>().state?.uid;
        if (authId != null) {
          if (allFilters.isEmpty) {
            challengeFilterCRUD.create(
              parentDocumentId: authId,
              documentId: '1',
              data: ChallengeFilterModel.default1,
            );
          }
          if (allFilters.length < 2) {
            challengeFilterCRUD.create(
              parentDocumentId: authId,
              documentId: '2',
              data: ChallengeFilterModel.default2,
            );
          }
          if (allFilters.length < 3) {
            challengeFilterCRUD.create(
              parentDocumentId: authId,
              documentId: '3',
              data: ChallengeFilterModel.default3,
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
                    getRulesPreview(filter.rules),
                    CCGap.medium,
                    getSpeedsPreview(filter.speeds),
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
