import 'package:crea_chess/package/dartchess/export.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class MoveConverter implements JsonConverter<Move, String> {
  const MoveConverter();

  // assume we are serializing only valid uci strings
  @override
  Move fromJson(String json) => Move.fromUMN(json)!;

  @override
  String toJson(Move object) => object.umn;
}
