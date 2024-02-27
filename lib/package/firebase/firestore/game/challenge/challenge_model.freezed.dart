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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChallengeModel _$ChallengeModelFromJson(Map<String, dynamic> json) {
  return _ChallengeModel.fromJson(json);
}

/// @nodoc
mixin _$ChallengeModel {
  String get id => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get acceptedAt => throw _privateConstructorUsedError;
  String? get authorId => throw _privateConstructorUsedError;
  Rule get rule => throw _privateConstructorUsedError;
  int get time => throw _privateConstructorUsedError; // in seconds
  int get increment => throw _privateConstructorUsedError; // in seconds
  @protected
  @BoardSizeConverter()
  BoardSize? get boardSizeProtected => throw _privateConstructorUsedError;
  int get budget => throw _privateConstructorUsedError;

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
      DateTime? acceptedAt,
      String? authorId,
      Rule rule,
      int time,
      int increment,
      @protected @BoardSizeConverter() BoardSize? boardSizeProtected,
      int budget});
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
    Object? acceptedAt = freezed,
    Object? authorId = freezed,
    Object? rule = null,
    Object? time = null,
    Object? increment = null,
    Object? boardSizeProtected = freezed,
    Object? budget = null,
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
      acceptedAt: freezed == acceptedAt
          ? _value.acceptedAt
          : acceptedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      authorId: freezed == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String?,
      rule: null == rule
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as Rule,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      increment: null == increment
          ? _value.increment
          : increment // ignore: cast_nullable_to_non_nullable
              as int,
      boardSizeProtected: freezed == boardSizeProtected
          ? _value.boardSizeProtected
          : boardSizeProtected // ignore: cast_nullable_to_non_nullable
              as BoardSize?,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as int,
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
      DateTime? acceptedAt,
      String? authorId,
      Rule rule,
      int time,
      int increment,
      @protected @BoardSizeConverter() BoardSize? boardSizeProtected,
      int budget});
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
    Object? acceptedAt = freezed,
    Object? authorId = freezed,
    Object? rule = null,
    Object? time = null,
    Object? increment = null,
    Object? boardSizeProtected = freezed,
    Object? budget = null,
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
      acceptedAt: freezed == acceptedAt
          ? _value.acceptedAt
          : acceptedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      authorId: freezed == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String?,
      rule: null == rule
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as Rule,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      increment: null == increment
          ? _value.increment
          : increment // ignore: cast_nullable_to_non_nullable
              as int,
      boardSizeProtected: freezed == boardSizeProtected
          ? _value.boardSizeProtected
          : boardSizeProtected // ignore: cast_nullable_to_non_nullable
              as BoardSize?,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeModelImpl extends _ChallengeModel {
  _$ChallengeModelImpl(
      {required this.id,
      this.createdAt,
      this.acceptedAt,
      this.authorId,
      this.rule = Rule.chess,
      this.time = 180,
      this.increment = 2,
      @protected @BoardSizeConverter() this.boardSizeProtected,
      this.budget = 39})
      : super._();

  factory _$ChallengeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeModelImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? acceptedAt;
  @override
  final String? authorId;
  @override
  @JsonKey()
  final Rule rule;
  @override
  @JsonKey()
  final int time;
// in seconds
  @override
  @JsonKey()
  final int increment;
// in seconds
  @override
  @protected
  @BoardSizeConverter()
  final BoardSize? boardSizeProtected;
  @override
  @JsonKey()
  final int budget;

  @override
  String toString() {
    return 'ChallengeModel(id: $id, createdAt: $createdAt, acceptedAt: $acceptedAt, authorId: $authorId, rule: $rule, time: $time, increment: $increment, boardSizeProtected: $boardSizeProtected, budget: $budget)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.acceptedAt, acceptedAt) ||
                other.acceptedAt == acceptedAt) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.rule, rule) || other.rule == rule) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.increment, increment) ||
                other.increment == increment) &&
            (identical(other.boardSizeProtected, boardSizeProtected) ||
                other.boardSizeProtected == boardSizeProtected) &&
            (identical(other.budget, budget) || other.budget == budget));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, acceptedAt,
      authorId, rule, time, increment, boardSizeProtected, budget);

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
      {required final String id,
      final DateTime? createdAt,
      final DateTime? acceptedAt,
      final String? authorId,
      final Rule rule,
      final int time,
      final int increment,
      @protected @BoardSizeConverter() final BoardSize? boardSizeProtected,
      final int budget}) = _$ChallengeModelImpl;
  _ChallengeModel._() : super._();

  factory _ChallengeModel.fromJson(Map<String, dynamic> json) =
      _$ChallengeModelImpl.fromJson;

  @override
  String get id;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get acceptedAt;
  @override
  String? get authorId;
  @override
  Rule get rule;
  @override
  int get time;
  @override // in seconds
  int get increment;
  @override // in seconds
  @protected
  @BoardSizeConverter()
  BoardSize? get boardSizeProtected;
  @override
  int get budget;
  @override
  @JsonKey(ignore: true)
  _$$ChallengeModelImplCopyWith<_$ChallengeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
