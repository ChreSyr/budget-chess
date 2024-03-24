import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/elevation.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:flutter/material.dart';

class FeedCard extends StatelessWidget {
  const FeedCard({
    required this.child,
    this.title,
    this.actions = const [],
    this.onTap,
    this.color,
    super.key,
  });

  final Widget child;
  final String? title;
  final List<Widget> actions;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? context.colorScheme.onInverseSurface,
      elevation: CCElevation.medium,
      clipBehavior: onTap == null ? null : Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: CCPadding.allMedium(
          child: title == null && actions.isEmpty
              ? child
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            // TODO : l10n
                            title ?? '',
                            style: context.textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        CCGap.small,
                        ...actions,
                      ],
                    ),
                    CCGap.medium,
                    child,
                  ],
                ),
        ),
      ),
    );
  }
}
