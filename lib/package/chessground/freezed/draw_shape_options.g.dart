// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draw_shape_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DrawShapeOptionsImpl _$$DrawShapeOptionsImplFromJson(
        Map<String, dynamic> json) =>
    _$DrawShapeOptionsImpl(
      enable: json['enable'] as bool? ?? false,
      newShapeColor: json['newShapeColor'] == null
          ? const Color(0xAA15781b)
          : const ColorConverter().fromJson(json['newShapeColor'] as int),
    );

Map<String, dynamic> _$$DrawShapeOptionsImplToJson(
        _$DrawShapeOptionsImpl instance) =>
    <String, dynamic>{
      'enable': instance.enable,
      'newShapeColor': const ColorConverter().toJson(instance.newShapeColor),
    };
