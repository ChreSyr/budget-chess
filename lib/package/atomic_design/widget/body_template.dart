import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:flutter/material.dart';

class BodyTemplate extends StatelessWidget {
  const BodyTemplate({
    required this.children,
    super.key,
  });

  final Iterable<Widget> children;

  @override
  Widget build(BuildContext context) {
    return CCPadding.allLarge(
      child: SizedBox(
        width: CCWidgetSize.large4,
        child: ListView(
          shrinkWrap: true,
          children: [
            // children
            ...children,
            CCGap.medium,
          ],
        ),
      ),
    );
  }
}
