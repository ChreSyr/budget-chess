import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/divider.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_header.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_sections.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _TabIndexCubit extends Cubit<int> {
  _TabIndexCubit() : super(0);

  void set(int index) => emit(index);
}

class UserProfile extends StatelessWidget {
  const UserProfile({
    required this.header,
    required this.tabSections,
    this.relationshipWidget,
    super.key,
  });

  final UserHeader header;
  final Widget? relationshipWidget;
  final List<UserSection> tabSections;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _TabIndexCubit(),
      child: Builder(
        builder: (context) {
          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: CCWidgetSize.large4,
              child: Column(
                children: [
                  header,
                  if (relationshipWidget != null) relationshipWidget!,
                  if (tabSections.isNotEmpty) ...[
                    CCGap.medium,
                    DefaultTabController(
                      length: tabSections.length,
                      child: TabBar(
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        tabs: tabSections
                            .map((e) => Tab(text: e.getTitle(context.l10n)))
                            .toList(),
                        onTap: context.read<_TabIndexCubit>().set,
                      ),
                    ),
                    CCDivider.xthin,
                    CCPadding.allMedium(
                      child: BlocBuilder<_TabIndexCubit, int>(
                        builder: (context, index) {
                          return IndexedStack(
                            alignment: Alignment.topCenter,
                            index: index,
                            children: tabSections.toList(),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
