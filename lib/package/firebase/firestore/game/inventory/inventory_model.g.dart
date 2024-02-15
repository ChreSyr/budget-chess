// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryModelImpl _$$InventoryModelImplFromJson(Map<String, dynamic> json) =>
    _$InventoryModelImpl(
      id: json['id'] as String,
      ownerId: json['ownerId'] as String,
      bishops: json['bishops'] as int? ?? 2,
      knights: json['knights'] as int? ?? 2,
      pawns: json['pawns'] as int? ?? 8,
      queens: json['queens'] as int? ?? 1,
      rooks: json['rooks'] as int? ?? 2,
    );

Map<String, dynamic> _$$InventoryModelImplToJson(
        _$InventoryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'bishops': instance.bishops,
      'knights': instance.knights,
      'pawns': instance.pawns,
      'queens': instance.queens,
      'rooks': instance.rooks,
    };
