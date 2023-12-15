import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:flutter/material.dart';

class FilledCircleButton {
  static const defaultSize = CCSize.xxlarge;

  static SizedBox icon({
    required IconData? icon,
    required void Function()? onPressed,
    double size = defaultSize,
  }) {
    return SizedBox(
      height: size,
      width: size,
      child: FilledButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: Icon(icon, size: size / 1.7),
      ),
    );
  }

  static SizedBox text({
    required String text,
    required void Function()? onPressed,
    double size = defaultSize,
  }) {
    return SizedBox(
      height: size,
      width: size,
      child: FilledButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: Text(text, style: TextStyle(fontSize: size / 2)),
      ),
    );
  }
}
