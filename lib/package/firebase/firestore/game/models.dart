import 'package:fast_immutable_collections/fast_immutable_collections.dart';

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

  final int value;

  static final nameMap = IMap(GameStatus.values.asNameMap());
}
