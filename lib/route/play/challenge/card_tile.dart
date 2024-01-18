import 'package:crea_chess/package/atomic_design/border.dart';
import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:flutter/material.dart';

class CardTile extends StatelessWidget {
  const CardTile({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: CCBorderRadiusCircular.medium,
        side: BorderSide(color: CCColor.cardBorder(context)),
      ),
      child: InkWell(
        onTap: () {},
        child: child,
      ),
    );
  }
}
