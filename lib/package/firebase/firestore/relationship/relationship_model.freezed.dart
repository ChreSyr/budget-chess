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
  String? get id => throw _privateConstructorUsedError;
  String? get ref => throw _privateConstructorUsedError;
  List<String>? get users => throw _privateConstructorUsedError;
  RelationshipStatus? get status => throw _privateConstructorUsedError;
  List<String>? get games => throw _privateConstructorUsedError;

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
      String? ref,
      List<String>? users,
      RelationshipStatus? status,
      List<String>? games});
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
    Object? ref = freezed,
    Object? users = freezed,
    Object? status = freezed,
    Object? games = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      ref: freezed == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as String?,
      users: freezed == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RelationshipStatus?,
      games: freezed == games
          ? _value.games
          : games // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
      String? ref,
      List<String>? users,
      RelationshipStatus? status,
      List<String>? games});
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
    Object? ref = freezed,
    Object? users = freezed,
    Object? status = freezed,
    Object? games = freezed,
  }) {
    return _then(_$RelationshipModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      ref: freezed == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as String?,
      users: freezed == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RelationshipStatus?,
      games: freezed == games
          ? _value._games
          : games // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RelationshipModelImpl extends _RelationshipModel {
  _$RelationshipModelImpl(
      {this.id,
      this.ref,
      final List<String>? users,
      this.status,
      final List<String>? games})
      : _users = users,
        _games = games,
        super._();

  factory _$RelationshipModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RelationshipModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? ref;
  final List<String>? _users;
  @override
  List<String>? get users {
    final value = _users;
    if (value == null) return null;
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final RelationshipStatus? status;
  final List<String>? _games;
  @override
  List<String>? get games {
    final value = _games;
    if (value == null) return null;
    if (_games is EqualUnmodifiableListView) return _games;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'RelationshipModel(id: $id, ref: $ref, users: $users, status: $status, games: $games)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RelationshipModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ref, ref) || other.ref == ref) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._games, _games));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      ref,
      const DeepCollectionEquality().hash(_users),
      status,
      const DeepCollectionEquality().hash(_games));

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
      final String? ref,
      final List<String>? users,
      final RelationshipStatus? status,
      final List<String>? games}) = _$RelationshipModelImpl;
  _RelationshipModel._() : super._();

  factory _RelationshipModel.fromJson(Map<String, dynamic> json) =
      _$RelationshipModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get ref;
  @override
  List<String>? get users;
  @override
  RelationshipStatus? get status;
  @override
  List<String>? get games;
  @override
  @JsonKey(ignore: true)
  _$$RelationshipModelImplCopyWith<_$RelationshipModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
