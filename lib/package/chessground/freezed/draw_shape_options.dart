import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'draw_shape_options.freezed.dart';
part 'draw_shape_options.g.dart';

class ColorConverter implements JsonConverter<Color, int> {
  const ColorConverter();

  @override
  Color fromJson(int json) => Color(json);

  @override
  int toJson(Color color) => color.value;
}

@freezed
class DrawShapeOptions with _$DrawShapeOptions {
  const factory DrawShapeOptions({
    /// Whether to enable shape drawing.
    @Default(false) bool enable,

    /// The color of the shape being drawn.
    ///
    /// Default to lichess.org green.
    @ColorConverter() @Default(Color(0xAA15781b)) Color newShapeColor,
  }) = _DrawShapeOptions;

  factory DrawShapeOptions.fromJson(Map<String, dynamic> json) =>
      _$DrawShapeOptionsFromJson(json);
}
