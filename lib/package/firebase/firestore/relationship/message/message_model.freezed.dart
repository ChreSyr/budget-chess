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

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) {
  return _MessageModel.fromJson(json);
}

/// @nodoc
mixin _$MessageModel {
  String get relationshipId => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  MessageSendStatus get sendStatus => throw _privateConstructorUsedError;
  DateTime? get sentAt => throw _privateConstructorUsedError;
  Set<String> get sentTo => throw _privateConstructorUsedError;
  Set<String> get deliveredTo => throw _privateConstructorUsedError;
  Set<String> get seenBy => throw _privateConstructorUsedError;

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
      MessageSendStatus sendStatus,
      DateTime? sentAt,
      Set<String> sentTo,
      Set<String> deliveredTo,
      Set<String> seenBy});
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
    Object? sendStatus = null,
    Object? sentAt = freezed,
    Object? sentTo = null,
    Object? deliveredTo = null,
    Object? seenBy = null,
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
      sendStatus: null == sendStatus
          ? _value.sendStatus
          : sendStatus // ignore: cast_nullable_to_non_nullable
              as MessageSendStatus,
      sentAt: freezed == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sentTo: null == sentTo
          ? _value.sentTo
          : sentTo // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      deliveredTo: null == deliveredTo
          ? _value.deliveredTo
          : deliveredTo // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      seenBy: null == seenBy
          ? _value.seenBy
          : seenBy // ignore: cast_nullable_to_non_nullable
              as Set<String>,
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
      MessageSendStatus sendStatus,
      DateTime? sentAt,
      Set<String> sentTo,
      Set<String> deliveredTo,
      Set<String> seenBy});
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
    Object? sendStatus = null,
    Object? sentAt = freezed,
    Object? sentTo = null,
    Object? deliveredTo = null,
    Object? seenBy = null,
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
      sendStatus: null == sendStatus
          ? _value.sendStatus
          : sendStatus // ignore: cast_nullable_to_non_nullable
              as MessageSendStatus,
      sentAt: freezed == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sentTo: null == sentTo
          ? _value._sentTo
          : sentTo // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      deliveredTo: null == deliveredTo
          ? _value._deliveredTo
          : deliveredTo // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      seenBy: null == seenBy
          ? _value._seenBy
          : seenBy // ignore: cast_nullable_to_non_nullable
              as Set<String>,
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
      this.sendStatus = MessageSendStatus.sent,
      this.sentAt,
      final Set<String> sentTo = const {},
      final Set<String> deliveredTo = const {},
      final Set<String> seenBy = const {}})
      : _sentTo = sentTo,
        _deliveredTo = deliveredTo,
        _seenBy = seenBy,
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
  @JsonKey()
  final MessageSendStatus sendStatus;
  @override
  final DateTime? sentAt;
  final Set<String> _sentTo;
  @override
  @JsonKey()
  Set<String> get sentTo {
    if (_sentTo is EqualUnmodifiableSetView) return _sentTo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_sentTo);
  }

  final Set<String> _deliveredTo;
  @override
  @JsonKey()
  Set<String> get deliveredTo {
    if (_deliveredTo is EqualUnmodifiableSetView) return _deliveredTo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_deliveredTo);
  }

  final Set<String> _seenBy;
  @override
  @JsonKey()
  Set<String> get seenBy {
    if (_seenBy is EqualUnmodifiableSetView) return _seenBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_seenBy);
  }

  @override
  String toString() {
    return 'MessageModel(relationshipId: $relationshipId, id: $id, authorId: $authorId, text: $text, sendStatus: $sendStatus, sentAt: $sentAt, sentTo: $sentTo, deliveredTo: $deliveredTo, seenBy: $seenBy)';
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
            (identical(other.sendStatus, sendStatus) ||
                other.sendStatus == sendStatus) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt) &&
            const DeepCollectionEquality().equals(other._sentTo, _sentTo) &&
            const DeepCollectionEquality()
                .equals(other._deliveredTo, _deliveredTo) &&
            const DeepCollectionEquality().equals(other._seenBy, _seenBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      relationshipId,
      id,
      authorId,
      text,
      sendStatus,
      sentAt,
      const DeepCollectionEquality().hash(_sentTo),
      const DeepCollectionEquality().hash(_deliveredTo),
      const DeepCollectionEquality().hash(_seenBy));

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
      final MessageSendStatus sendStatus,
      final DateTime? sentAt,
      final Set<String> sentTo,
      final Set<String> deliveredTo,
      final Set<String> seenBy}) = _$MessageModelImpl;
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
  MessageSendStatus get sendStatus;
  @override
  DateTime? get sentAt;
  @override
  Set<String> get sentTo;
  @override
  Set<String> get deliveredTo;
  @override
  Set<String> get seenBy;
  @override
  @JsonKey(ignore: true)
  _$$MessageModelImplCopyWith<_$MessageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
