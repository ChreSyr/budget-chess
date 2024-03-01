import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:json_annotation/json_annotation.dart';

// TODO : move this converter somewhere else
class BoardSizeConverter
    implements JsonConverter<BoardSize, Map<String, dynamic>> {
  const BoardSizeConverter();

  @override
  BoardSize fromJson(Map<String, dynamic> json) {
    return BoardSize(
      ranks: json['ranks'] as int,
      files: json['files'] as int,
    );
  }

  @override
  Map<String, dynamic> toJson(BoardSize size) => {
        'ranks': size.ranks,
        'files': size.files,
      };
}
