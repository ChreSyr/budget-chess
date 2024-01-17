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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) {
  return _MessageModel.fromJson(json);
}

/// @nodoc
mixin _$MessageModel {
  String? get id => throw _privateConstructorUsedError;
  @TimestampToDateTimeConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampToDateTimeConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get authorId => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  PreviewData? get previewData => throw _privateConstructorUsedError;
  String? get remoteId =>
      throw _privateConstructorUsedError; // MessageModel? repliedMessage,
  String? get roomId => throw _privateConstructorUsedError;
  bool? get showStatus => throw _privateConstructorUsedError;
  MessageStatus? get status => throw _privateConstructorUsedError;
  MessageType? get type => throw _privateConstructorUsedError;
  String? get mediaName => throw _privateConstructorUsedError;
  num? get mediaSize => throw _privateConstructorUsedError;
  double? get mediaHeight => throw _privateConstructorUsedError;
  double? get mediaWidth => throw _privateConstructorUsedError;
  String? get uri => throw _privateConstructorUsedError;

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
      {String? id,
      @TimestampToDateTimeConverter() DateTime? createdAt,
      @TimestampToDateTimeConverter() DateTime? updatedAt,
      String? authorId,
      String? text,
      Map<String, dynamic>? metadata,
      PreviewData? previewData,
      String? remoteId,
      String? roomId,
      bool? showStatus,
      MessageStatus? status,
      MessageType? type,
      String? mediaName,
      num? mediaSize,
      double? mediaHeight,
      double? mediaWidth,
      String? uri});
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
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? authorId = freezed,
    Object? text = freezed,
    Object? metadata = freezed,
    Object? previewData = freezed,
    Object? remoteId = freezed,
    Object? roomId = freezed,
    Object? showStatus = freezed,
    Object? status = freezed,
    Object? type = freezed,
    Object? mediaName = freezed,
    Object? mediaSize = freezed,
    Object? mediaHeight = freezed,
    Object? mediaWidth = freezed,
    Object? uri = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      authorId: freezed == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      previewData: freezed == previewData
          ? _value.previewData
          : previewData // ignore: cast_nullable_to_non_nullable
              as PreviewData?,
      remoteId: freezed == remoteId
          ? _value.remoteId
          : remoteId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomId: freezed == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String?,
      showStatus: freezed == showStatus
          ? _value.showStatus
          : showStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MessageStatus?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType?,
      mediaName: freezed == mediaName
          ? _value.mediaName
          : mediaName // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaSize: freezed == mediaSize
          ? _value.mediaSize
          : mediaSize // ignore: cast_nullable_to_non_nullable
              as num?,
      mediaHeight: freezed == mediaHeight
          ? _value.mediaHeight
          : mediaHeight // ignore: cast_nullable_to_non_nullable
              as double?,
      mediaWidth: freezed == mediaWidth
          ? _value.mediaWidth
          : mediaWidth // ignore: cast_nullable_to_non_nullable
              as double?,
      uri: freezed == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as String?,
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
      {String? id,
      @TimestampToDateTimeConverter() DateTime? createdAt,
      @TimestampToDateTimeConverter() DateTime? updatedAt,
      String? authorId,
      String? text,
      Map<String, dynamic>? metadata,
      PreviewData? previewData,
      String? remoteId,
      String? roomId,
      bool? showStatus,
      MessageStatus? status,
      MessageType? type,
      String? mediaName,
      num? mediaSize,
      double? mediaHeight,
      double? mediaWidth,
      String? uri});
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
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? authorId = freezed,
    Object? text = freezed,
    Object? metadata = freezed,
    Object? previewData = freezed,
    Object? remoteId = freezed,
    Object? roomId = freezed,
    Object? showStatus = freezed,
    Object? status = freezed,
    Object? type = freezed,
    Object? mediaName = freezed,
    Object? mediaSize = freezed,
    Object? mediaHeight = freezed,
    Object? mediaWidth = freezed,
    Object? uri = freezed,
  }) {
    return _then(_$MessageModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      authorId: freezed == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      previewData: freezed == previewData
          ? _value.previewData
          : previewData // ignore: cast_nullable_to_non_nullable
              as PreviewData?,
      remoteId: freezed == remoteId
          ? _value.remoteId
          : remoteId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomId: freezed == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String?,
      showStatus: freezed == showStatus
          ? _value.showStatus
          : showStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MessageStatus?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType?,
      mediaName: freezed == mediaName
          ? _value.mediaName
          : mediaName // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaSize: freezed == mediaSize
          ? _value.mediaSize
          : mediaSize // ignore: cast_nullable_to_non_nullable
              as num?,
      mediaHeight: freezed == mediaHeight
          ? _value.mediaHeight
          : mediaHeight // ignore: cast_nullable_to_non_nullable
              as double?,
      mediaWidth: freezed == mediaWidth
          ? _value.mediaWidth
          : mediaWidth // ignore: cast_nullable_to_non_nullable
              as double?,
      uri: freezed == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageModelImpl extends _MessageModel {
  _$MessageModelImpl(
      {this.id,
      @TimestampToDateTimeConverter() this.createdAt,
      @TimestampToDateTimeConverter() this.updatedAt,
      this.authorId,
      this.text,
      final Map<String, dynamic>? metadata,
      this.previewData,
      this.remoteId,
      this.roomId,
      this.showStatus,
      this.status,
      this.type,
      this.mediaName,
      this.mediaSize,
      this.mediaHeight,
      this.mediaWidth,
      this.uri})
      : _metadata = metadata,
        super._();

  factory _$MessageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageModelImplFromJson(json);

  @override
  final String? id;
  @override
  @TimestampToDateTimeConverter()
  final DateTime? createdAt;
  @override
  @TimestampToDateTimeConverter()
  final DateTime? updatedAt;
  @override
  final String? authorId;
  @override
  final String? text;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final PreviewData? previewData;
  @override
  final String? remoteId;
// MessageModel? repliedMessage,
  @override
  final String? roomId;
  @override
  final bool? showStatus;
  @override
  final MessageStatus? status;
  @override
  final MessageType? type;
  @override
  final String? mediaName;
  @override
  final num? mediaSize;
  @override
  final double? mediaHeight;
  @override
  final double? mediaWidth;
  @override
  final String? uri;

  @override
  String toString() {
    return 'MessageModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, authorId: $authorId, text: $text, metadata: $metadata, previewData: $previewData, remoteId: $remoteId, roomId: $roomId, showStatus: $showStatus, status: $status, type: $type, mediaName: $mediaName, mediaSize: $mediaSize, mediaHeight: $mediaHeight, mediaWidth: $mediaWidth, uri: $uri)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.previewData, previewData) ||
                other.previewData == previewData) &&
            (identical(other.remoteId, remoteId) ||
                other.remoteId == remoteId) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.showStatus, showStatus) ||
                other.showStatus == showStatus) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.mediaName, mediaName) ||
                other.mediaName == mediaName) &&
            (identical(other.mediaSize, mediaSize) ||
                other.mediaSize == mediaSize) &&
            (identical(other.mediaHeight, mediaHeight) ||
                other.mediaHeight == mediaHeight) &&
            (identical(other.mediaWidth, mediaWidth) ||
                other.mediaWidth == mediaWidth) &&
            (identical(other.uri, uri) || other.uri == uri));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      updatedAt,
      authorId,
      text,
      const DeepCollectionEquality().hash(_metadata),
      previewData,
      remoteId,
      roomId,
      showStatus,
      status,
      type,
      mediaName,
      mediaSize,
      mediaHeight,
      mediaWidth,
      uri);

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
      {final String? id,
      @TimestampToDateTimeConverter() final DateTime? createdAt,
      @TimestampToDateTimeConverter() final DateTime? updatedAt,
      final String? authorId,
      final String? text,
      final Map<String, dynamic>? metadata,
      final PreviewData? previewData,
      final String? remoteId,
      final String? roomId,
      final bool? showStatus,
      final MessageStatus? status,
      final MessageType? type,
      final String? mediaName,
      final num? mediaSize,
      final double? mediaHeight,
      final double? mediaWidth,
      final String? uri}) = _$MessageModelImpl;
  _MessageModel._() : super._();

  factory _MessageModel.fromJson(Map<String, dynamic> json) =
      _$MessageModelImpl.fromJson;

  @override
  String? get id;
  @override
  @TimestampToDateTimeConverter()
  DateTime? get createdAt;
  @override
  @TimestampToDateTimeConverter()
  DateTime? get updatedAt;
  @override
  String? get authorId;
  @override
  String? get text;
  @override
  Map<String, dynamic>? get metadata;
  @override
  PreviewData? get previewData;
  @override
  String? get remoteId;
  @override // MessageModel? repliedMessage,
  String? get roomId;
  @override
  bool? get showStatus;
  @override
  MessageStatus? get status;
  @override
  MessageType? get type;
  @override
  String? get mediaName;
  @override
  num? get mediaSize;
  @override
  double? get mediaHeight;
  @override
  double? get mediaWidth;
  @override
  String? get uri;
  @override
  @JsonKey(ignore: true)
  _$$MessageModelImplCopyWith<_$MessageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
