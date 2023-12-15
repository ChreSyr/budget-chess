import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget SimpleIconButtonBadge({required Widget child}) {
  return badges.Badge(
    position: badges.BadgePosition.topEnd(top: 3, end: 3),
    child: child,
  );
}
