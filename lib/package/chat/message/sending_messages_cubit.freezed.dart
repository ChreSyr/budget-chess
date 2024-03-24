// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sending_messages_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SendingMessages _$SendingMessagesFromJson(Map<String, dynamic> json) {
  return _SendingMessages.fromJson(json);
}

/// @nodoc
mixin _$SendingMessages {
  @ListMessagesConverter()
  List<MessageModel> get messages => throw _privateConstructorUsedError;
  SendingStatus get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SendingMessagesCopyWith<SendingMessages> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendingMessagesCopyWith<$Res> {
  factory $SendingMessagesCopyWith(
          SendingMessages value, $Res Function(SendingMessages) then) =
      _$SendingMessagesCopyWithImpl<$Res, SendingMessages>;
  @useResult
  $Res call(
      {@ListMessagesConverter() List<MessageModel> messages,
      SendingStatus status});
}

/// @nodoc
class _$SendingMessagesCopyWithImpl<$Res, $Val extends SendingMessages>
    implements $SendingMessagesCopyWith<$Res> {
  _$SendingMessagesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MessageModel>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SendingStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SendingMessagesImplCopyWith<$Res>
    implements $SendingMessagesCopyWith<$Res> {
  factory _$$SendingMessagesImplCopyWith(_$SendingMessagesImpl value,
          $Res Function(_$SendingMessagesImpl) then) =
      __$$SendingMessagesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@ListMessagesConverter() List<MessageModel> messages,
      SendingStatus status});
}

/// @nodoc
class __$$SendingMessagesImplCopyWithImpl<$Res>
    extends _$SendingMessagesCopyWithImpl<$Res, _$SendingMessagesImpl>
    implements _$$SendingMessagesImplCopyWith<$Res> {
  __$$SendingMessagesImplCopyWithImpl(
      _$SendingMessagesImpl _value, $Res Function(_$SendingMessagesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? status = null,
  }) {
    return _then(_$SendingMessagesImpl(
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MessageModel>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SendingStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SendingMessagesImpl implements _SendingMessages {
  _$SendingMessagesImpl(
      {@ListMessagesConverter() final List<MessageModel> messages = const [],
      this.status = SendingStatus.idle})
      : _messages = messages;

  factory _$SendingMessagesImpl.fromJson(Map<String, dynamic> json) =>
      _$$SendingMessagesImplFromJson(json);

  final List<MessageModel> _messages;
  @override
  @JsonKey()
  @ListMessagesConverter()
  List<MessageModel> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  @JsonKey()
  final SendingStatus status;

  @override
  String toString() {
    return 'SendingMessages(messages: $messages, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendingMessagesImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_messages), status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendingMessagesImplCopyWith<_$SendingMessagesImpl> get copyWith =>
      __$$SendingMessagesImplCopyWithImpl<_$SendingMessagesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SendingMessagesImplToJson(
      this,
    );
  }
}

abstract class _SendingMessages implements SendingMessages {
  factory _SendingMessages(
      {@ListMessagesConverter() final List<MessageModel> messages,
      final SendingStatus status}) = _$SendingMessagesImpl;

  factory _SendingMessages.fromJson(Map<String, dynamic> json) =
      _$SendingMessagesImpl.fromJson;

  @override
  @ListMessagesConverter()
  List<MessageModel> get messages;
  @override
  SendingStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$SendingMessagesImplCopyWith<_$SendingMessagesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
