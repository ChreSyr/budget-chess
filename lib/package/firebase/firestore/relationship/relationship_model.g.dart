// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relationship_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RelationshipModelImpl _$$RelationshipModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RelationshipModelImpl(
      id: json['id'] as String?,
      ref: json['ref'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      users:
          (json['users'] as List<dynamic>?)?.map((e) => e as String).toList(),
      status: $enumDecodeNullable(_$RelationshipStatusEnumMap, json['status']),
      games:
          (json['games'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$RelationshipModelImplToJson(
        _$RelationshipModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ref': instance.ref,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'users': instance.users,
      'status': _$RelationshipStatusEnumMap[instance.status],
      'games': instance.games,
    };

const _$RelationshipStatusEnumMap = {
  RelationshipStatus.requestedByFirst: 'requestedByFirst',
  RelationshipStatus.requestedByLast: 'requestedByLast',
  RelationshipStatus.friends: 'friends',
  RelationshipStatus.canceled: 'canceled',
  RelationshipStatus.blockedByFirst: 'blockedByFirst',
  RelationshipStatus.blockedByLast: 'blockedByLast',
};
