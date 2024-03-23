import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:flutter/material.dart';

class CompactIconButton extends StatelessWidget {
  /// An icon button without the default margin
  const CompactIconButton({
    required this.onPressed,
    required this.icon,
    super.key,
  });

  final VoidCallback onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: CCSize.large,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        style: IconButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
