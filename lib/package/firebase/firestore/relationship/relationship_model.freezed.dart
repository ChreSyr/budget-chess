// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'relationship_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RelationshipModel _$RelationshipModelFromJson(Map<String, dynamic> json) {
  return _RelationshipModel.fromJson(json);
}

/// @nodoc
mixin _$RelationshipModel {
  String? get id => throw _privateConstructorUsedError; // TODO : default to ''
  /// Date of friendship start
  @TimestampToDateTimeConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Last time a message was sent or a game got updated
  @TimestampToDateTimeConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  List<String>? get userIds =>
      throw _privateConstructorUsedError; // TODO : default to []
  RelationshipStatus? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RelationshipModelCopyWith<RelationshipModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RelationshipModelCopyWith<$Res> {
  factory $RelationshipModelCopyWith(
          RelationshipModel value, $Res Function(RelationshipModel) then) =
      _$RelationshipModelCopyWithImpl<$Res, RelationshipModel>;
  @useResult
  $Res call(
      {String? id,
      @TimestampToDateTimeConverter() DateTime? createdAt,
      @TimestampToDateTimeConverter() DateTime? updatedAt,
      List<String>? userIds,
      RelationshipStatus? status});
}

/// @nodoc
class _$RelationshipModelCopyWithImpl<$Res, $Val extends RelationshipModel>
    implements $RelationshipModelCopyWith<$Res> {
  _$RelationshipModelCopyWithImpl(this._value, this._then);

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
    Object? userIds = freezed,
    Object? status = freezed,
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
      userIds: freezed == userIds
          ? _value.userIds
          : userIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RelationshipStatus?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RelationshipModelImplCopyWith<$Res>
    implements $RelationshipModelCopyWith<$Res> {
  factory _$$RelationshipModelImplCopyWith(_$RelationshipModelImpl value,
          $Res Function(_$RelationshipModelImpl) then) =
      __$$RelationshipModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      @TimestampToDateTimeConverter() DateTime? createdAt,
      @TimestampToDateTimeConverter() DateTime? updatedAt,
      List<String>? userIds,
      RelationshipStatus? status});
}

/// @nodoc
class __$$RelationshipModelImplCopyWithImpl<$Res>
    extends _$RelationshipModelCopyWithImpl<$Res, _$RelationshipModelImpl>
    implements _$$RelationshipModelImplCopyWith<$Res> {
  __$$RelationshipModelImplCopyWithImpl(_$RelationshipModelImpl _value,
      $Res Function(_$RelationshipModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? userIds = freezed,
    Object? status = freezed,
  }) {
    return _then(_$RelationshipModelImpl(
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
      userIds: freezed == userIds
          ? _value._userIds
          : userIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RelationshipStatus?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RelationshipModelImpl extends _RelationshipModel {
  _$RelationshipModelImpl(
      {this.id,
      @TimestampToDateTimeConverter() this.createdAt,
      @TimestampToDateTimeConverter() this.updatedAt,
      final List<String>? userIds,
      this.status})
      : _userIds = userIds,
        super._();

  factory _$RelationshipModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RelationshipModelImplFromJson(json);

  @override
  final String? id;
// TODO : default to ''
  /// Date of friendship start
  @override
  @TimestampToDateTimeConverter()
  final DateTime? createdAt;

  /// Last time a message was sent or a game got updated
  @override
  @TimestampToDateTimeConverter()
  final DateTime? updatedAt;
  final List<String>? _userIds;
  @override
  List<String>? get userIds {
    final value = _userIds;
    if (value == null) return null;
    if (_userIds is EqualUnmodifiableListView) return _userIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// TODO : default to []
  @override
  final RelationshipStatus? status;

  @override
  String toString() {
    return 'RelationshipModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, userIds: $userIds, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RelationshipModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._userIds, _userIds) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, updatedAt,
      const DeepCollectionEquality().hash(_userIds), status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RelationshipModelImplCopyWith<_$RelationshipModelImpl> get copyWith =>
      __$$RelationshipModelImplCopyWithImpl<_$RelationshipModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RelationshipModelImplToJson(
      this,
    );
  }
}

abstract class _RelationshipModel extends RelationshipModel {
  factory _RelationshipModel(
      {final String? id,
      @TimestampToDateTimeConverter() final DateTime? createdAt,
      @TimestampToDateTimeConverter() final DateTime? updatedAt,
      final List<String>? userIds,
      final RelationshipStatus? status}) = _$RelationshipModelImpl;
  _RelationshipModel._() : super._();

  factory _RelationshipModel.fromJson(Map<String, dynamic> json) =
      _$RelationshipModelImpl.fromJson;

  @override
  String? get id;
  @override // TODO : default to ''
  /// Date of friendship start
  @TimestampToDateTimeConverter()
  DateTime? get createdAt;
  @override

  /// Last time a message was sent or a game got updated
  @TimestampToDateTimeConverter()
  DateTime? get updatedAt;
  @override
  List<String>? get userIds;
  @override // TODO : default to []
  RelationshipStatus? get status;
  @override
  @JsonKey(ignore: true)
  _$$RelationshipModelImplCopyWith<_$RelationshipModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
