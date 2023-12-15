import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:flutter/material.dart';

class BodyTemplate extends StatelessWidget {
  const BodyTemplate({
    required this.loading,
    required this.emoji,
    required this.title,
    required this.children,
    super.key,
  });

  final bool loading;
  final String emoji;
  final String title;
  final Iterable<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: CCWidgetSize.large4,
      child: ListView(
        shrinkWrap: true,
        children: [
          // loading
          if (loading) const LinearProgressIndicator(),

          // emoji
          Text(
            emoji,
            style: const TextStyle(fontSize: CCWidgetSize.xxsmall),
            textAlign: TextAlign.center,
          ),

          // title
          Text(title, textAlign: TextAlign.center),
          CCGap.xlarge,

          // children
          ...children,
          CCGap.medium,
        ],
      ),
    );
  }
}
