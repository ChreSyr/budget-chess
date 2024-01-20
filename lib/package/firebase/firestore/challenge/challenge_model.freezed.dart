// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChallengeModel _$ChallengeModelFromJson(Map<String, dynamic> json) {
  return _ChallengeModel.fromJson(json);
}

/// @nodoc
mixin _$ChallengeModel {
  String get id => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String? get authorId => throw _privateConstructorUsedError;
  ChallengeStatus get status => throw _privateConstructorUsedError;
  int get time => throw _privateConstructorUsedError; // in seconds
  int get increment => throw _privateConstructorUsedError; // in seconds
  int get boardWidth => throw _privateConstructorUsedError;
  int get boardHeight => throw _privateConstructorUsedError;
  int get budget => throw _privateConstructorUsedError;
  List<String> get userIds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChallengeModelCopyWith<ChallengeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeModelCopyWith<$Res> {
  factory $ChallengeModelCopyWith(
          ChallengeModel value, $Res Function(ChallengeModel) then) =
      _$ChallengeModelCopyWithImpl<$Res, ChallengeModel>;
  @useResult
  $Res call(
      {String id,
      DateTime? createdAt,
      String? authorId,
      ChallengeStatus status,
      int time,
      int increment,
      int boardWidth,
      int boardHeight,
      int budget,
      List<String> userIds});
}

/// @nodoc
class _$ChallengeModelCopyWithImpl<$Res, $Val extends ChallengeModel>
    implements $ChallengeModelCopyWith<$Res> {
  _$ChallengeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = freezed,
    Object? authorId = freezed,
    Object? status = null,
    Object? time = null,
    Object? increment = null,
    Object? boardWidth = null,
    Object? boardHeight = null,
    Object? budget = null,
    Object? userIds = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      authorId: freezed == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ChallengeStatus,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      increment: null == increment
          ? _value.increment
          : increment // ignore: cast_nullable_to_non_nullable
              as int,
      boardWidth: null == boardWidth
          ? _value.boardWidth
          : boardWidth // ignore: cast_nullable_to_non_nullable
              as int,
      boardHeight: null == boardHeight
          ? _value.boardHeight
          : boardHeight // ignore: cast_nullable_to_non_nullable
              as int,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as int,
      userIds: null == userIds
          ? _value.userIds
          : userIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChallengeModelImplCopyWith<$Res>
    implements $ChallengeModelCopyWith<$Res> {
  factory _$$ChallengeModelImplCopyWith(_$ChallengeModelImpl value,
          $Res Function(_$ChallengeModelImpl) then) =
      __$$ChallengeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime? createdAt,
      String? authorId,
      ChallengeStatus status,
      int time,
      int increment,
      int boardWidth,
      int boardHeight,
      int budget,
      List<String> userIds});
}

/// @nodoc
class __$$ChallengeModelImplCopyWithImpl<$Res>
    extends _$ChallengeModelCopyWithImpl<$Res, _$ChallengeModelImpl>
    implements _$$ChallengeModelImplCopyWith<$Res> {
  __$$ChallengeModelImplCopyWithImpl(
      _$ChallengeModelImpl _value, $Res Function(_$ChallengeModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = freezed,
    Object? authorId = freezed,
    Object? status = null,
    Object? time = null,
    Object? increment = null,
    Object? boardWidth = null,
    Object? boardHeight = null,
    Object? budget = null,
    Object? userIds = null,
  }) {
    return _then(_$ChallengeModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      authorId: freezed == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ChallengeStatus,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      increment: null == increment
          ? _value.increment
          : increment // ignore: cast_nullable_to_non_nullable
              as int,
      boardWidth: null == boardWidth
          ? _value.boardWidth
          : boardWidth // ignore: cast_nullable_to_non_nullable
              as int,
      boardHeight: null == boardHeight
          ? _value.boardHeight
          : boardHeight // ignore: cast_nullable_to_non_nullable
              as int,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as int,
      userIds: null == userIds
          ? _value._userIds
          : userIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeModelImpl extends _ChallengeModel {
  _$ChallengeModelImpl(
      {this.id = '',
      this.createdAt,
      this.authorId,
      this.status = ChallengeStatus.finished,
      this.time = 180,
      this.increment = 2,
      this.boardWidth = 8,
      this.boardHeight = 8,
      this.budget = 39,
      final List<String> userIds = const []})
      : _userIds = userIds,
        super._();

  factory _$ChallengeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeModelImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  final DateTime? createdAt;
  @override
  final String? authorId;
  @override
  @JsonKey()
  final ChallengeStatus status;
  @override
  @JsonKey()
  final int time;
// in seconds
  @override
  @JsonKey()
  final int increment;
// in seconds
  @override
  @JsonKey()
  final int boardWidth;
  @override
  @JsonKey()
  final int boardHeight;
  @override
  @JsonKey()
  final int budget;
  final List<String> _userIds;
  @override
  @JsonKey()
  List<String> get userIds {
    if (_userIds is EqualUnmodifiableListView) return _userIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userIds);
  }

  @override
  String toString() {
    return 'ChallengeModel(id: $id, createdAt: $createdAt, authorId: $authorId, status: $status, time: $time, increment: $increment, boardWidth: $boardWidth, boardHeight: $boardHeight, budget: $budget, userIds: $userIds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.increment, increment) ||
                other.increment == increment) &&
            (identical(other.boardWidth, boardWidth) ||
                other.boardWidth == boardWidth) &&
            (identical(other.boardHeight, boardHeight) ||
                other.boardHeight == boardHeight) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            const DeepCollectionEquality().equals(other._userIds, _userIds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      authorId,
      status,
      time,
      increment,
      boardWidth,
      boardHeight,
      budget,
      const DeepCollectionEquality().hash(_userIds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeModelImplCopyWith<_$ChallengeModelImpl> get copyWith =>
      __$$ChallengeModelImplCopyWithImpl<_$ChallengeModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengeModelImplToJson(
      this,
    );
  }
}

abstract class _ChallengeModel extends ChallengeModel {
  factory _ChallengeModel(
      {final String id,
      final DateTime? createdAt,
      final String? authorId,
      final ChallengeStatus status,
      final int time,
      final int increment,
      final int boardWidth,
      final int boardHeight,
      final int budget,
      final List<String> userIds}) = _$ChallengeModelImpl;
  _ChallengeModel._() : super._();

  factory _ChallengeModel.fromJson(Map<String, dynamic> json) =
      _$ChallengeModelImpl.fromJson;

  @override
  String get id;
  @override
  DateTime? get createdAt;
  @override
  String? get authorId;
  @override
  ChallengeStatus get status;
  @override
  int get time;
  @override // in seconds
  int get increment;
  @override // in seconds
  int get boardWidth;
  @override
  int get boardHeight;
  @override
  int get budget;
  @override
  List<String> get userIds;
  @override
  @JsonKey(ignore: true)
  _$$ChallengeModelImplCopyWith<_$ChallengeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
