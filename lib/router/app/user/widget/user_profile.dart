import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/divider.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/router/app/user/widget/user_header.dart';
import 'package:crea_chess/router/app/user/widget/user_sections.dart';
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
    this.userActions,
    super.key,
  });

  final UserHeader header;
  final Widget? userActions;
  final List<UserSection> tabSections;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _TabIndexCubit(),
      child: Builder(
        builder: (context) {
          return SizedBox(
            width: CCWidgetSize.large4,
            child: Column(
              children: [
                header,
                if (userActions != null) userActions!,
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
                  Flexible(
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
          );
        },
      ),
    );
  }
}
