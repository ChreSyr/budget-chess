// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_indb.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GamePrefs _$GamePrefsFromJson(Map<String, dynamic> json) {
  return _GamePrefs.fromJson(json);
}

/// @nodoc
mixin _$GamePrefs {
  bool get showRatings => throw _privateConstructorUsedError;
  bool get enablePremove => throw _privateConstructorUsedError;
  AutoQueen get autoQueen => throw _privateConstructorUsedError;
  Zen get zenMode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GamePrefsCopyWith<GamePrefs> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GamePrefsCopyWith<$Res> {
  factory $GamePrefsCopyWith(GamePrefs value, $Res Function(GamePrefs) then) =
      _$GamePrefsCopyWithImpl<$Res, GamePrefs>;
  @useResult
  $Res call(
      {bool showRatings, bool enablePremove, AutoQueen autoQueen, Zen zenMode});
}

/// @nodoc
class _$GamePrefsCopyWithImpl<$Res, $Val extends GamePrefs>
    implements $GamePrefsCopyWith<$Res> {
  _$GamePrefsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showRatings = null,
    Object? enablePremove = null,
    Object? autoQueen = null,
    Object? zenMode = null,
  }) {
    return _then(_value.copyWith(
      showRatings: null == showRatings
          ? _value.showRatings
          : showRatings // ignore: cast_nullable_to_non_nullable
              as bool,
      enablePremove: null == enablePremove
          ? _value.enablePremove
          : enablePremove // ignore: cast_nullable_to_non_nullable
              as bool,
      autoQueen: null == autoQueen
          ? _value.autoQueen
          : autoQueen // ignore: cast_nullable_to_non_nullable
              as AutoQueen,
      zenMode: null == zenMode
          ? _value.zenMode
          : zenMode // ignore: cast_nullable_to_non_nullable
              as Zen,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GamePrefsImplCopyWith<$Res>
    implements $GamePrefsCopyWith<$Res> {
  factory _$$GamePrefsImplCopyWith(
          _$GamePrefsImpl value, $Res Function(_$GamePrefsImpl) then) =
      __$$GamePrefsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool showRatings, bool enablePremove, AutoQueen autoQueen, Zen zenMode});
}

/// @nodoc
class __$$GamePrefsImplCopyWithImpl<$Res>
    extends _$GamePrefsCopyWithImpl<$Res, _$GamePrefsImpl>
    implements _$$GamePrefsImplCopyWith<$Res> {
  __$$GamePrefsImplCopyWithImpl(
      _$GamePrefsImpl _value, $Res Function(_$GamePrefsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showRatings = null,
    Object? enablePremove = null,
    Object? autoQueen = null,
    Object? zenMode = null,
  }) {
    return _then(_$GamePrefsImpl(
      showRatings: null == showRatings
          ? _value.showRatings
          : showRatings // ignore: cast_nullable_to_non_nullable
              as bool,
      enablePremove: null == enablePremove
          ? _value.enablePremove
          : enablePremove // ignore: cast_nullable_to_non_nullable
              as bool,
      autoQueen: null == autoQueen
          ? _value.autoQueen
          : autoQueen // ignore: cast_nullable_to_non_nullable
              as AutoQueen,
      zenMode: null == zenMode
          ? _value.zenMode
          : zenMode // ignore: cast_nullable_to_non_nullable
              as Zen,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GamePrefsImpl extends _GamePrefs {
  const _$GamePrefsImpl(
      {required this.showRatings,
      required this.enablePremove,
      required this.autoQueen,
      required this.zenMode})
      : super._();

  factory _$GamePrefsImpl.fromJson(Map<String, dynamic> json) =>
      _$$GamePrefsImplFromJson(json);

  @override
  final bool showRatings;
  @override
  final bool enablePremove;
  @override
  final AutoQueen autoQueen;
  @override
  final Zen zenMode;

  @override
  String toString() {
    return 'GamePrefs(showRatings: $showRatings, enablePremove: $enablePremove, autoQueen: $autoQueen, zenMode: $zenMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GamePrefsImpl &&
            (identical(other.showRatings, showRatings) ||
                other.showRatings == showRatings) &&
            (identical(other.enablePremove, enablePremove) ||
                other.enablePremove == enablePremove) &&
            (identical(other.autoQueen, autoQueen) ||
                other.autoQueen == autoQueen) &&
            (identical(other.zenMode, zenMode) || other.zenMode == zenMode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, showRatings, enablePremove, autoQueen, zenMode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GamePrefsImplCopyWith<_$GamePrefsImpl> get copyWith =>
      __$$GamePrefsImplCopyWithImpl<_$GamePrefsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GamePrefsImplToJson(
      this,
    );
  }
}

abstract class _GamePrefs extends GamePrefs {
  const factory _GamePrefs(
      {required final bool showRatings,
      required final bool enablePremove,
      required final AutoQueen autoQueen,
      required final Zen zenMode}) = _$GamePrefsImpl;
  const _GamePrefs._() : super._();

  factory _GamePrefs.fromJson(Map<String, dynamic> json) =
      _$GamePrefsImpl.fromJson;

  @override
  bool get showRatings;
  @override
  bool get enablePremove;
  @override
  AutoQueen get autoQueen;
  @override
  Zen get zenMode;
  @override
  @JsonKey(ignore: true)
  _$$GamePrefsImplCopyWith<_$GamePrefsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GameStep {
  Position<Position<dynamic>> get position =>
      throw _privateConstructorUsedError;
  SanMove? get sanMove => throw _privateConstructorUsedError;
  MaterialDiff? get diff => throw _privateConstructorUsedError;

  /// The remaining white clock time at this step. Only available when the
  /// game is finished.
  Duration? get archivedWhiteClock => throw _privateConstructorUsedError;

  /// The remaining black clock time at this step. Only available when the
  /// game is finished.
  Duration? get archivedBlackClock => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameStepCopyWith<GameStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStepCopyWith<$Res> {
  factory $GameStepCopyWith(GameStep value, $Res Function(GameStep) then) =
      _$GameStepCopyWithImpl<$Res, GameStep>;
  @useResult
  $Res call(
      {Position<Position<dynamic>> position,
      SanMove? sanMove,
      MaterialDiff? diff,
      Duration? archivedWhiteClock,
      Duration? archivedBlackClock});

  $SanMoveCopyWith<$Res>? get sanMove;
  $MaterialDiffCopyWith<$Res>? get diff;
}

/// @nodoc
class _$GameStepCopyWithImpl<$Res, $Val extends GameStep>
    implements $GameStepCopyWith<$Res> {
  _$GameStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? sanMove = freezed,
    Object? diff = freezed,
    Object? archivedWhiteClock = freezed,
    Object? archivedBlackClock = freezed,
  }) {
    return _then(_value.copyWith(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position<Position<dynamic>>,
      sanMove: freezed == sanMove
          ? _value.sanMove
          : sanMove // ignore: cast_nullable_to_non_nullable
              as SanMove?,
      diff: freezed == diff
          ? _value.diff
          : diff // ignore: cast_nullable_to_non_nullable
              as MaterialDiff?,
      archivedWhiteClock: freezed == archivedWhiteClock
          ? _value.archivedWhiteClock
          : archivedWhiteClock // ignore: cast_nullable_to_non_nullable
              as Duration?,
      archivedBlackClock: freezed == archivedBlackClock
          ? _value.archivedBlackClock
          : archivedBlackClock // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SanMoveCopyWith<$Res>? get sanMove {
    if (_value.sanMove == null) {
      return null;
    }

    return $SanMoveCopyWith<$Res>(_value.sanMove!, (value) {
      return _then(_value.copyWith(sanMove: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MaterialDiffCopyWith<$Res>? get diff {
    if (_value.diff == null) {
      return null;
    }

    return $MaterialDiffCopyWith<$Res>(_value.diff!, (value) {
      return _then(_value.copyWith(diff: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameStepImplCopyWith<$Res>
    implements $GameStepCopyWith<$Res> {
  factory _$$GameStepImplCopyWith(
          _$GameStepImpl value, $Res Function(_$GameStepImpl) then) =
      __$$GameStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Position<Position<dynamic>> position,
      SanMove? sanMove,
      MaterialDiff? diff,
      Duration? archivedWhiteClock,
      Duration? archivedBlackClock});

  @override
  $SanMoveCopyWith<$Res>? get sanMove;
  @override
  $MaterialDiffCopyWith<$Res>? get diff;
}

/// @nodoc
class __$$GameStepImplCopyWithImpl<$Res>
    extends _$GameStepCopyWithImpl<$Res, _$GameStepImpl>
    implements _$$GameStepImplCopyWith<$Res> {
  __$$GameStepImplCopyWithImpl(
      _$GameStepImpl _value, $Res Function(_$GameStepImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? sanMove = freezed,
    Object? diff = freezed,
    Object? archivedWhiteClock = freezed,
    Object? archivedBlackClock = freezed,
  }) {
    return _then(_$GameStepImpl(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position<Position<dynamic>>,
      sanMove: freezed == sanMove
          ? _value.sanMove
          : sanMove // ignore: cast_nullable_to_non_nullable
              as SanMove?,
      diff: freezed == diff
          ? _value.diff
          : diff // ignore: cast_nullable_to_non_nullable
              as MaterialDiff?,
      archivedWhiteClock: freezed == archivedWhiteClock
          ? _value.archivedWhiteClock
          : archivedWhiteClock // ignore: cast_nullable_to_non_nullable
              as Duration?,
      archivedBlackClock: freezed == archivedBlackClock
          ? _value.archivedBlackClock
          : archivedBlackClock // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// @nodoc

class _$GameStepImpl implements _GameStep {
  const _$GameStepImpl(
      {required this.position,
      this.sanMove,
      this.diff,
      this.archivedWhiteClock,
      this.archivedBlackClock});

  @override
  final Position<Position<dynamic>> position;
  @override
  final SanMove? sanMove;
  @override
  final MaterialDiff? diff;

  /// The remaining white clock time at this step. Only available when the
  /// game is finished.
  @override
  final Duration? archivedWhiteClock;

  /// The remaining black clock time at this step. Only available when the
  /// game is finished.
  @override
  final Duration? archivedBlackClock;

  @override
  String toString() {
    return 'GameStep(position: $position, sanMove: $sanMove, diff: $diff, archivedWhiteClock: $archivedWhiteClock, archivedBlackClock: $archivedBlackClock)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStepImpl &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.sanMove, sanMove) || other.sanMove == sanMove) &&
            (identical(other.diff, diff) || other.diff == diff) &&
            (identical(other.archivedWhiteClock, archivedWhiteClock) ||
                other.archivedWhiteClock == archivedWhiteClock) &&
            (identical(other.archivedBlackClock, archivedBlackClock) ||
                other.archivedBlackClock == archivedBlackClock));
  }

  @override
  int get hashCode => Object.hash(runtimeType, position, sanMove, diff,
      archivedWhiteClock, archivedBlackClock);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStepImplCopyWith<_$GameStepImpl> get copyWith =>
      __$$GameStepImplCopyWithImpl<_$GameStepImpl>(this, _$identity);
}

abstract class _GameStep implements GameStep {
  const factory _GameStep(
      {required final Position<Position<dynamic>> position,
      final SanMove? sanMove,
      final MaterialDiff? diff,
      final Duration? archivedWhiteClock,
      final Duration? archivedBlackClock}) = _$GameStepImpl;

  @override
  Position<Position<dynamic>> get position;
  @override
  SanMove? get sanMove;
  @override
  MaterialDiff? get diff;
  @override

  /// The remaining white clock time at this step. Only available when the
  /// game is finished.
  Duration? get archivedWhiteClock;
  @override

  /// The remaining black clock time at this step. Only available when the
  /// game is finished.
  Duration? get archivedBlackClock;
  @override
  @JsonKey(ignore: true)
  _$$GameStepImplCopyWith<_$GameStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GameInDB _$GameInDBFromJson(Map<String, dynamic> json) {
  return _GameInDB.fromJson(json);
}

/// @nodoc
mixin _$GameInDB {
  String? get id => throw _privateConstructorUsedError;
  @ChallengeModelConverter()
  ChallengeModel? get challenge => throw _privateConstructorUsedError;
  String? get blackId => throw _privateConstructorUsedError;
  String? get whiteId => throw _privateConstructorUsedError;
  GameStatus? get status => throw _privateConstructorUsedError;

  /// Starting position of black pieces.
  /// null means black is seting up its pieces.
  String? get blackSetupFen => throw _privateConstructorUsedError;

  /// Starting position of white pieces.
  /// null means white is seting up its pieces.
  String? get whiteSetupFen => throw _privateConstructorUsedError;
  String? get sanMoves =>
      throw _privateConstructorUsedError; // san moves separated by ' '
  Side? get winner =>
      throw _privateConstructorUsedError; // if status is ended & winner is null : draw
  @GamePrefsConverter()
  GamePrefs? get prefs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameInDBCopyWith<GameInDB> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameInDBCopyWith<$Res> {
  factory $GameInDBCopyWith(GameInDB value, $Res Function(GameInDB) then) =
      _$GameInDBCopyWithImpl<$Res, GameInDB>;
  @useResult
  $Res call(
      {String? id,
      @ChallengeModelConverter() ChallengeModel? challenge,
      String? blackId,
      String? whiteId,
      GameStatus? status,
      String? blackSetupFen,
      String? whiteSetupFen,
      String? sanMoves,
      Side? winner,
      @GamePrefsConverter() GamePrefs? prefs});

  $ChallengeModelCopyWith<$Res>? get challenge;
  $GamePrefsCopyWith<$Res>? get prefs;
}

/// @nodoc
class _$GameInDBCopyWithImpl<$Res, $Val extends GameInDB>
    implements $GameInDBCopyWith<$Res> {
  _$GameInDBCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? challenge = freezed,
    Object? blackId = freezed,
    Object? whiteId = freezed,
    Object? status = freezed,
    Object? blackSetupFen = freezed,
    Object? whiteSetupFen = freezed,
    Object? sanMoves = freezed,
    Object? winner = freezed,
    Object? prefs = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      challenge: freezed == challenge
          ? _value.challenge
          : challenge // ignore: cast_nullable_to_non_nullable
              as ChallengeModel?,
      blackId: freezed == blackId
          ? _value.blackId
          : blackId // ignore: cast_nullable_to_non_nullable
              as String?,
      whiteId: freezed == whiteId
          ? _value.whiteId
          : whiteId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus?,
      blackSetupFen: freezed == blackSetupFen
          ? _value.blackSetupFen
          : blackSetupFen // ignore: cast_nullable_to_non_nullable
              as String?,
      whiteSetupFen: freezed == whiteSetupFen
          ? _value.whiteSetupFen
          : whiteSetupFen // ignore: cast_nullable_to_non_nullable
              as String?,
      sanMoves: freezed == sanMoves
          ? _value.sanMoves
          : sanMoves // ignore: cast_nullable_to_non_nullable
              as String?,
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
  $ChallengeModelCopyWith<$Res>? get challenge {
    if (_value.challenge == null) {
      return null;
    }

    return $ChallengeModelCopyWith<$Res>(_value.challenge!, (value) {
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
abstract class _$$GameInDBImplCopyWith<$Res>
    implements $GameInDBCopyWith<$Res> {
  factory _$$GameInDBImplCopyWith(
          _$GameInDBImpl value, $Res Function(_$GameInDBImpl) then) =
      __$$GameInDBImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      @ChallengeModelConverter() ChallengeModel? challenge,
      String? blackId,
      String? whiteId,
      GameStatus? status,
      String? blackSetupFen,
      String? whiteSetupFen,
      String? sanMoves,
      Side? winner,
      @GamePrefsConverter() GamePrefs? prefs});

  @override
  $ChallengeModelCopyWith<$Res>? get challenge;
  @override
  $GamePrefsCopyWith<$Res>? get prefs;
}

/// @nodoc
class __$$GameInDBImplCopyWithImpl<$Res>
    extends _$GameInDBCopyWithImpl<$Res, _$GameInDBImpl>
    implements _$$GameInDBImplCopyWith<$Res> {
  __$$GameInDBImplCopyWithImpl(
      _$GameInDBImpl _value, $Res Function(_$GameInDBImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? challenge = freezed,
    Object? blackId = freezed,
    Object? whiteId = freezed,
    Object? status = freezed,
    Object? blackSetupFen = freezed,
    Object? whiteSetupFen = freezed,
    Object? sanMoves = freezed,
    Object? winner = freezed,
    Object? prefs = freezed,
  }) {
    return _then(_$GameInDBImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      challenge: freezed == challenge
          ? _value.challenge
          : challenge // ignore: cast_nullable_to_non_nullable
              as ChallengeModel?,
      blackId: freezed == blackId
          ? _value.blackId
          : blackId // ignore: cast_nullable_to_non_nullable
              as String?,
      whiteId: freezed == whiteId
          ? _value.whiteId
          : whiteId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus?,
      blackSetupFen: freezed == blackSetupFen
          ? _value.blackSetupFen
          : blackSetupFen // ignore: cast_nullable_to_non_nullable
              as String?,
      whiteSetupFen: freezed == whiteSetupFen
          ? _value.whiteSetupFen
          : whiteSetupFen // ignore: cast_nullable_to_non_nullable
              as String?,
      sanMoves: freezed == sanMoves
          ? _value.sanMoves
          : sanMoves // ignore: cast_nullable_to_non_nullable
              as String?,
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
@JsonSerializable()
class _$GameInDBImpl extends _GameInDB {
  const _$GameInDBImpl(
      {this.id,
      @ChallengeModelConverter() this.challenge,
      this.blackId,
      this.whiteId,
      this.status,
      this.blackSetupFen,
      this.whiteSetupFen,
      this.sanMoves,
      this.winner,
      @GamePrefsConverter() this.prefs})
      : super._();

  factory _$GameInDBImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameInDBImplFromJson(json);

  @override
  final String? id;
  @override
  @ChallengeModelConverter()
  final ChallengeModel? challenge;
  @override
  final String? blackId;
  @override
  final String? whiteId;
  @override
  final GameStatus? status;

  /// Starting position of black pieces.
  /// null means black is seting up its pieces.
  @override
  final String? blackSetupFen;

  /// Starting position of white pieces.
  /// null means white is seting up its pieces.
  @override
  final String? whiteSetupFen;
  @override
  final String? sanMoves;
// san moves separated by ' '
  @override
  final Side? winner;
// if status is ended & winner is null : draw
  @override
  @GamePrefsConverter()
  final GamePrefs? prefs;

  @override
  String toString() {
    return 'GameInDB(id: $id, challenge: $challenge, blackId: $blackId, whiteId: $whiteId, status: $status, blackSetupFen: $blackSetupFen, whiteSetupFen: $whiteSetupFen, sanMoves: $sanMoves, winner: $winner, prefs: $prefs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameInDBImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.challenge, challenge) ||
                other.challenge == challenge) &&
            (identical(other.blackId, blackId) || other.blackId == blackId) &&
            (identical(other.whiteId, whiteId) || other.whiteId == whiteId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.blackSetupFen, blackSetupFen) ||
                other.blackSetupFen == blackSetupFen) &&
            (identical(other.whiteSetupFen, whiteSetupFen) ||
                other.whiteSetupFen == whiteSetupFen) &&
            (identical(other.sanMoves, sanMoves) ||
                other.sanMoves == sanMoves) &&
            (identical(other.winner, winner) || other.winner == winner) &&
            (identical(other.prefs, prefs) || other.prefs == prefs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, challenge, blackId, whiteId,
      status, blackSetupFen, whiteSetupFen, sanMoves, winner, prefs);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameInDBImplCopyWith<_$GameInDBImpl> get copyWith =>
      __$$GameInDBImplCopyWithImpl<_$GameInDBImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameInDBImplToJson(
      this,
    );
  }
}

abstract class _GameInDB extends GameInDB {
  const factory _GameInDB(
      {final String? id,
      @ChallengeModelConverter() final ChallengeModel? challenge,
      final String? blackId,
      final String? whiteId,
      final GameStatus? status,
      final String? blackSetupFen,
      final String? whiteSetupFen,
      final String? sanMoves,
      final Side? winner,
      @GamePrefsConverter() final GamePrefs? prefs}) = _$GameInDBImpl;
  const _GameInDB._() : super._();

  factory _GameInDB.fromJson(Map<String, dynamic> json) =
      _$GameInDBImpl.fromJson;

  @override
  String? get id;
  @override
  @ChallengeModelConverter()
  ChallengeModel? get challenge;
  @override
  String? get blackId;
  @override
  String? get whiteId;
  @override
  GameStatus? get status;
  @override

  /// Starting position of black pieces.
  /// null means black is seting up its pieces.
  String? get blackSetupFen;
  @override

  /// Starting position of white pieces.
  /// null means white is seting up its pieces.
  String? get whiteSetupFen;
  @override
  String? get sanMoves;
  @override // san moves separated by ' '
  Side? get winner;
  @override // if status is ended & winner is null : draw
  @GamePrefsConverter()
  GamePrefs? get prefs;
  @override
  @JsonKey(ignore: true)
  _$$GameInDBImplCopyWith<_$GameInDBImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
