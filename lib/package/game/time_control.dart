import 'package:crea_chess/package/game/speed.dart';
import 'package:flutter/widgets.dart';

/// A pair of time and increment in seconds used as game clock
///
/// If both time and increment are 0, the clock is infinite.
@immutable
class TimeControl {
  const TimeControl(this.time, this.increment)
      : assert(time >= 0 && increment >= 0, '');

  TimeControl.fromJson(Map<String, dynamic> json)
      : time = json['time'] as int,
        increment = json['increment'] as int;

  /// Clock initial time in seconds
  final int time;

  /// Clock increment in seconds
  final int increment;

  static int defaultTime = 180;
  static int defaultIncrement = 2;

  Map<String, dynamic> toJson() => {
        'time': time,
        'increment': increment,
      };

  /// Returns the estimated duration of the game, with increment * 40 added to
  /// the initial time.
  Duration get estimatedDuration => Duration(seconds: time + increment * 40);

  Speed get speed => Speed.fromTimeIncrement(this);

  @override
  String toString() {
    var displayTime = '';
    switch (time) {
      case 0:
        if (increment == 0) {
          displayTime = '∞';
        } else {
          displayTime = '0+$increment';
        }
      case 45:
        displayTime = '¾+$increment';
      case 30:
        displayTime = '½+$increment';
      case 15:
        displayTime = '¼+$increment';
      default:
        displayTime = '${(time / 60).floor()}+$increment';
    }
    return displayTime;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeControl &&
          runtimeType == other.runtimeType &&
          time == other.time &&
          increment == other.increment;

  @override
  int get hashCode => Object.hash(time, increment);
}
