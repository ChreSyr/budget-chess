// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sending_messages_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SendingMessagesImpl _$$SendingMessagesImplFromJson(
        Map<String, dynamic> json) =>
    _$SendingMessagesImpl(
      messages: json['messages'] == null
          ? const []
          : const ListMessagesConverter()
              .fromJson(json['messages'] as List<Map<String, dynamic>>),
      status: $enumDecodeNullable(_$SendingStatusEnumMap, json['status']) ??
          SendingStatus.idle,
    );

Map<String, dynamic> _$$SendingMessagesImplToJson(
        _$SendingMessagesImpl instance) =>
    <String, dynamic>{
      'messages': const ListMessagesConverter().toJson(instance.messages),
      'status': _$SendingStatusEnumMap[instance.status]!,
    };

const _$SendingStatusEnumMap = {
  SendingStatus.idle: 'idle',
  SendingStatus.sending: 'sending',
  SendingStatus.error: 'error',
};
