import 'package:crea_chess/package/chessground/time_control.dart';
import 'package:crea_chess/package/lichess/lichess_icons.dart';
import 'package:flutter/material.dart';

enum Speed {
  bullet(LichessIcons.bullet, 0),
  blitz(LichessIcons.blitz, 1),
  rapid(LichessIcons.rapid, 2),
  classical(LichessIcons.classical, 3);

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
