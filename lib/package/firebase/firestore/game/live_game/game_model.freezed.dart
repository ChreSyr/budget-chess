// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameModel {
  String get id => throw _privateConstructorUsedError;
  ChallengeModel get challenge => throw _privateConstructorUsedError;
  String get blackId => throw _privateConstructorUsedError;
  String get whiteId => throw _privateConstructorUsedError;
  GameStatus get status => throw _privateConstructorUsedError;

  /// Starting position of black pieces.
  /// null means black is seting up its pieces.
  String? get blackHalfFen => throw _privateConstructorUsedError;

  /// Starting position of white pieces.
  /// null means white is seting up its pieces.
  String? get whiteHalfFen => throw _privateConstructorUsedError;
  List<GameStep> get steps => throw _privateConstructorUsedError;
  Side? get winner =>
      throw _privateConstructorUsedError; // if status is ended & winner is null : draw
  GamePrefs? get prefs => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameModelCopyWith<GameModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameModelCopyWith<$Res> {
  factory $GameModelCopyWith(GameModel value, $Res Function(GameModel) then) =
      _$GameModelCopyWithImpl<$Res, GameModel>;
  @useResult
  $Res call(
      {String id,
      ChallengeModel challenge,
      String blackId,
      String whiteId,
      GameStatus status,
      String? blackHalfFen,
      String? whiteHalfFen,
      List<GameStep> steps,
      Side? winner,
      GamePrefs? prefs});

  $ChallengeModelCopyWith<$Res> get challenge;
  $GamePrefsCopyWith<$Res>? get prefs;
}

/// @nodoc
class _$GameModelCopyWithImpl<$Res, $Val extends GameModel>
    implements $GameModelCopyWith<$Res> {
  _$GameModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? challenge = null,
    Object? blackId = null,
    Object? whiteId = null,
    Object? status = null,
    Object? blackHalfFen = freezed,
    Object? whiteHalfFen = freezed,
    Object? steps = null,
    Object? winner = freezed,
    Object? prefs = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      challenge: null == challenge
          ? _value.challenge
          : challenge // ignore: cast_nullable_to_non_nullable
              as ChallengeModel,
      blackId: null == blackId
          ? _value.blackId
          : blackId // ignore: cast_nullable_to_non_nullable
              as String,
      whiteId: null == whiteId
          ? _value.whiteId
          : whiteId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      blackHalfFen: freezed == blackHalfFen
          ? _value.blackHalfFen
          : blackHalfFen // ignore: cast_nullable_to_non_nullable
              as String?,
      whiteHalfFen: freezed == whiteHalfFen
          ? _value.whiteHalfFen
          : whiteHalfFen // ignore: cast_nullable_to_non_nullable
              as String?,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<GameStep>,
      winner: freezed == winner
          ? _value.winner
          : winner // ignore: cast_nullable_to_non_nullable
              as Side?,
      prefs: freezed == prefs
          ? _value.prefs
          : prefs // ignore: cast_nullable_to_non_nullable
              as GamePrefs?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChallengeModelCopyWith<$Res> get challenge {
    return $ChallengeModelCopyWith<$Res>(_value.challenge, (value) {
      return _then(_value.copyWith(challenge: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GamePrefsCopyWith<$Res>? get prefs {
    if (_value.prefs == null) {
      return null;
    }

    return $GamePrefsCopyWith<$Res>(_value.prefs!, (value) {
      return _then(_value.copyWith(prefs: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameModelImplCopyWith<$Res>
    implements $GameModelCopyWith<$Res> {
  factory _$$GameModelImplCopyWith(
          _$GameModelImpl value, $Res Function(_$GameModelImpl) then) =
      __$$GameModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      ChallengeModel challenge,
      String blackId,
      String whiteId,
      GameStatus status,
      String? blackHalfFen,
      String? whiteHalfFen,
      List<GameStep> steps,
      Side? winner,
      GamePrefs? prefs});

  @override
  $ChallengeModelCopyWith<$Res> get challenge;
  @override
  $GamePrefsCopyWith<$Res>? get prefs;
}

/// @nodoc
class __$$GameModelImplCopyWithImpl<$Res>
    extends _$GameModelCopyWithImpl<$Res, _$GameModelImpl>
    implements _$$GameModelImplCopyWith<$Res> {
  __$$GameModelImplCopyWithImpl(
      _$GameModelImpl _value, $Res Function(_$GameModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? challenge = null,
    Object? blackId = null,
    Object? whiteId = null,
    Object? status = null,
    Object? blackHalfFen = freezed,
    Object? whiteHalfFen = freezed,
    Object? steps = null,
    Object? winner = freezed,
    Object? prefs = freezed,
  }) {
    return _then(_$GameModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      challenge: null == challenge
          ? _value.challenge
          : challenge // ignore: cast_nullable_to_non_nullable
              as ChallengeModel,
      blackId: null == blackId
          ? _value.blackId
          : blackId // ignore: cast_nullable_to_non_nullable
              as String,
      whiteId: null == whiteId
          ? _value.whiteId
          : whiteId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      blackHalfFen: freezed == blackHalfFen
          ? _value.blackHalfFen
          : blackHalfFen // ignore: cast_nullable_to_non_nullable
              as String?,
      whiteHalfFen: freezed == whiteHalfFen
          ? _value.whiteHalfFen
          : whiteHalfFen // ignore: cast_nullable_to_non_nullable
              as String?,
      steps: null == steps
          ? _value._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<GameStep>,
      winner: freezed == winner
          ? _value.winner
          : winner // ignore: cast_nullable_to_non_nullable
              as Side?,
      prefs: freezed == prefs
          ? _value.prefs
          : prefs // ignore: cast_nullable_to_non_nullable
              as GamePrefs?,
    ));
  }
}

/// @nodoc

class _$GameModelImpl extends _GameModel {
  const _$GameModelImpl(
      {required this.id,
      required this.challenge,
      required this.blackId,
      required this.whiteId,
      required this.status,
      this.blackHalfFen,
      this.whiteHalfFen,
      final List<GameStep> steps = const [],
      this.winner,
      this.prefs})
      : _steps = steps,
        super._();

  @override
  final String id;
  @override
  final ChallengeModel challenge;
  @override
  final String blackId;
  @override
  final String whiteId;
  @override
  final GameStatus status;

  /// Starting position of black pieces.
  /// null means black is seting up its pieces.
  @override
  final String? blackHalfFen;

  /// Starting position of white pieces.
  /// null means white is seting up its pieces.
  @override
  final String? whiteHalfFen;
  final List<GameStep> _steps;
  @override
  @JsonKey()
  List<GameStep> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  @override
  final Side? winner;
// if status is ended & winner is null : draw
  @override
  final GamePrefs? prefs;

  @override
  String toString() {
    return 'GameModel(id: $id, challenge: $challenge, blackId: $blackId, whiteId: $whiteId, status: $status, blackHalfFen: $blackHalfFen, whiteHalfFen: $whiteHalfFen, steps: $steps, winner: $winner, prefs: $prefs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.challenge, challenge) ||
                other.challenge == challenge) &&
            (identical(other.blackId, blackId) || other.blackId == blackId) &&
            (identical(other.whiteId, whiteId) || other.whiteId == whiteId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.blackHalfFen, blackHalfFen) ||
                other.blackHalfFen == blackHalfFen) &&
            (identical(other.whiteHalfFen, whiteHalfFen) ||
                other.whiteHalfFen == whiteHalfFen) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            (identical(other.winner, winner) || other.winner == winner) &&
            (identical(other.prefs, prefs) || other.prefs == prefs));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      challenge,
      blackId,
      whiteId,
      status,
      blackHalfFen,
      whiteHalfFen,
      const DeepCollectionEquality().hash(_steps),
      winner,
      prefs);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameModelImplCopyWith<_$GameModelImpl> get copyWith =>
      __$$GameModelImplCopyWithImpl<_$GameModelImpl>(this, _$identity);
}

abstract class _GameModel extends GameModel {
  const factory _GameModel(
      {required final String id,
      required final ChallengeModel challenge,
      required final String blackId,
      required final String whiteId,
      required final GameStatus status,
      final String? blackHalfFen,
      final String? whiteHalfFen,
      final List<GameStep> steps,
      final Side? winner,
      final GamePrefs? prefs}) = _$GameModelImpl;
  const _GameModel._() : super._();

  @override
  String get id;
  @override
  ChallengeModel get challenge;
  @override
  String get blackId;
  @override
  String get whiteId;
  @override
  GameStatus get status;
  @override

  /// Starting position of black pieces.
  /// null means black is seting up its pieces.
  String? get blackHalfFen;
  @override

  /// Starting position of white pieces.
  /// null means white is seting up its pieces.
  String? get whiteHalfFen;
  @override
  List<GameStep> get steps;
  @override
  Side? get winner;
  @override // if status is ended & winner is null : draw
  GamePrefs? get prefs;
  @override
  @JsonKey(ignore: true)
  _$$GameModelImplCopyWith<_$GameModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
