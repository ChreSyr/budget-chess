import 'package:crea_chess/package/game/time_control.dart';
import 'package:flutter/material.dart';

enum Speed {
  bullet(Icons.bolt),
  blitz(Icons.local_fire_department),
  rapid(Icons.cruelty_free),
  classical(Icons.sentiment_satisfied);

  const Speed(this.icon);

  factory Speed.fromTimeIncrement(TimeControl t) {
    switch (t.estimatedDuration.inSeconds) {
      case >= 1 && <= 179:
        return Speed.bullet;
      case >= 180 && <= 479:
        return Speed.blitz;
      case >= 480 && <= 1499:
        return Speed.rapid;
      default:
        return Speed.classical;
    }
  }

  static Speed? fromString(String string) {
    return Speed.values.where((s) => s.name == string).firstOrNull;
  }

  final IconData icon;
}
