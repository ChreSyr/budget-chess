// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge_filter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChallengeFilterModel _$ChallengeFilterModelFromJson(Map<String, dynamic> json) {
  return _ChallengeSorterState.fromJson(json);
}

/// @nodoc
mixin _$ChallengeFilterModel {
  String? get id => throw _privateConstructorUsedError;
  Set<Speed> get speed => throw _privateConstructorUsedError;
  bool get budgetAsc => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChallengeFilterModelCopyWith<ChallengeFilterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeFilterModelCopyWith<$Res> {
  factory $ChallengeFilterModelCopyWith(ChallengeFilterModel value,
          $Res Function(ChallengeFilterModel) then) =
      _$ChallengeFilterModelCopyWithImpl<$Res, ChallengeFilterModel>;
  @useResult
  $Res call({String? id, Set<Speed> speed, bool budgetAsc});
}

/// @nodoc
class _$ChallengeFilterModelCopyWithImpl<$Res,
        $Val extends ChallengeFilterModel>
    implements $ChallengeFilterModelCopyWith<$Res> {
  _$ChallengeFilterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? speed = null,
    Object? budgetAsc = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as Set<Speed>,
      budgetAsc: null == budgetAsc
          ? _value.budgetAsc
          : budgetAsc // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChallengeSorterStateImplCopyWith<$Res>
    implements $ChallengeFilterModelCopyWith<$Res> {
  factory _$$ChallengeSorterStateImplCopyWith(_$ChallengeSorterStateImpl value,
          $Res Function(_$ChallengeSorterStateImpl) then) =
      __$$ChallengeSorterStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, Set<Speed> speed, bool budgetAsc});
}

/// @nodoc
class __$$ChallengeSorterStateImplCopyWithImpl<$Res>
    extends _$ChallengeFilterModelCopyWithImpl<$Res, _$ChallengeSorterStateImpl>
    implements _$$ChallengeSorterStateImplCopyWith<$Res> {
  __$$ChallengeSorterStateImplCopyWithImpl(_$ChallengeSorterStateImpl _value,
      $Res Function(_$ChallengeSorterStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? speed = null,
    Object? budgetAsc = null,
  }) {
    return _then(_$ChallengeSorterStateImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      speed: null == speed
          ? _value._speed
          : speed // ignore: cast_nullable_to_non_nullable
              as Set<Speed>,
      budgetAsc: null == budgetAsc
          ? _value.budgetAsc
          : budgetAsc // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeSorterStateImpl extends _ChallengeSorterState {
  _$ChallengeSorterStateImpl(
      {this.id, final Set<Speed> speed = const {}, this.budgetAsc = true})
      : _speed = speed,
        super._();

  factory _$ChallengeSorterStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeSorterStateImplFromJson(json);

  @override
  final String? id;
  final Set<Speed> _speed;
  @override
  @JsonKey()
  Set<Speed> get speed {
    if (_speed is EqualUnmodifiableSetView) return _speed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_speed);
  }

  @override
  @JsonKey()
  final bool budgetAsc;

  @override
  String toString() {
    return 'ChallengeFilterModel(id: $id, speed: $speed, budgetAsc: $budgetAsc)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeSorterStateImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._speed, _speed) &&
            (identical(other.budgetAsc, budgetAsc) ||
                other.budgetAsc == budgetAsc));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_speed), budgetAsc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeSorterStateImplCopyWith<_$ChallengeSorterStateImpl>
      get copyWith =>
          __$$ChallengeSorterStateImplCopyWithImpl<_$ChallengeSorterStateImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengeSorterStateImplToJson(
      this,
    );
  }
}

abstract class _ChallengeSorterState extends ChallengeFilterModel {
  factory _ChallengeSorterState(
      {final String? id,
      final Set<Speed> speed,
      final bool budgetAsc}) = _$ChallengeSorterStateImpl;
  _ChallengeSorterState._() : super._();

  factory _ChallengeSorterState.fromJson(Map<String, dynamic> json) =
      _$ChallengeSorterStateImpl.fromJson;

  @override
  String? get id;
  @override
  Set<Speed> get speed;
  @override
  bool get budgetAsc;
  @override
  @JsonKey(ignore: true)
  _$$ChallengeSorterStateImplCopyWith<_$ChallengeSorterStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
