// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relationship_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RelationshipModelImpl _$$RelationshipModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RelationshipModelImpl(
      id: json['id'] as String,
      createdAt: const TimestampToDateTimeConverter()
          .fromJson(json['createdAt'] as Timestamp?),
      updatedAt: const TimestampToDateTimeConverter()
          .fromJson(json['updatedAt'] as Timestamp?),
      userIds:
          (json['userIds'] as List<dynamic>?)?.map((e) => e as String).toList(),
      status: $enumDecodeNullable(_$RelationshipStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$RelationshipModelImplToJson(
        _$RelationshipModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt':
          const TimestampToDateTimeConverter().toJson(instance.createdAt),
      'updatedAt':
          const TimestampToDateTimeConverter().toJson(instance.updatedAt),
      'userIds': instance.userIds,
      'status': _$RelationshipStatusEnumMap[instance.status],
    };

const _$RelationshipStatusEnumMap = {
  RelationshipStatus.requestedByFirst: 'requestedByFirst',
  RelationshipStatus.requestedByLast: 'requestedByLast',
  RelationshipStatus.friends: 'friends',
  RelationshipStatus.canceled: 'canceled',
  RelationshipStatus.blockedByFirst: 'blockedByFirst',
  RelationshipStatus.blockedByLast: 'blockedByLast',
};
