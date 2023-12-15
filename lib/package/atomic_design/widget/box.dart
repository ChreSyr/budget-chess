import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:flutter/material.dart';

class CCSmallBox extends StatelessWidget {
  const CCSmallBox({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CCWidgetSize.small,
      width: CCWidgetSize.small,
      child: child,
    );
  }
}
