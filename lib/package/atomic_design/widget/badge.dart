// ignore_for_file: non_constant_identifier_names

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

Widget SimpleBadge({required Widget child}) {
  return badges.Badge(
    position: badges.BadgePosition.topEnd(top: 3, end: 3),
    child: child,
  );
}

Widget CountBadge({
  required int count,
  required Widget child,
  Offset offset = const Offset(-20, -20),
}) {
  return badges.Badge(
    badgeContent: Text(
      count.toString(),
      style: const TextStyle(color: Colors.white),
    ),
    position: badges.BadgePosition.topEnd(top: offset.dy, end: offset.dx),
    badgeAnimation: const badges.BadgeAnimation.fade(toAnimate: false),
    showBadge: count > 0,
    child: child,
  );
}
