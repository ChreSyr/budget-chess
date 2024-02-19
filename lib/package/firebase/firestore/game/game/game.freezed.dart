// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SanMove _$SanMoveFromJson(Map<String, dynamic> json) {
  return _SanMove.fromJson(json);
}

/// @nodoc
mixin _$SanMove {
  String get san => throw _privateConstructorUsedError;
  @MoveConverter()
  Move get move => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SanMoveCopyWith<SanMove> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SanMoveCopyWith<$Res> {
  factory $SanMoveCopyWith(SanMove value, $Res Function(SanMove) then) =
      _$SanMoveCopyWithImpl<$Res, SanMove>;
  @useResult
  $Res call({String san, @MoveConverter() Move move});
}

/// @nodoc
class _$SanMoveCopyWithImpl<$Res, $Val extends SanMove>
    implements $SanMoveCopyWith<$Res> {
  _$SanMoveCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? san = null,
    Object? move = null,
  }) {
    return _then(_value.copyWith(
      san: null == san
          ? _value.san
          : san // ignore: cast_nullable_to_non_nullable
              as String,
      move: null == move
          ? _value.move
          : move // ignore: cast_nullable_to_non_nullable
              as Move,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SanMoveImplCopyWith<$Res> implements $SanMoveCopyWith<$Res> {
  factory _$$SanMoveImplCopyWith(
          _$SanMoveImpl value, $Res Function(_$SanMoveImpl) then) =
      __$$SanMoveImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String san, @MoveConverter() Move move});
}

/// @nodoc
class __$$SanMoveImplCopyWithImpl<$Res>
    extends _$SanMoveCopyWithImpl<$Res, _$SanMoveImpl>
    implements _$$SanMoveImplCopyWith<$Res> {
  __$$SanMoveImplCopyWithImpl(
      _$SanMoveImpl _value, $Res Function(_$SanMoveImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? san = null,
    Object? move = null,
  }) {
    return _then(_$SanMoveImpl(
      null == san
          ? _value.san
          : san // ignore: cast_nullable_to_non_nullable
              as String,
      null == move
          ? _value.move
          : move // ignore: cast_nullable_to_non_nullable
              as Move,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SanMoveImpl extends _SanMove {
  const _$SanMoveImpl(this.san, @MoveConverter() this.move) : super._();

  factory _$SanMoveImpl.fromJson(Map<String, dynamic> json) =>
      _$$SanMoveImplFromJson(json);

  @override
  final String san;
  @override
  @MoveConverter()
  final Move move;

  @override
  String toString() {
    return 'SanMove(san: $san, move: $move)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SanMoveImpl &&
            (identical(other.san, san) || other.san == san) &&
            (identical(other.move, move) || other.move == move));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, san, move);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SanMoveImplCopyWith<_$SanMoveImpl> get copyWith =>
      __$$SanMoveImplCopyWithImpl<_$SanMoveImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SanMoveImplToJson(
      this,
    );
  }
}

abstract class _SanMove extends SanMove {
  const factory _SanMove(final String san, @MoveConverter() final Move move) =
      _$SanMoveImpl;
  const _SanMove._() : super._();

  factory _SanMove.fromJson(Map<String, dynamic> json) = _$SanMoveImpl.fromJson;

  @override
  String get san;
  @override
  @MoveConverter()
  Move get move;
  @override
  @JsonKey(ignore: true)
  _$$SanMoveImplCopyWith<_$SanMoveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MaterialDiffSide {
  IMap<Role, int> get pieces => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MaterialDiffSideCopyWith<MaterialDiffSide> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MaterialDiffSideCopyWith<$Res> {
  factory $MaterialDiffSideCopyWith(
          MaterialDiffSide value, $Res Function(MaterialDiffSide) then) =
      _$MaterialDiffSideCopyWithImpl<$Res, MaterialDiffSide>;
  @useResult
  $Res call({IMap<Role, int> pieces, int score});
}

/// @nodoc
class _$MaterialDiffSideCopyWithImpl<$Res, $Val extends MaterialDiffSide>
    implements $MaterialDiffSideCopyWith<$Res> {
  _$MaterialDiffSideCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pieces = null,
    Object? score = null,
  }) {
    return _then(_value.copyWith(
      pieces: null == pieces
          ? _value.pieces
          : pieces // ignore: cast_nullable_to_non_nullable
              as IMap<Role, int>,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MaterialDiffSideImplCopyWith<$Res>
    implements $MaterialDiffSideCopyWith<$Res> {
  factory _$$MaterialDiffSideImplCopyWith(_$MaterialDiffSideImpl value,
          $Res Function(_$MaterialDiffSideImpl) then) =
      __$$MaterialDiffSideImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({IMap<Role, int> pieces, int score});
}

/// @nodoc
class __$$MaterialDiffSideImplCopyWithImpl<$Res>
    extends _$MaterialDiffSideCopyWithImpl<$Res, _$MaterialDiffSideImpl>
    implements _$$MaterialDiffSideImplCopyWith<$Res> {
  __$$MaterialDiffSideImplCopyWithImpl(_$MaterialDiffSideImpl _value,
      $Res Function(_$MaterialDiffSideImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pieces = null,
    Object? score = null,
  }) {
    return _then(_$MaterialDiffSideImpl(
      pieces: null == pieces
          ? _value.pieces
          : pieces // ignore: cast_nullable_to_non_nullable
              as IMap<Role, int>,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$MaterialDiffSideImpl implements _MaterialDiffSide {
  const _$MaterialDiffSideImpl({required this.pieces, required this.score});

  @override
  final IMap<Role, int> pieces;
  @override
  final int score;

  @override
  String toString() {
    return 'MaterialDiffSide(pieces: $pieces, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MaterialDiffSideImpl &&
            (identical(other.pieces, pieces) || other.pieces == pieces) &&
            (identical(other.score, score) || other.score == score));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pieces, score);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MaterialDiffSideImplCopyWith<_$MaterialDiffSideImpl> get copyWith =>
      __$$MaterialDiffSideImplCopyWithImpl<_$MaterialDiffSideImpl>(
          this, _$identity);
}

abstract class _MaterialDiffSide implements MaterialDiffSide {
  const factory _MaterialDiffSide(
      {required final IMap<Role, int> pieces,
      required final int score}) = _$MaterialDiffSideImpl;

  @override
  IMap<Role, int> get pieces;
  @override
  int get score;
  @override
  @JsonKey(ignore: true)
  _$$MaterialDiffSideImplCopyWith<_$MaterialDiffSideImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MaterialDiff {
  MaterialDiffSide get black => throw _privateConstructorUsedError;
  MaterialDiffSide get white => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MaterialDiffCopyWith<MaterialDiff> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MaterialDiffCopyWith<$Res> {
  factory $MaterialDiffCopyWith(
          MaterialDiff value, $Res Function(MaterialDiff) then) =
      _$MaterialDiffCopyWithImpl<$Res, MaterialDiff>;
  @useResult
  $Res call({MaterialDiffSide black, MaterialDiffSide white});

  $MaterialDiffSideCopyWith<$Res> get black;
  $MaterialDiffSideCopyWith<$Res> get white;
}

/// @nodoc
class _$MaterialDiffCopyWithImpl<$Res, $Val extends MaterialDiff>
    implements $MaterialDiffCopyWith<$Res> {
  _$MaterialDiffCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? black = null,
    Object? white = null,
  }) {
    return _then(_value.copyWith(
      black: null == black
          ? _value.black
          : black // ignore: cast_nullable_to_non_nullable
              as MaterialDiffSide,
      white: null == white
          ? _value.white
          : white // ignore: cast_nullable_to_non_nullable
              as MaterialDiffSide,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MaterialDiffSideCopyWith<$Res> get black {
    return $MaterialDiffSideCopyWith<$Res>(_value.black, (value) {
      return _then(_value.copyWith(black: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MaterialDiffSideCopyWith<$Res> get white {
    return $MaterialDiffSideCopyWith<$Res>(_value.white, (value) {
      return _then(_value.copyWith(white: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MaterialDiffImplCopyWith<$Res>
    implements $MaterialDiffCopyWith<$Res> {
  factory _$$MaterialDiffImplCopyWith(
          _$MaterialDiffImpl value, $Res Function(_$MaterialDiffImpl) then) =
      __$$MaterialDiffImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MaterialDiffSide black, MaterialDiffSide white});

  @override
  $MaterialDiffSideCopyWith<$Res> get black;
  @override
  $MaterialDiffSideCopyWith<$Res> get white;
}

/// @nodoc
class __$$MaterialDiffImplCopyWithImpl<$Res>
    extends _$MaterialDiffCopyWithImpl<$Res, _$MaterialDiffImpl>
    implements _$$MaterialDiffImplCopyWith<$Res> {
  __$$MaterialDiffImplCopyWithImpl(
      _$MaterialDiffImpl _value, $Res Function(_$MaterialDiffImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? black = null,
    Object? white = null,
  }) {
    return _then(_$MaterialDiffImpl(
      black: null == black
          ? _value.black
          : black // ignore: cast_nullable_to_non_nullable
              as MaterialDiffSide,
      white: null == white
          ? _value.white
          : white // ignore: cast_nullable_to_non_nullable
              as MaterialDiffSide,
    ));
  }
}

/// @nodoc

class _$MaterialDiffImpl extends _MaterialDiff {
  const _$MaterialDiffImpl({required this.black, required this.white})
      : super._();

  @override
  final MaterialDiffSide black;
  @override
  final MaterialDiffSide white;

  @override
  String toString() {
    return 'MaterialDiff(black: $black, white: $white)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MaterialDiffImpl &&
            (identical(other.black, black) || other.black == black) &&
            (identical(other.white, white) || other.white == white));
  }

  @override
  int get hashCode => Object.hash(runtimeType, black, white);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MaterialDiffImplCopyWith<_$MaterialDiffImpl> get copyWith =>
      __$$MaterialDiffImplCopyWithImpl<_$MaterialDiffImpl>(this, _$identity);
}

abstract class _MaterialDiff extends MaterialDiff {
  const factory _MaterialDiff(
      {required final MaterialDiffSide black,
      required final MaterialDiffSide white}) = _$MaterialDiffImpl;
  const _MaterialDiff._() : super._();

  @override
  MaterialDiffSide get black;
  @override
  MaterialDiffSide get white;
  @override
  @JsonKey(ignore: true)
  _$$MaterialDiffImplCopyWith<_$MaterialDiffImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PlayableGameMeta {
  bool get rated => throw _privateConstructorUsedError;
  Rule get rule => throw _privateConstructorUsedError;
  Speed get speed => throw _privateConstructorUsedError;
  Perf get perf => throw _privateConstructorUsedError;
  GameSource get source => throw _privateConstructorUsedError;
  ({
    Duration? emergency,
    Duration increment,
    Duration initial,
    Duration? moreTime
  })? get clock => throw _privateConstructorUsedError;
  int? get daysPerTurn => throw _privateConstructorUsedError;
  int? get startedAtTurn => throw _privateConstructorUsedError;
  ISet<GameRule>? get rules => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayableGameMetaCopyWith<PlayableGameMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayableGameMetaCopyWith<$Res> {
  factory $PlayableGameMetaCopyWith(
          PlayableGameMeta value, $Res Function(PlayableGameMeta) then) =
      _$PlayableGameMetaCopyWithImpl<$Res, PlayableGameMeta>;
  @useResult
  $Res call(
      {bool rated,
      Rule rule,
      Speed speed,
      Perf perf,
      GameSource source,
      ({
        Duration? emergency,
        Duration increment,
        Duration initial,
        Duration? moreTime
      })? clock,
      int? daysPerTurn,
      int? startedAtTurn,
      ISet<GameRule>? rules});
}

/// @nodoc
class _$PlayableGameMetaCopyWithImpl<$Res, $Val extends PlayableGameMeta>
    implements $PlayableGameMetaCopyWith<$Res> {
  _$PlayableGameMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rated = null,
    Object? rule = null,
    Object? speed = null,
    Object? perf = null,
    Object? source = null,
    Object? clock = freezed,
    Object? daysPerTurn = freezed,
    Object? startedAtTurn = freezed,
    Object? rules = freezed,
  }) {
    return _then(_value.copyWith(
      rated: null == rated
          ? _value.rated
          : rated // ignore: cast_nullable_to_non_nullable
              as bool,
      rule: null == rule
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as Rule,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as Speed,
      perf: null == perf
          ? _value.perf
          : perf // ignore: cast_nullable_to_non_nullable
              as Perf,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as GameSource,
      clock: freezed == clock
          ? _value.clock
          : clock // ignore: cast_nullable_to_non_nullable
              as ({
              Duration? emergency,
              Duration increment,
              Duration initial,
              Duration? moreTime
            })?,
      daysPerTurn: freezed == daysPerTurn
          ? _value.daysPerTurn
          : daysPerTurn // ignore: cast_nullable_to_non_nullable
              as int?,
      startedAtTurn: freezed == startedAtTurn
          ? _value.startedAtTurn
          : startedAtTurn // ignore: cast_nullable_to_non_nullable
              as int?,
      rules: freezed == rules
          ? _value.rules
          : rules // ignore: cast_nullable_to_non_nullable
              as ISet<GameRule>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayableGameMetaImplCopyWith<$Res>
    implements $PlayableGameMetaCopyWith<$Res> {
  factory _$$PlayableGameMetaImplCopyWith(_$PlayableGameMetaImpl value,
          $Res Function(_$PlayableGameMetaImpl) then) =
      __$$PlayableGameMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool rated,
      Rule rule,
      Speed speed,
      Perf perf,
      GameSource source,
      ({
        Duration? emergency,
        Duration increment,
        Duration initial,
        Duration? moreTime
      })? clock,
      int? daysPerTurn,
      int? startedAtTurn,
      ISet<GameRule>? rules});
}

/// @nodoc
class __$$PlayableGameMetaImplCopyWithImpl<$Res>
    extends _$PlayableGameMetaCopyWithImpl<$Res, _$PlayableGameMetaImpl>
    implements _$$PlayableGameMetaImplCopyWith<$Res> {
  __$$PlayableGameMetaImplCopyWithImpl(_$PlayableGameMetaImpl _value,
      $Res Function(_$PlayableGameMetaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rated = null,
    Object? rule = null,
    Object? speed = null,
    Object? perf = null,
    Object? source = null,
    Object? clock = freezed,
    Object? daysPerTurn = freezed,
    Object? startedAtTurn = freezed,
    Object? rules = freezed,
  }) {
    return _then(_$PlayableGameMetaImpl(
      rated: null == rated
          ? _value.rated
          : rated // ignore: cast_nullable_to_non_nullable
              as bool,
      rule: null == rule
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as Rule,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as Speed,
      perf: null == perf
          ? _value.perf
          : perf // ignore: cast_nullable_to_non_nullable
              as Perf,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as GameSource,
      clock: freezed == clock
          ? _value.clock
          : clock // ignore: cast_nullable_to_non_nullable
              as ({
              Duration? emergency,
              Duration increment,
              Duration initial,
              Duration? moreTime
            })?,
      daysPerTurn: freezed == daysPerTurn
          ? _value.daysPerTurn
          : daysPerTurn // ignore: cast_nullable_to_non_nullable
              as int?,
      startedAtTurn: freezed == startedAtTurn
          ? _value.startedAtTurn
          : startedAtTurn // ignore: cast_nullable_to_non_nullable
              as int?,
      rules: freezed == rules
          ? _value.rules
          : rules // ignore: cast_nullable_to_non_nullable
              as ISet<GameRule>?,
    ));
  }
}

/// @nodoc

class _$PlayableGameMetaImpl extends _PlayableGameMeta {
  const _$PlayableGameMetaImpl(
      {required this.rated,
      required this.rule,
      required this.speed,
      required this.perf,
      required this.source,
      this.clock,
      this.daysPerTurn,
      this.startedAtTurn,
      this.rules})
      : assert(!(clock != null && daysPerTurn != null)),
        super._();

  @override
  final bool rated;
  @override
  final Rule rule;
  @override
  final Speed speed;
  @override
  final Perf perf;
  @override
  final GameSource source;
  @override
  final ({
    Duration? emergency,
    Duration increment,
    Duration initial,
    Duration? moreTime
  })? clock;
  @override
  final int? daysPerTurn;
  @override
  final int? startedAtTurn;
  @override
  final ISet<GameRule>? rules;

  @override
  String toString() {
    return 'PlayableGameMeta(rated: $rated, rule: $rule, speed: $speed, perf: $perf, source: $source, clock: $clock, daysPerTurn: $daysPerTurn, startedAtTurn: $startedAtTurn, rules: $rules)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayableGameMetaImpl &&
            (identical(other.rated, rated) || other.rated == rated) &&
            (identical(other.rule, rule) || other.rule == rule) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.perf, perf) || other.perf == perf) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.clock, clock) || other.clock == clock) &&
            (identical(other.daysPerTurn, daysPerTurn) ||
                other.daysPerTurn == daysPerTurn) &&
            (identical(other.startedAtTurn, startedAtTurn) ||
                other.startedAtTurn == startedAtTurn) &&
            const DeepCollectionEquality().equals(other.rules, rules));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      rated,
      rule,
      speed,
      perf,
      source,
      clock,
      daysPerTurn,
      startedAtTurn,
      const DeepCollectionEquality().hash(rules));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayableGameMetaImplCopyWith<_$PlayableGameMetaImpl> get copyWith =>
      __$$PlayableGameMetaImplCopyWithImpl<_$PlayableGameMetaImpl>(
          this, _$identity);
}

abstract class _PlayableGameMeta extends PlayableGameMeta {
  const factory _PlayableGameMeta(
      {required final bool rated,
      required final Rule rule,
      required final Speed speed,
      required final Perf perf,
      required final GameSource source,
      final ({
        Duration? emergency,
        Duration increment,
        Duration initial,
        Duration? moreTime
      })? clock,
      final int? daysPerTurn,
      final int? startedAtTurn,
      final ISet<GameRule>? rules}) = _$PlayableGameMetaImpl;
  const _PlayableGameMeta._() : super._();

  @override
  bool get rated;
  @override
  Rule get rule;
  @override
  Speed get speed;
  @override
  Perf get perf;
  @override
  GameSource get source;
  @override
  ({
    Duration? emergency,
    Duration increment,
    Duration initial,
    Duration? moreTime
  })? get clock;
  @override
  int? get daysPerTurn;
  @override
  int? get startedAtTurn;
  @override
  ISet<GameRule>? get rules;
  @override
  @JsonKey(ignore: true)
  _$$PlayableGameMetaImplCopyWith<_$PlayableGameMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PlayableClockData {
  bool get running => throw _privateConstructorUsedError;
  Duration get white => throw _privateConstructorUsedError;
  Duration get black => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayableClockDataCopyWith<PlayableClockData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayableClockDataCopyWith<$Res> {
  factory $PlayableClockDataCopyWith(
          PlayableClockData value, $Res Function(PlayableClockData) then) =
      _$PlayableClockDataCopyWithImpl<$Res, PlayableClockData>;
  @useResult
  $Res call({bool running, Duration white, Duration black});
}

/// @nodoc
class _$PlayableClockDataCopyWithImpl<$Res, $Val extends PlayableClockData>
    implements $PlayableClockDataCopyWith<$Res> {
  _$PlayableClockDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? running = null,
    Object? white = null,
    Object? black = null,
  }) {
    return _then(_value.copyWith(
      running: null == running
          ? _value.running
          : running // ignore: cast_nullable_to_non_nullable
              as bool,
      white: null == white
          ? _value.white
          : white // ignore: cast_nullable_to_non_nullable
              as Duration,
      black: null == black
          ? _value.black
          : black // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayableClockDataImplCopyWith<$Res>
    implements $PlayableClockDataCopyWith<$Res> {
  factory _$$PlayableClockDataImplCopyWith(_$PlayableClockDataImpl value,
          $Res Function(_$PlayableClockDataImpl) then) =
      __$$PlayableClockDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool running, Duration white, Duration black});
}

/// @nodoc
class __$$PlayableClockDataImplCopyWithImpl<$Res>
    extends _$PlayableClockDataCopyWithImpl<$Res, _$PlayableClockDataImpl>
    implements _$$PlayableClockDataImplCopyWith<$Res> {
  __$$PlayableClockDataImplCopyWithImpl(_$PlayableClockDataImpl _value,
      $Res Function(_$PlayableClockDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? running = null,
    Object? white = null,
    Object? black = null,
  }) {
    return _then(_$PlayableClockDataImpl(
      running: null == running
          ? _value.running
          : running // ignore: cast_nullable_to_non_nullable
              as bool,
      white: null == white
          ? _value.white
          : white // ignore: cast_nullable_to_non_nullable
              as Duration,
      black: null == black
          ? _value.black
          : black // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

class _$PlayableClockDataImpl implements _PlayableClockData {
  const _$PlayableClockDataImpl(
      {required this.running, required this.white, required this.black});

  @override
  final bool running;
  @override
  final Duration white;
  @override
  final Duration black;

  @override
  String toString() {
    return 'PlayableClockData(running: $running, white: $white, black: $black)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayableClockDataImpl &&
            (identical(other.running, running) || other.running == running) &&
            (identical(other.white, white) || other.white == white) &&
            (identical(other.black, black) || other.black == black));
  }

  @override
  int get hashCode => Object.hash(runtimeType, running, white, black);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayableClockDataImplCopyWith<_$PlayableClockDataImpl> get copyWith =>
      __$$PlayableClockDataImplCopyWithImpl<_$PlayableClockDataImpl>(
          this, _$identity);
}

abstract class _PlayableClockData implements PlayableClockData {
  const factory _PlayableClockData(
      {required final bool running,
      required final Duration white,
      required final Duration black}) = _$PlayableClockDataImpl;

  @override
  bool get running;
  @override
  Duration get white;
  @override
  Duration get black;
  @override
  @JsonKey(ignore: true)
  _$$PlayableClockDataImplCopyWith<_$PlayableClockDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PlayableGame {
  String get id => throw _privateConstructorUsedError;
  PlayableGameMeta get meta => throw _privateConstructorUsedError;
  IList<GameStep> get steps => throw _privateConstructorUsedError;
  GameStatus get status => throw _privateConstructorUsedError;
  Rule get rule => throw _privateConstructorUsedError;
  Speed get speed => throw _privateConstructorUsedError;
  Perf get perf => throw _privateConstructorUsedError;
  Player get white => throw _privateConstructorUsedError;
  Player get black => throw _privateConstructorUsedError;
  bool get moretimeable => throw _privateConstructorUsedError;
  bool get takebackable => throw _privateConstructorUsedError;
  String? get initialFen => throw _privateConstructorUsedError;
  Side? get winner => throw _privateConstructorUsedError;

  /// The side that the current player is playing as. This is null if viewing
  /// the game as a spectator.
  Side? get youAre => throw _privateConstructorUsedError;
  GamePrefs? get prefs => throw _privateConstructorUsedError;
  PlayableClockData? get clock => throw _privateConstructorUsedError;
  bool? get boosted => throw _privateConstructorUsedError;
  bool? get isThreefoldRepetition => throw _privateConstructorUsedError;
  ({Duration idle, DateTime movedAt, Duration timeToMove})? get expiration =>
      throw _privateConstructorUsedError;

  /// The game id of the next game if a rematch has been accepted.
  String? get rematch => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayableGameCopyWith<PlayableGame> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayableGameCopyWith<$Res> {
  factory $PlayableGameCopyWith(
          PlayableGame value, $Res Function(PlayableGame) then) =
      _$PlayableGameCopyWithImpl<$Res, PlayableGame>;
  @useResult
  $Res call(
      {String id,
      PlayableGameMeta meta,
      IList<GameStep> steps,
      GameStatus status,
      Rule rule,
      Speed speed,
      Perf perf,
      Player white,
      Player black,
      bool moretimeable,
      bool takebackable,
      String? initialFen,
      Side? winner,
      Side? youAre,
      GamePrefs? prefs,
      PlayableClockData? clock,
      bool? boosted,
      bool? isThreefoldRepetition,
      ({Duration idle, DateTime movedAt, Duration timeToMove})? expiration,
      String? rematch});

  $PlayableGameMetaCopyWith<$Res> get meta;
  $PlayerCopyWith<$Res> get white;
  $PlayerCopyWith<$Res> get black;
  $GamePrefsCopyWith<$Res>? get prefs;
  $PlayableClockDataCopyWith<$Res>? get clock;
}

/// @nodoc
class _$PlayableGameCopyWithImpl<$Res, $Val extends PlayableGame>
    implements $PlayableGameCopyWith<$Res> {
  _$PlayableGameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? meta = null,
    Object? steps = null,
    Object? status = null,
    Object? rule = null,
    Object? speed = null,
    Object? perf = null,
    Object? white = null,
    Object? black = null,
    Object? moretimeable = null,
    Object? takebackable = null,
    Object? initialFen = freezed,
    Object? winner = freezed,
    Object? youAre = freezed,
    Object? prefs = freezed,
    Object? clock = freezed,
    Object? boosted = freezed,
    Object? isThreefoldRepetition = freezed,
    Object? expiration = freezed,
    Object? rematch = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      meta: null == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as PlayableGameMeta,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as IList<GameStep>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      rule: null == rule
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as Rule,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as Speed,
      perf: null == perf
          ? _value.perf
          : perf // ignore: cast_nullable_to_non_nullable
              as Perf,
      white: null == white
          ? _value.white
          : white // ignore: cast_nullable_to_non_nullable
              as Player,
      black: null == black
          ? _value.black
          : black // ignore: cast_nullable_to_non_nullable
              as Player,
      moretimeable: null == moretimeable
          ? _value.moretimeable
          : moretimeable // ignore: cast_nullable_to_non_nullable
              as bool,
      takebackable: null == takebackable
          ? _value.takebackable
          : takebackable // ignore: cast_nullable_to_non_nullable
              as bool,
      initialFen: freezed == initialFen
          ? _value.initialFen
          : initialFen // ignore: cast_nullable_to_non_nullable
              as String?,
      winner: freezed == winner
          ? _value.winner
          : winner // ignore: cast_nullable_to_non_nullable
              as Side?,
      youAre: freezed == youAre
          ? _value.youAre
          : youAre // ignore: cast_nullable_to_non_nullable
              as Side?,
      prefs: freezed == prefs
          ? _value.prefs
          : prefs // ignore: cast_nullable_to_non_nullable
              as GamePrefs?,
      clock: freezed == clock
          ? _value.clock
          : clock // ignore: cast_nullable_to_non_nullable
              as PlayableClockData?,
      boosted: freezed == boosted
          ? _value.boosted
          : boosted // ignore: cast_nullable_to_non_nullable
              as bool?,
      isThreefoldRepetition: freezed == isThreefoldRepetition
          ? _value.isThreefoldRepetition
          : isThreefoldRepetition // ignore: cast_nullable_to_non_nullable
              as bool?,
      expiration: freezed == expiration
          ? _value.expiration
          : expiration // ignore: cast_nullable_to_non_nullable
              as ({Duration idle, DateTime movedAt, Duration timeToMove})?,
      rematch: freezed == rematch
          ? _value.rematch
          : rematch // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayableGameMetaCopyWith<$Res> get meta {
    return $PlayableGameMetaCopyWith<$Res>(_value.meta, (value) {
      return _then(_value.copyWith(meta: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerCopyWith<$Res> get white {
    return $PlayerCopyWith<$Res>(_value.white, (value) {
      return _then(_value.copyWith(white: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerCopyWith<$Res> get black {
    return $PlayerCopyWith<$Res>(_value.black, (value) {
      return _then(_value.copyWith(black: value) as $Val);
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

  @override
  @pragma('vm:prefer-inline')
  $PlayableClockDataCopyWith<$Res>? get clock {
    if (_value.clock == null) {
      return null;
    }

    return $PlayableClockDataCopyWith<$Res>(_value.clock!, (value) {
      return _then(_value.copyWith(clock: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlayableGameImplCopyWith<$Res>
    implements $PlayableGameCopyWith<$Res> {
  factory _$$PlayableGameImplCopyWith(
          _$PlayableGameImpl value, $Res Function(_$PlayableGameImpl) then) =
      __$$PlayableGameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      PlayableGameMeta meta,
      IList<GameStep> steps,
      GameStatus status,
      Rule rule,
      Speed speed,
      Perf perf,
      Player white,
      Player black,
      bool moretimeable,
      bool takebackable,
      String? initialFen,
      Side? winner,
      Side? youAre,
      GamePrefs? prefs,
      PlayableClockData? clock,
      bool? boosted,
      bool? isThreefoldRepetition,
      ({Duration idle, DateTime movedAt, Duration timeToMove})? expiration,
      String? rematch});

  @override
  $PlayableGameMetaCopyWith<$Res> get meta;
  @override
  $PlayerCopyWith<$Res> get white;
  @override
  $PlayerCopyWith<$Res> get black;
  @override
  $GamePrefsCopyWith<$Res>? get prefs;
  @override
  $PlayableClockDataCopyWith<$Res>? get clock;
}

/// @nodoc
class __$$PlayableGameImplCopyWithImpl<$Res>
    extends _$PlayableGameCopyWithImpl<$Res, _$PlayableGameImpl>
    implements _$$PlayableGameImplCopyWith<$Res> {
  __$$PlayableGameImplCopyWithImpl(
      _$PlayableGameImpl _value, $Res Function(_$PlayableGameImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? meta = null,
    Object? steps = null,
    Object? status = null,
    Object? rule = null,
    Object? speed = null,
    Object? perf = null,
    Object? white = null,
    Object? black = null,
    Object? moretimeable = null,
    Object? takebackable = null,
    Object? initialFen = freezed,
    Object? winner = freezed,
    Object? youAre = freezed,
    Object? prefs = freezed,
    Object? clock = freezed,
    Object? boosted = freezed,
    Object? isThreefoldRepetition = freezed,
    Object? expiration = freezed,
    Object? rematch = freezed,
  }) {
    return _then(_$PlayableGameImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      meta: null == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as PlayableGameMeta,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as IList<GameStep>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      rule: null == rule
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as Rule,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as Speed,
      perf: null == perf
          ? _value.perf
          : perf // ignore: cast_nullable_to_non_nullable
              as Perf,
      white: null == white
          ? _value.white
          : white // ignore: cast_nullable_to_non_nullable
              as Player,
      black: null == black
          ? _value.black
          : black // ignore: cast_nullable_to_non_nullable
              as Player,
      moretimeable: null == moretimeable
          ? _value.moretimeable
          : moretimeable // ignore: cast_nullable_to_non_nullable
              as bool,
      takebackable: null == takebackable
          ? _value.takebackable
          : takebackable // ignore: cast_nullable_to_non_nullable
              as bool,
      initialFen: freezed == initialFen
          ? _value.initialFen
          : initialFen // ignore: cast_nullable_to_non_nullable
              as String?,
      winner: freezed == winner
          ? _value.winner
          : winner // ignore: cast_nullable_to_non_nullable
              as Side?,
      youAre: freezed == youAre
          ? _value.youAre
          : youAre // ignore: cast_nullable_to_non_nullable
              as Side?,
      prefs: freezed == prefs
          ? _value.prefs
          : prefs // ignore: cast_nullable_to_non_nullable
              as GamePrefs?,
      clock: freezed == clock
          ? _value.clock
          : clock // ignore: cast_nullable_to_non_nullable
              as PlayableClockData?,
      boosted: freezed == boosted
          ? _value.boosted
          : boosted // ignore: cast_nullable_to_non_nullable
              as bool?,
      isThreefoldRepetition: freezed == isThreefoldRepetition
          ? _value.isThreefoldRepetition
          : isThreefoldRepetition // ignore: cast_nullable_to_non_nullable
              as bool?,
      expiration: freezed == expiration
          ? _value.expiration
          : expiration // ignore: cast_nullable_to_non_nullable
              as ({Duration idle, DateTime movedAt, Duration timeToMove})?,
      rematch: freezed == rematch
          ? _value.rematch
          : rematch // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$PlayableGameImpl extends _PlayableGame {
  _$PlayableGameImpl(
      {required this.id,
      required this.meta,
      required this.steps,
      required this.status,
      required this.rule,
      required this.speed,
      required this.perf,
      required this.white,
      required this.black,
      required this.moretimeable,
      required this.takebackable,
      this.initialFen,
      this.winner,
      this.youAre,
      this.prefs,
      this.clock,
      this.boosted,
      this.isThreefoldRepetition,
      this.expiration,
      this.rematch})
      : assert(steps.isNotEmpty),
        super._();

  @override
  final String id;
  @override
  final PlayableGameMeta meta;
  @override
  final IList<GameStep> steps;
  @override
  final GameStatus status;
  @override
  final Rule rule;
  @override
  final Speed speed;
  @override
  final Perf perf;
  @override
  final Player white;
  @override
  final Player black;
  @override
  final bool moretimeable;
  @override
  final bool takebackable;
  @override
  final String? initialFen;
  @override
  final Side? winner;

  /// The side that the current player is playing as. This is null if viewing
  /// the game as a spectator.
  @override
  final Side? youAre;
  @override
  final GamePrefs? prefs;
  @override
  final PlayableClockData? clock;
  @override
  final bool? boosted;
  @override
  final bool? isThreefoldRepetition;
  @override
  final ({Duration idle, DateTime movedAt, Duration timeToMove})? expiration;

  /// The game id of the next game if a rematch has been accepted.
  @override
  final String? rematch;

  @override
  String toString() {
    return 'PlayableGame(id: $id, meta: $meta, steps: $steps, status: $status, rule: $rule, speed: $speed, perf: $perf, white: $white, black: $black, moretimeable: $moretimeable, takebackable: $takebackable, initialFen: $initialFen, winner: $winner, youAre: $youAre, prefs: $prefs, clock: $clock, boosted: $boosted, isThreefoldRepetition: $isThreefoldRepetition, expiration: $expiration, rematch: $rematch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayableGameImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.meta, meta) || other.meta == meta) &&
            const DeepCollectionEquality().equals(other.steps, steps) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.rule, rule) || other.rule == rule) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.perf, perf) || other.perf == perf) &&
            (identical(other.white, white) || other.white == white) &&
            (identical(other.black, black) || other.black == black) &&
            (identical(other.moretimeable, moretimeable) ||
                other.moretimeable == moretimeable) &&
            (identical(other.takebackable, takebackable) ||
                other.takebackable == takebackable) &&
            (identical(other.initialFen, initialFen) ||
                other.initialFen == initialFen) &&
            (identical(other.winner, winner) || other.winner == winner) &&
            (identical(other.youAre, youAre) || other.youAre == youAre) &&
            (identical(other.prefs, prefs) || other.prefs == prefs) &&
            (identical(other.clock, clock) || other.clock == clock) &&
            (identical(other.boosted, boosted) || other.boosted == boosted) &&
            (identical(other.isThreefoldRepetition, isThreefoldRepetition) ||
                other.isThreefoldRepetition == isThreefoldRepetition) &&
            (identical(other.expiration, expiration) ||
                other.expiration == expiration) &&
            (identical(other.rematch, rematch) || other.rematch == rematch));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        meta,
        const DeepCollectionEquality().hash(steps),
        status,
        rule,
        speed,
        perf,
        white,
        black,
        moretimeable,
        takebackable,
        initialFen,
        winner,
        youAre,
        prefs,
        clock,
        boosted,
        isThreefoldRepetition,
        expiration,
        rematch
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayableGameImplCopyWith<_$PlayableGameImpl> get copyWith =>
      __$$PlayableGameImplCopyWithImpl<_$PlayableGameImpl>(this, _$identity);
}

abstract class _PlayableGame extends PlayableGame {
  factory _PlayableGame(
      {required final String id,
      required final PlayableGameMeta meta,
      required final IList<GameStep> steps,
      required final GameStatus status,
      required final Rule rule,
      required final Speed speed,
      required final Perf perf,
      required final Player white,
      required final Player black,
      required final bool moretimeable,
      required final bool takebackable,
      final String? initialFen,
      final Side? winner,
      final Side? youAre,
      final GamePrefs? prefs,
      final PlayableClockData? clock,
      final bool? boosted,
      final bool? isThreefoldRepetition,
      final ({
        Duration idle,
        DateTime movedAt,
        Duration timeToMove
      })? expiration,
      final String? rematch}) = _$PlayableGameImpl;
  _PlayableGame._() : super._();

  @override
  String get id;
  @override
  PlayableGameMeta get meta;
  @override
  IList<GameStep> get steps;
  @override
  GameStatus get status;
  @override
  Rule get rule;
  @override
  Speed get speed;
  @override
  Perf get perf;
  @override
  Player get white;
  @override
  Player get black;
  @override
  bool get moretimeable;
  @override
  bool get takebackable;
  @override
  String? get initialFen;
  @override
  Side? get winner;
  @override

  /// The side that the current player is playing as. This is null if viewing
  /// the game as a spectator.
  Side? get youAre;
  @override
  GamePrefs? get prefs;
  @override
  PlayableClockData? get clock;
  @override
  bool? get boosted;
  @override
  bool? get isThreefoldRepetition;
  @override
  ({Duration idle, DateTime movedAt, Duration timeToMove})? get expiration;
  @override

  /// The game id of the next game if a rematch has been accepted.
  String? get rematch;
  @override
  @JsonKey(ignore: true)
  _$$PlayableGameImplCopyWith<_$PlayableGameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
