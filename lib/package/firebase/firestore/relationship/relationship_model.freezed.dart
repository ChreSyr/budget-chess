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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RelationshipModel _$RelationshipModelFromJson(Map<String, dynamic> json) {
  return _RelationshipModel.fromJson(json);
}

/// @nodoc
mixin _$RelationshipModel {
  String get id => throw _privateConstructorUsedError;
  @protected
  Map<String, UserInRelationshipStatus> get users =>
      throw _privateConstructorUsedError;

  /// Last time the status of one of the users changes. Used to determine the
  /// duration of a frienship.
  @TimestampToDateTimeConverter()
  DateTime? get lastUserStatusUpdate => throw _privateConstructorUsedError;

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
      {String id,
      @protected Map<String, UserInRelationshipStatus> users,
      @TimestampToDateTimeConverter() DateTime? lastUserStatusUpdate});
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
    Object? id = null,
    Object? users = null,
    Object? lastUserStatusUpdate = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as Map<String, UserInRelationshipStatus>,
      lastUserStatusUpdate: freezed == lastUserStatusUpdate
          ? _value.lastUserStatusUpdate
          : lastUserStatusUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      {String id,
      @protected Map<String, UserInRelationshipStatus> users,
      @TimestampToDateTimeConverter() DateTime? lastUserStatusUpdate});
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
    Object? id = null,
    Object? users = null,
    Object? lastUserStatusUpdate = freezed,
  }) {
    return _then(_$RelationshipModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as Map<String, UserInRelationshipStatus>,
      lastUserStatusUpdate: freezed == lastUserStatusUpdate
          ? _value.lastUserStatusUpdate
          : lastUserStatusUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RelationshipModelImpl extends _RelationshipModel {
  _$RelationshipModelImpl(
      {required this.id,
      @protected required final Map<String, UserInRelationshipStatus> users,
      @TimestampToDateTimeConverter() this.lastUserStatusUpdate})
      : _users = users,
        super._();

  factory _$RelationshipModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RelationshipModelImplFromJson(json);

  @override
  final String id;
  final Map<String, UserInRelationshipStatus> _users;
  @override
  @protected
  Map<String, UserInRelationshipStatus> get users {
    if (_users is EqualUnmodifiableMapView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_users);
  }

  /// Last time the status of one of the users changes. Used to determine the
  /// duration of a frienship.
  @override
  @TimestampToDateTimeConverter()
  final DateTime? lastUserStatusUpdate;

  @override
  String toString() {
    return 'RelationshipModel(id: $id, users: $users, lastUserStatusUpdate: $lastUserStatusUpdate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RelationshipModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.lastUserStatusUpdate, lastUserStatusUpdate) ||
                other.lastUserStatusUpdate == lastUserStatusUpdate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id,
      const DeepCollectionEquality().hash(_users), lastUserStatusUpdate);

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
      {required final String id,
      @protected required final Map<String, UserInRelationshipStatus> users,
      @TimestampToDateTimeConverter()
      final DateTime? lastUserStatusUpdate}) = _$RelationshipModelImpl;
  _RelationshipModel._() : super._();

  factory _RelationshipModel.fromJson(Map<String, dynamic> json) =
      _$RelationshipModelImpl.fromJson;

  @override
  String get id;
  @override
  @protected
  Map<String, UserInRelationshipStatus> get users;
  @override

  /// Last time the status of one of the users changes. Used to determine the
  /// duration of a frienship.
  @TimestampToDateTimeConverter()
  DateTime? get lastUserStatusUpdate;
  @override
  @JsonKey(ignore: true)
  _$$RelationshipModelImplCopyWith<_$RelationshipModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
