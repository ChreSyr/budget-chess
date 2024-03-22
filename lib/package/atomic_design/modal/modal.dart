import 'package:crea_chess/package/atomic_design/border.dart';
import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Modal {
  static void show({
    required BuildContext context,
    required Iterable<Widget> sections,
    String? title,
    bool isScrollControlled = false,
  }) {
    final content = CCPadding.horizontalMedium(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!kIsWeb) ...[
            CCGap.small,
            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.onSurfaceVariant,
                borderRadius: CCBorderRadiusCircular.small,
              ),
              width: CCWidgetSize.xxxsmall,
              height: 6,
            ),
          ],
          CCGap.large,
          if (title != null) ...[
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            CCGap.xlarge,
          ],
          ...sections,
        ],
      ),
    );

    if (kIsWeb) {
      showDialog<SimpleDialog>(
        context: context,
        builder: (_) => SimpleDialog(
          children: [
            SizedBox(
              width: CCWidgetSize.large4,
              child: content,
            ),
          ],
        ),
      );
    } else {
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: isScrollControlled,
        builder: (_) => content,
      );
    }
  }
}
