import 'package:crea_chess/package/game/time_control.dart';
import 'package:flutter/material.dart';

enum Speed {
  bullet(Icons.bolt, 0),
  blitz(Icons.local_fire_department, 1),
  rapid(Icons.cruelty_free, 2),
  classical(Icons.sentiment_satisfied, 3);

  const Speed(this.icon, this._index);

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

  final IconData icon;
  final int _index;

  static Speed? fromString(String string) {
    return Speed.values.where((s) => s.name == string).firstOrNull;
  }

  int compareTo(Speed b) => _index.compareTo(b._index);
}
