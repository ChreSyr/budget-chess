import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/feed_card.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:flutter/widgets.dart';

class UserActionButton extends StatelessWidget {
  const UserActionButton({
    required this.icon,
    required this.text,
    this.onTap,
    this.color,
    super.key,
  });

  final Widget icon;
  final String text;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: CCWidgetSize.large,
      child: FeedCard(
        onTap: onTap,
        color: color,
        child: Column(
          children: [
            icon,
            CCGap.small,
            Text(
              text,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
