import 'package:collection/collection.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/widget/chip/menu_chip.dart';
import 'package:crea_chess/package/atomic_design/widget/chip/select_chip.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/game/speed.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/package/lichess/rule.dart';
import 'package:dartchess_webok/dartchess_webok.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';

class ChallengeSorter extends StatelessWidget {
  const ChallengeSorter({super.key});

  @override
  Widget build(BuildContext context) {
    final filterCubit = context.read<ChallengeFilterCubit>();
    return BlocConsumer<AuthenticationCubit, User?>(
      listener: (context, auth) {
        if (auth == null) filterCubit.selectFilter(null);
      },
      builder: (context, auth) =>
          BlocBuilder<ChallengeFilterCubit, ChallengeFilterModel?>(
        builder: (context, filter) {
          final addRuleFilter = filter?.rules.isEmpty ?? true
              ? MenuItemButton(
                  onPressed: () {
                    if (filter != null) {
                      filterCubit.toggleRule(Rule.chess);
                    } else if (auth == null) {
                      filterCubit.selectFilter(
                        ChallengeFilterModel(
                          rules: {Rule.chess},
                          speeds: {},
                        ),
                      );
                    } else {
                      filterCubit.createFilter(
                        ChallengeFilterModel(
                          userId: auth.uid,
                          id: context
                              .read<ChallengeFiltersCubit>()
                              .nextFilterId,
                          rules: {Rule.chess},
                          speeds: {},
                        ),
                      );
                    }
                  },
                  child: const Text('Filtrer par règle'),
                )
              : null;
          final addSpeedFilter = filter?.speeds.isEmpty ?? true
              ? MenuItemButton(
                  onPressed: () {
                    if (filter != null) {
                      filterCubit.toggleSpeed(Speed.blitz);
                    } else if (auth == null) {
                      filterCubit.selectFilter(
                        ChallengeFilterModel(
                          rules: {},
                          speeds: {Speed.blitz},
                        ),
                      );
                    } else {
                      filterCubit.createFilter(
                        ChallengeFilterModel(
                          userId: auth.uid,
                          id: context
                              .read<ChallengeFiltersCubit>()
                              .nextFilterId,
                          rules: {},
                          speeds: {Speed.blitz},
                        ),
                      );
                    }
                  },
                  child: const Text('Filtrer par cadence'),
                )
              : null;
          final options = [addRuleFilter, addSpeedFilter].whereType<Widget>();
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: Row(
              children: [
                CCGap.small,
                const FilterSelector(),
                if (filter != null) ...[
                  if (addRuleFilter == null) ...[
                    CCGap.small,
                    SelectChip<Rule>.multipleChoices(
                      values: Rule.values,
                      onSelected: filterCubit.toggleRule,
                      selectedValues: filter.rules.toList(),
                      valueBuilder: (val) {
                        return Row(
                          children: [
                            val.icon,
                            CCPadding.allXxsmall(
                              child: Text(val.explain(context.l10n)),
                            ),
                          ],
                        );
                      },
                      previewBuilder: getRulesPreview,
                      showArrow: false,
                    ),
                  ],
                  if (addSpeedFilter == null) ...[
                    CCGap.small,
                    SelectChip<Speed>.multipleChoices(
                      values: Speed.values,
                      onSelected: filterCubit.toggleSpeed,
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
                if (options.isNotEmpty) ...[
                  CCGap.small,
                  MenuChip(
                    label: const Icon(Icons.add),
                    menuChildren: options.toList(),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget getRulesPreview(Iterable<Rule> val) => Row(
      // LATER : sort rules with compareTo
      children: val.map((e) => e.icon).toList(),
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
            return SelectChip<ChallengeFilterModel?>.uniqueChoice(
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
