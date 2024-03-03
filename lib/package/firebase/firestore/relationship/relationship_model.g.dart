// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relationship_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RelationshipModelImpl _$$RelationshipModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RelationshipModelImpl(
      id: json['id'] as String,
      users: (json['users'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, $enumDecode(_$UserInRelationshipStatusEnumMap, e)),
      ),
      lastUserStatusUpdate: const TimestampToDateTimeConverter()
          .fromJson(json['lastUserStatusUpdate'] as Timestamp?),
    );

Map<String, dynamic> _$$RelationshipModelImplToJson(
        _$RelationshipModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'users': instance.users
          .map((k, e) => MapEntry(k, _$UserInRelationshipStatusEnumMap[e]!)),
      'lastUserStatusUpdate': const TimestampToDateTimeConverter()
          .toJson(instance.lastUserStatusUpdate),
    };

const _$UserInRelationshipStatusEnumMap = {
  UserInRelationshipStatus.none: 'none',
  UserInRelationshipStatus.requests: 'requests',
  UserInRelationshipStatus.isRequested: 'isRequested',
  UserInRelationshipStatus.refuses: 'refuses',
  UserInRelationshipStatus.isRefused: 'isRefused',
  UserInRelationshipStatus.open: 'open',
  UserInRelationshipStatus.cancels: 'cancels',
  UserInRelationshipStatus.isCanceled: 'isCanceled',
  UserInRelationshipStatus.blocks: 'blocks',
  UserInRelationshipStatus.isBlocked: 'isBlocked',
  UserInRelationshipStatus.hasDeletedAccount: 'hasDeletedAccount',
};
