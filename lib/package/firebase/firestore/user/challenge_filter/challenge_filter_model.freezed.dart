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
  String get userId => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  Set<Speed> get speeds => throw _privateConstructorUsedError;
  Set<Rules> get rules => throw _privateConstructorUsedError;

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
  $Res call({String userId, String id, Set<Speed> speeds, Set<Rules> rules});
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
    Object? userId = null,
    Object? id = null,
    Object? speeds = null,
    Object? rules = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      speeds: null == speeds
          ? _value.speeds
          : speeds // ignore: cast_nullable_to_non_nullable
              as Set<Speed>,
      rules: null == rules
          ? _value.rules
          : rules // ignore: cast_nullable_to_non_nullable
              as Set<Rules>,
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
  $Res call({String userId, String id, Set<Speed> speeds, Set<Rules> rules});
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
    Object? userId = null,
    Object? id = null,
    Object? speeds = null,
    Object? rules = null,
  }) {
    return _then(_$ChallengeSorterStateImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      speeds: null == speeds
          ? _value._speeds
          : speeds // ignore: cast_nullable_to_non_nullable
              as Set<Speed>,
      rules: null == rules
          ? _value._rules
          : rules // ignore: cast_nullable_to_non_nullable
              as Set<Rules>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeSorterStateImpl extends _ChallengeSorterState {
  _$ChallengeSorterStateImpl(
      {this.userId = ChallengeFilterModel._local,
      this.id = ChallengeFilterModel._local,
      final Set<Speed> speeds = const {
        Speed.bullet,
        Speed.blitz,
        Speed.rapid,
        Speed.classical
      },
      final Set<Rules> rules = const {Rules.chess}})
      : _speeds = speeds,
        _rules = rules,
        super._();

  factory _$ChallengeSorterStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeSorterStateImplFromJson(json);

  @override
  @JsonKey()
  final String userId;
  @override
  @JsonKey()
  final String id;
  final Set<Speed> _speeds;
  @override
  @JsonKey()
  Set<Speed> get speeds {
    if (_speeds is EqualUnmodifiableSetView) return _speeds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_speeds);
  }

  final Set<Rules> _rules;
  @override
  @JsonKey()
  Set<Rules> get rules {
    if (_rules is EqualUnmodifiableSetView) return _rules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_rules);
  }

  @override
  String toString() {
    return 'ChallengeFilterModel(userId: $userId, id: $id, speeds: $speeds, rules: $rules)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeSorterStateImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._speeds, _speeds) &&
            const DeepCollectionEquality().equals(other._rules, _rules));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      id,
      const DeepCollectionEquality().hash(_speeds),
      const DeepCollectionEquality().hash(_rules));

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
      {final String userId,
      final String id,
      final Set<Speed> speeds,
      final Set<Rules> rules}) = _$ChallengeSorterStateImpl;
  _ChallengeSorterState._() : super._();

  factory _ChallengeSorterState.fromJson(Map<String, dynamic> json) =
      _$ChallengeSorterStateImpl.fromJson;

  @override
  String get userId;
  @override
  String get id;
  @override
  Set<Speed> get speeds;
  @override
  Set<Rules> get rules;
  @override
  @JsonKey(ignore: true)
  _$$ChallengeSorterStateImplCopyWith<_$ChallengeSorterStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
