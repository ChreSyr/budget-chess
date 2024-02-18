// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameState {
  GameModel get game => throw _privateConstructorUsedError;
  int get stepCursor => throw _privateConstructorUsedError;
  int? get lastDrawOfferAtPly => throw _privateConstructorUsedError;
  Duration? get opponentLeftCountdown => throw _privateConstructorUsedError;
  CGMove? get premove => throw _privateConstructorUsedError;

  /// Zen mode setting if account preference is set to [Zen.gameAuto]
  bool? get zenModeGameSetting => throw _privateConstructorUsedError;

  /// Game full id used to redirect to the new game of the rematch
  String? get redirectGameId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call(
      {GameModel game,
      int stepCursor,
      int? lastDrawOfferAtPly,
      Duration? opponentLeftCountdown,
      CGMove? premove,
      bool? zenModeGameSetting,
      String? redirectGameId});

  $GameModelCopyWith<$Res> get game;
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? game = null,
    Object? stepCursor = null,
    Object? lastDrawOfferAtPly = freezed,
    Object? opponentLeftCountdown = freezed,
    Object? premove = freezed,
    Object? zenModeGameSetting = freezed,
    Object? redirectGameId = freezed,
  }) {
    return _then(_value.copyWith(
      game: null == game
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as GameModel,
      stepCursor: null == stepCursor
          ? _value.stepCursor
          : stepCursor // ignore: cast_nullable_to_non_nullable
              as int,
      lastDrawOfferAtPly: freezed == lastDrawOfferAtPly
          ? _value.lastDrawOfferAtPly
          : lastDrawOfferAtPly // ignore: cast_nullable_to_non_nullable
              as int?,
      opponentLeftCountdown: freezed == opponentLeftCountdown
          ? _value.opponentLeftCountdown
          : opponentLeftCountdown // ignore: cast_nullable_to_non_nullable
              as Duration?,
      premove: freezed == premove
          ? _value.premove
          : premove // ignore: cast_nullable_to_non_nullable
              as CGMove?,
      zenModeGameSetting: freezed == zenModeGameSetting
          ? _value.zenModeGameSetting
          : zenModeGameSetting // ignore: cast_nullable_to_non_nullable
              as bool?,
      redirectGameId: freezed == redirectGameId
          ? _value.redirectGameId
          : redirectGameId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GameModelCopyWith<$Res> get game {
    return $GameModelCopyWith<$Res>(_value.game, (value) {
      return _then(_value.copyWith(game: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameStateImplCopyWith(
          _$GameStateImpl value, $Res Function(_$GameStateImpl) then) =
      __$$GameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GameModel game,
      int stepCursor,
      int? lastDrawOfferAtPly,
      Duration? opponentLeftCountdown,
      CGMove? premove,
      bool? zenModeGameSetting,
      String? redirectGameId});

  @override
  $GameModelCopyWith<$Res> get game;
}

/// @nodoc
class __$$GameStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameStateImpl>
    implements _$$GameStateImplCopyWith<$Res> {
  __$$GameStateImplCopyWithImpl(
      _$GameStateImpl _value, $Res Function(_$GameStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? game = null,
    Object? stepCursor = null,
    Object? lastDrawOfferAtPly = freezed,
    Object? opponentLeftCountdown = freezed,
    Object? premove = freezed,
    Object? zenModeGameSetting = freezed,
    Object? redirectGameId = freezed,
  }) {
    return _then(_$GameStateImpl(
      game: null == game
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as GameModel,
      stepCursor: null == stepCursor
          ? _value.stepCursor
          : stepCursor // ignore: cast_nullable_to_non_nullable
              as int,
      lastDrawOfferAtPly: freezed == lastDrawOfferAtPly
          ? _value.lastDrawOfferAtPly
          : lastDrawOfferAtPly // ignore: cast_nullable_to_non_nullable
              as int?,
      opponentLeftCountdown: freezed == opponentLeftCountdown
          ? _value.opponentLeftCountdown
          : opponentLeftCountdown // ignore: cast_nullable_to_non_nullable
              as Duration?,
      premove: freezed == premove
          ? _value.premove
          : premove // ignore: cast_nullable_to_non_nullable
              as CGMove?,
      zenModeGameSetting: freezed == zenModeGameSetting
          ? _value.zenModeGameSetting
          : zenModeGameSetting // ignore: cast_nullable_to_non_nullable
              as bool?,
      redirectGameId: freezed == redirectGameId
          ? _value.redirectGameId
          : redirectGameId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$GameStateImpl extends _GameState {
  const _$GameStateImpl(
      {required this.game,
      required this.stepCursor,
      this.lastDrawOfferAtPly,
      this.opponentLeftCountdown,
      this.premove,
      this.zenModeGameSetting,
      this.redirectGameId})
      : super._();

  @override
  final GameModel game;
  @override
  final int stepCursor;
  @override
  final int? lastDrawOfferAtPly;
  @override
  final Duration? opponentLeftCountdown;
  @override
  final CGMove? premove;

  /// Zen mode setting if account preference is set to [Zen.gameAuto]
  @override
  final bool? zenModeGameSetting;

  /// Game full id used to redirect to the new game of the rematch
  @override
  final String? redirectGameId;

  @override
  String toString() {
    return 'GameState(game: $game, stepCursor: $stepCursor, lastDrawOfferAtPly: $lastDrawOfferAtPly, opponentLeftCountdown: $opponentLeftCountdown, premove: $premove, zenModeGameSetting: $zenModeGameSetting, redirectGameId: $redirectGameId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateImpl &&
            (identical(other.game, game) || other.game == game) &&
            (identical(other.stepCursor, stepCursor) ||
                other.stepCursor == stepCursor) &&
            (identical(other.lastDrawOfferAtPly, lastDrawOfferAtPly) ||
                other.lastDrawOfferAtPly == lastDrawOfferAtPly) &&
            (identical(other.opponentLeftCountdown, opponentLeftCountdown) ||
                other.opponentLeftCountdown == opponentLeftCountdown) &&
            (identical(other.premove, premove) || other.premove == premove) &&
            (identical(other.zenModeGameSetting, zenModeGameSetting) ||
                other.zenModeGameSetting == zenModeGameSetting) &&
            (identical(other.redirectGameId, redirectGameId) ||
                other.redirectGameId == redirectGameId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      game,
      stepCursor,
      lastDrawOfferAtPly,
      opponentLeftCountdown,
      premove,
      zenModeGameSetting,
      redirectGameId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      __$$GameStateImplCopyWithImpl<_$GameStateImpl>(this, _$identity);
}

abstract class _GameState extends GameState {
  const factory _GameState(
      {required final GameModel game,
      required final int stepCursor,
      final int? lastDrawOfferAtPly,
      final Duration? opponentLeftCountdown,
      final CGMove? premove,
      final bool? zenModeGameSetting,
      final String? redirectGameId}) = _$GameStateImpl;
  const _GameState._() : super._();

  @override
  GameModel get game;
  @override
  int get stepCursor;
  @override
  int? get lastDrawOfferAtPly;
  @override
  Duration? get opponentLeftCountdown;
  @override
  CGMove? get premove;
  @override

  /// Zen mode setting if account preference is set to [Zen.gameAuto]
  bool? get zenModeGameSetting;
  @override

  /// Game full id used to redirect to the new game of the rematch
  String? get redirectGameId;
  @override
  @JsonKey(ignore: true)
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
