import 'package:crea_chess/package/chessground/speed.dart';
import 'package:crea_chess/package/lichess/lichess_icons.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';

enum GameStatus {
  unknown(-1),
  created(10),
  started(20),
  aborted(25),
  mate(30),
  resign(31),
  stalemate(32),
  timeout(33),
  draw(34),
  outoftime(35),
  cheat(36),
  noStart(37),
  unknownFinish(38),
  variantEnd(60);

  const GameStatus(this.value);

  static final nameMap = IMap(GameStatus.values.asNameMap());

  final int value;
}

// TODO : use ? remove ?
enum GameSource {
  lobby,
  friend,
  ai,
  api,
  arena,
  position,
  import,
  importLive,
  simul,
  relay,
  pool,
  swiss,
  unknown;

  static final nameMap = IMap(GameSource.values.asNameMap());
}

enum GameRule {
  noAbort,
  noRematch,
  noClaimWin,
  unknown;

  static final nameMap = IMap(GameRule.values.asNameMap());
}

/// Represents a lichess rating perf item
///
/// TODO : rethink ratings system for BudgetChess
enum Perf {
  ultraBullet('UltraBullet', 'Ultra', LichessIcons.ultrabullet),
  bullet('Bullet', 'Bullet', LichessIcons.bullet),
  blitz('Blitz', 'Blitz', LichessIcons.blitz),
  rapid('Rapid', 'Rapid', LichessIcons.rapid),
  classical('Classical', 'Classical', LichessIcons.classical),
  correspondence('Correspondence', 'Corresp.', LichessIcons.correspondence),
  fromPosition('From Position', 'From Pos.', LichessIcons.feather),
  chess960('Chess 960', '960', LichessIcons.die_six),
  antichess('Antichess', 'Antichess', LichessIcons.antichess),
  kingOfTheHill('King Of The Hill', 'KotH', LichessIcons.flag),
  threeCheck('Three-check', '3check', LichessIcons.three_check),
  atomic('Atomic', 'Atomic', LichessIcons.atom),
  horde('Horde', 'Horde', LichessIcons.horde),
  racingKings('Racing Kings', 'Racing', LichessIcons.racing_kings),
  crazyhouse('Crazyhouse', 'Crazy', LichessIcons.h_square),
  puzzle('Puzzle', 'Puzzle', LichessIcons.target),
  storm('Storm', 'Storm', LichessIcons.storm);

  const Perf(this.title, this.shortTitle, this.icon);

  // TODO : and from StartSetup
  factory Perf.fromRuleAndSpeed(Rule rule, Speed speed) {
    switch (rule) {
      case Rule.chess:
        switch (speed) {
          case Speed.bullet:
            return Perf.bullet;
          case Speed.blitz:
            return Perf.blitz;
          case Speed.rapid:
            return Perf.rapid;
          case Speed.classical:
            return Perf.classical;
        }
      case Rule.antichess:
        return Perf.antichess;
      case Rule.kingofthehill:
        return Perf.kingOfTheHill;
      case Rule.threecheck:
        return Perf.threeCheck;
      case Rule.atomic:
        return Perf.atomic;
      case Rule.horde:
        return Perf.horde;
      case Rule.racingKings:
        return Perf.racingKings;
      case Rule.crazyhouse:
        return Perf.crazyhouse;
    }
  }

  final String title;
  final String shortTitle;
  final IconData icon;

  static IMap<String, Perf> nameMap = IMap(Perf.values.asNameMap());
}
