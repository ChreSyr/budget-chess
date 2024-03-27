// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MessageToUserStatus _$MessageToUserStatusFromJson(Map<String, dynamic> json) {
  return _MessageToUserStatus.fromJson(json);
}

/// @nodoc
mixin _$MessageToUserStatus {
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  MessageSeenStatus get seenStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageToUserStatusCopyWith<MessageToUserStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageToUserStatusCopyWith<$Res> {
  factory $MessageToUserStatusCopyWith(
          MessageToUserStatus value, $Res Function(MessageToUserStatus) then) =
      _$MessageToUserStatusCopyWithImpl<$Res, MessageToUserStatus>;
  @useResult
  $Res call({DateTime? updatedAt, MessageSeenStatus seenStatus});
}

/// @nodoc
class _$MessageToUserStatusCopyWithImpl<$Res, $Val extends MessageToUserStatus>
    implements $MessageToUserStatusCopyWith<$Res> {
  _$MessageToUserStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updatedAt = freezed,
    Object? seenStatus = null,
  }) {
    return _then(_value.copyWith(
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      seenStatus: null == seenStatus
          ? _value.seenStatus
          : seenStatus // ignore: cast_nullable_to_non_nullable
              as MessageSeenStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageToUserStatusImplCopyWith<$Res>
    implements $MessageToUserStatusCopyWith<$Res> {
  factory _$$MessageToUserStatusImplCopyWith(_$MessageToUserStatusImpl value,
          $Res Function(_$MessageToUserStatusImpl) then) =
      __$$MessageToUserStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime? updatedAt, MessageSeenStatus seenStatus});
}

/// @nodoc
class __$$MessageToUserStatusImplCopyWithImpl<$Res>
    extends _$MessageToUserStatusCopyWithImpl<$Res, _$MessageToUserStatusImpl>
    implements _$$MessageToUserStatusImplCopyWith<$Res> {
  __$$MessageToUserStatusImplCopyWithImpl(_$MessageToUserStatusImpl _value,
      $Res Function(_$MessageToUserStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updatedAt = freezed,
    Object? seenStatus = null,
  }) {
    return _then(_$MessageToUserStatusImpl(
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      seenStatus: null == seenStatus
          ? _value.seenStatus
          : seenStatus // ignore: cast_nullable_to_non_nullable
              as MessageSeenStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageToUserStatusImpl implements _MessageToUserStatus {
  _$MessageToUserStatusImpl(
      {this.updatedAt, this.seenStatus = MessageSeenStatus.sentTo});

  factory _$MessageToUserStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageToUserStatusImplFromJson(json);

  @override
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final MessageSeenStatus seenStatus;

  @override
  String toString() {
    return 'MessageToUserStatus(updatedAt: $updatedAt, seenStatus: $seenStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageToUserStatusImpl &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.seenStatus, seenStatus) ||
                other.seenStatus == seenStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, updatedAt, seenStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageToUserStatusImplCopyWith<_$MessageToUserStatusImpl> get copyWith =>
      __$$MessageToUserStatusImplCopyWithImpl<_$MessageToUserStatusImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageToUserStatusImplToJson(
      this,
    );
  }
}

abstract class _MessageToUserStatus implements MessageToUserStatus {
  factory _MessageToUserStatus(
      {final DateTime? updatedAt,
      final MessageSeenStatus seenStatus}) = _$MessageToUserStatusImpl;

  factory _MessageToUserStatus.fromJson(Map<String, dynamic> json) =
      _$MessageToUserStatusImpl.fromJson;

  @override
  DateTime? get updatedAt;
  @override
  MessageSeenStatus get seenStatus;
  @override
  @JsonKey(ignore: true)
  _$$MessageToUserStatusImplCopyWith<_$MessageToUserStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) {
  return _MessageModel.fromJson(json);
}

/// @nodoc
mixin _$MessageModel {
  String get relationshipId => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  DateTime? get sentAt => throw _privateConstructorUsedError;
  MessageSendStatus get sendStatus => throw _privateConstructorUsedError;
  @MessageToUserStatusConverter()
  @protected
  Map<String, MessageToUserStatus> get statuses =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageModelCopyWith<MessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageModelCopyWith<$Res> {
  factory $MessageModelCopyWith(
          MessageModel value, $Res Function(MessageModel) then) =
      _$MessageModelCopyWithImpl<$Res, MessageModel>;
  @useResult
  $Res call(
      {String relationshipId,
      String id,
      String authorId,
      String text,
      DateTime? sentAt,
      MessageSendStatus sendStatus,
      @MessageToUserStatusConverter()
      @protected
      Map<String, MessageToUserStatus> statuses});
}

/// @nodoc
class _$MessageModelCopyWithImpl<$Res, $Val extends MessageModel>
    implements $MessageModelCopyWith<$Res> {
  _$MessageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? relationshipId = null,
    Object? id = null,
    Object? authorId = null,
    Object? text = null,
    Object? sentAt = freezed,
    Object? sendStatus = null,
    Object? statuses = null,
  }) {
    return _then(_value.copyWith(
      relationshipId: null == relationshipId
          ? _value.relationshipId
          : relationshipId // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      sentAt: freezed == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sendStatus: null == sendStatus
          ? _value.sendStatus
          : sendStatus // ignore: cast_nullable_to_non_nullable
              as MessageSendStatus,
      statuses: null == statuses
          ? _value.statuses
          : statuses // ignore: cast_nullable_to_non_nullable
              as Map<String, MessageToUserStatus>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageModelImplCopyWith<$Res>
    implements $MessageModelCopyWith<$Res> {
  factory _$$MessageModelImplCopyWith(
          _$MessageModelImpl value, $Res Function(_$MessageModelImpl) then) =
      __$$MessageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String relationshipId,
      String id,
      String authorId,
      String text,
      DateTime? sentAt,
      MessageSendStatus sendStatus,
      @MessageToUserStatusConverter()
      @protected
      Map<String, MessageToUserStatus> statuses});
}

/// @nodoc
class __$$MessageModelImplCopyWithImpl<$Res>
    extends _$MessageModelCopyWithImpl<$Res, _$MessageModelImpl>
    implements _$$MessageModelImplCopyWith<$Res> {
  __$$MessageModelImplCopyWithImpl(
      _$MessageModelImpl _value, $Res Function(_$MessageModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? relationshipId = null,
    Object? id = null,
    Object? authorId = null,
    Object? text = null,
    Object? sentAt = freezed,
    Object? sendStatus = null,
    Object? statuses = null,
  }) {
    return _then(_$MessageModelImpl(
      relationshipId: null == relationshipId
          ? _value.relationshipId
          : relationshipId // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      sentAt: freezed == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sendStatus: null == sendStatus
          ? _value.sendStatus
          : sendStatus // ignore: cast_nullable_to_non_nullable
              as MessageSendStatus,
      statuses: null == statuses
          ? _value._statuses
          : statuses // ignore: cast_nullable_to_non_nullable
              as Map<String, MessageToUserStatus>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageModelImpl extends _MessageModel {
  _$MessageModelImpl(
      {required this.relationshipId,
      required this.id,
      required this.authorId,
      required this.text,
      this.sentAt,
      this.sendStatus = MessageSendStatus.sent,
      @MessageToUserStatusConverter()
      @protected
      final Map<String, MessageToUserStatus> statuses = const {}})
      : _statuses = statuses,
        super._();

  factory _$MessageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageModelImplFromJson(json);

  @override
  final String relationshipId;
  @override
  final String id;
  @override
  final String authorId;
  @override
  final String text;
  @override
  final DateTime? sentAt;
  @override
  @JsonKey()
  final MessageSendStatus sendStatus;
  final Map<String, MessageToUserStatus> _statuses;
  @override
  @JsonKey()
  @MessageToUserStatusConverter()
  @protected
  Map<String, MessageToUserStatus> get statuses {
    if (_statuses is EqualUnmodifiableMapView) return _statuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_statuses);
  }

  @override
  String toString() {
    return 'MessageModel(relationshipId: $relationshipId, id: $id, authorId: $authorId, text: $text, sentAt: $sentAt, sendStatus: $sendStatus, statuses: $statuses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageModelImpl &&
            (identical(other.relationshipId, relationshipId) ||
                other.relationshipId == relationshipId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt) &&
            (identical(other.sendStatus, sendStatus) ||
                other.sendStatus == sendStatus) &&
            const DeepCollectionEquality().equals(other._statuses, _statuses));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, relationshipId, id, authorId,
      text, sentAt, sendStatus, const DeepCollectionEquality().hash(_statuses));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageModelImplCopyWith<_$MessageModelImpl> get copyWith =>
      __$$MessageModelImplCopyWithImpl<_$MessageModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageModelImplToJson(
      this,
    );
  }
}

abstract class _MessageModel extends MessageModel {
  factory _MessageModel(
      {required final String relationshipId,
      required final String id,
      required final String authorId,
      required final String text,
      final DateTime? sentAt,
      final MessageSendStatus sendStatus,
      @MessageToUserStatusConverter()
      @protected
      final Map<String, MessageToUserStatus> statuses}) = _$MessageModelImpl;
  _MessageModel._() : super._();

  factory _MessageModel.fromJson(Map<String, dynamic> json) =
      _$MessageModelImpl.fromJson;

  @override
  String get relationshipId;
  @override
  String get id;
  @override
  String get authorId;
  @override
  String get text;
  @override
  DateTime? get sentAt;
  @override
  MessageSendStatus get sendStatus;
  @override
  @MessageToUserStatusConverter()
  @protected
  Map<String, MessageToUserStatus> get statuses;
  @override
  @JsonKey(ignore: true)
  _$$MessageModelImplCopyWith<_$MessageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
