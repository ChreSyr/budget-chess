// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PlayerAnalysis _$PlayerAnalysisFromJson(Map<String, dynamic> json) {
  return _PlayerAnalysis.fromJson(json);
}

/// @nodoc
mixin _$PlayerAnalysis {
  int get inaccuracies => throw _privateConstructorUsedError;
  int get mistakes => throw _privateConstructorUsedError;
  int get blunders => throw _privateConstructorUsedError;
  int? get acpl => throw _privateConstructorUsedError;
  int? get accuracy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerAnalysisCopyWith<PlayerAnalysis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerAnalysisCopyWith<$Res> {
  factory $PlayerAnalysisCopyWith(
          PlayerAnalysis value, $Res Function(PlayerAnalysis) then) =
      _$PlayerAnalysisCopyWithImpl<$Res, PlayerAnalysis>;
  @useResult
  $Res call(
      {int inaccuracies, int mistakes, int blunders, int? acpl, int? accuracy});
}

/// @nodoc
class _$PlayerAnalysisCopyWithImpl<$Res, $Val extends PlayerAnalysis>
    implements $PlayerAnalysisCopyWith<$Res> {
  _$PlayerAnalysisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inaccuracies = null,
    Object? mistakes = null,
    Object? blunders = null,
    Object? acpl = freezed,
    Object? accuracy = freezed,
  }) {
    return _then(_value.copyWith(
      inaccuracies: null == inaccuracies
          ? _value.inaccuracies
          : inaccuracies // ignore: cast_nullable_to_non_nullable
              as int,
      mistakes: null == mistakes
          ? _value.mistakes
          : mistakes // ignore: cast_nullable_to_non_nullable
              as int,
      blunders: null == blunders
          ? _value.blunders
          : blunders // ignore: cast_nullable_to_non_nullable
              as int,
      acpl: freezed == acpl
          ? _value.acpl
          : acpl // ignore: cast_nullable_to_non_nullable
              as int?,
      accuracy: freezed == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerAnalysisImplCopyWith<$Res>
    implements $PlayerAnalysisCopyWith<$Res> {
  factory _$$PlayerAnalysisImplCopyWith(_$PlayerAnalysisImpl value,
          $Res Function(_$PlayerAnalysisImpl) then) =
      __$$PlayerAnalysisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int inaccuracies, int mistakes, int blunders, int? acpl, int? accuracy});
}

/// @nodoc
class __$$PlayerAnalysisImplCopyWithImpl<$Res>
    extends _$PlayerAnalysisCopyWithImpl<$Res, _$PlayerAnalysisImpl>
    implements _$$PlayerAnalysisImplCopyWith<$Res> {
  __$$PlayerAnalysisImplCopyWithImpl(
      _$PlayerAnalysisImpl _value, $Res Function(_$PlayerAnalysisImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inaccuracies = null,
    Object? mistakes = null,
    Object? blunders = null,
    Object? acpl = freezed,
    Object? accuracy = freezed,
  }) {
    return _then(_$PlayerAnalysisImpl(
      inaccuracies: null == inaccuracies
          ? _value.inaccuracies
          : inaccuracies // ignore: cast_nullable_to_non_nullable
              as int,
      mistakes: null == mistakes
          ? _value.mistakes
          : mistakes // ignore: cast_nullable_to_non_nullable
              as int,
      blunders: null == blunders
          ? _value.blunders
          : blunders // ignore: cast_nullable_to_non_nullable
              as int,
      acpl: freezed == acpl
          ? _value.acpl
          : acpl // ignore: cast_nullable_to_non_nullable
              as int?,
      accuracy: freezed == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerAnalysisImpl implements _PlayerAnalysis {
  const _$PlayerAnalysisImpl(
      {required this.inaccuracies,
      required this.mistakes,
      required this.blunders,
      this.acpl,
      this.accuracy});

  factory _$PlayerAnalysisImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerAnalysisImplFromJson(json);

  @override
  final int inaccuracies;
  @override
  final int mistakes;
  @override
  final int blunders;
  @override
  final int? acpl;
  @override
  final int? accuracy;

  @override
  String toString() {
    return 'PlayerAnalysis(inaccuracies: $inaccuracies, mistakes: $mistakes, blunders: $blunders, acpl: $acpl, accuracy: $accuracy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerAnalysisImpl &&
            (identical(other.inaccuracies, inaccuracies) ||
                other.inaccuracies == inaccuracies) &&
            (identical(other.mistakes, mistakes) ||
                other.mistakes == mistakes) &&
            (identical(other.blunders, blunders) ||
                other.blunders == blunders) &&
            (identical(other.acpl, acpl) || other.acpl == acpl) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, inaccuracies, mistakes, blunders, acpl, accuracy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerAnalysisImplCopyWith<_$PlayerAnalysisImpl> get copyWith =>
      __$$PlayerAnalysisImplCopyWithImpl<_$PlayerAnalysisImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerAnalysisImplToJson(
      this,
    );
  }
}

abstract class _PlayerAnalysis implements PlayerAnalysis {
  const factory _PlayerAnalysis(
      {required final int inaccuracies,
      required final int mistakes,
      required final int blunders,
      final int? acpl,
      final int? accuracy}) = _$PlayerAnalysisImpl;

  factory _PlayerAnalysis.fromJson(Map<String, dynamic> json) =
      _$PlayerAnalysisImpl.fromJson;

  @override
  int get inaccuracies;
  @override
  int get mistakes;
  @override
  int get blunders;
  @override
  int? get acpl;
  @override
  int? get accuracy;
  @override
  @JsonKey(ignore: true)
  _$$PlayerAnalysisImplCopyWith<_$PlayerAnalysisImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Player _$PlayerFromJson(Map<String, dynamic> json) {
  return _Player.fromJson(json);
}

/// @nodoc
mixin _$Player {
  UserModel? get user => throw _privateConstructorUsedError;
  int? get aiLevel => throw _privateConstructorUsedError;
  int? get rating => throw _privateConstructorUsedError;
  int? get ratingDiff => throw _privateConstructorUsedError;

  /// if true, the rating is not definitive yet
  bool? get provisional => throw _privateConstructorUsedError;

  /// Whether the player is connected to the game websocket
  bool? get onGame => throw _privateConstructorUsedError;

  /// Is true if the player is disconnected from the game long enough that the
  /// opponent can claim a win
  bool? get isGone => throw _privateConstructorUsedError;
  bool? get offeringDraw => throw _privateConstructorUsedError;
  bool? get offeringRematch => throw _privateConstructorUsedError;
  bool? get proposingTakeback => throw _privateConstructorUsedError;

  /// Post game player analysis summary
  PlayerAnalysis? get analysis => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerCopyWith<Player> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerCopyWith<$Res> {
  factory $PlayerCopyWith(Player value, $Res Function(Player) then) =
      _$PlayerCopyWithImpl<$Res, Player>;
  @useResult
  $Res call(
      {UserModel? user,
      int? aiLevel,
      int? rating,
      int? ratingDiff,
      bool? provisional,
      bool? onGame,
      bool? isGone,
      bool? offeringDraw,
      bool? offeringRematch,
      bool? proposingTakeback,
      PlayerAnalysis? analysis});

  $UserModelCopyWith<$Res>? get user;
  $PlayerAnalysisCopyWith<$Res>? get analysis;
}

/// @nodoc
class _$PlayerCopyWithImpl<$Res, $Val extends Player>
    implements $PlayerCopyWith<$Res> {
  _$PlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? aiLevel = freezed,
    Object? rating = freezed,
    Object? ratingDiff = freezed,
    Object? provisional = freezed,
    Object? onGame = freezed,
    Object? isGone = freezed,
    Object? offeringDraw = freezed,
    Object? offeringRematch = freezed,
    Object? proposingTakeback = freezed,
    Object? analysis = freezed,
  }) {
    return _then(_value.copyWith(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      aiLevel: freezed == aiLevel
          ? _value.aiLevel
          : aiLevel // ignore: cast_nullable_to_non_nullable
              as int?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int?,
      ratingDiff: freezed == ratingDiff
          ? _value.ratingDiff
          : ratingDiff // ignore: cast_nullable_to_non_nullable
              as int?,
      provisional: freezed == provisional
          ? _value.provisional
          : provisional // ignore: cast_nullable_to_non_nullable
              as bool?,
      onGame: freezed == onGame
          ? _value.onGame
          : onGame // ignore: cast_nullable_to_non_nullable
              as bool?,
      isGone: freezed == isGone
          ? _value.isGone
          : isGone // ignore: cast_nullable_to_non_nullable
              as bool?,
      offeringDraw: freezed == offeringDraw
          ? _value.offeringDraw
          : offeringDraw // ignore: cast_nullable_to_non_nullable
              as bool?,
      offeringRematch: freezed == offeringRematch
          ? _value.offeringRematch
          : offeringRematch // ignore: cast_nullable_to_non_nullable
              as bool?,
      proposingTakeback: freezed == proposingTakeback
          ? _value.proposingTakeback
          : proposingTakeback // ignore: cast_nullable_to_non_nullable
              as bool?,
      analysis: freezed == analysis
          ? _value.analysis
          : analysis // ignore: cast_nullable_to_non_nullable
              as PlayerAnalysis?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerAnalysisCopyWith<$Res>? get analysis {
    if (_value.analysis == null) {
      return null;
    }

    return $PlayerAnalysisCopyWith<$Res>(_value.analysis!, (value) {
      return _then(_value.copyWith(analysis: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlayerImplCopyWith<$Res> implements $PlayerCopyWith<$Res> {
  factory _$$PlayerImplCopyWith(
          _$PlayerImpl value, $Res Function(_$PlayerImpl) then) =
      __$$PlayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserModel? user,
      int? aiLevel,
      int? rating,
      int? ratingDiff,
      bool? provisional,
      bool? onGame,
      bool? isGone,
      bool? offeringDraw,
      bool? offeringRematch,
      bool? proposingTakeback,
      PlayerAnalysis? analysis});

  @override
  $UserModelCopyWith<$Res>? get user;
  @override
  $PlayerAnalysisCopyWith<$Res>? get analysis;
}

/// @nodoc
class __$$PlayerImplCopyWithImpl<$Res>
    extends _$PlayerCopyWithImpl<$Res, _$PlayerImpl>
    implements _$$PlayerImplCopyWith<$Res> {
  __$$PlayerImplCopyWithImpl(
      _$PlayerImpl _value, $Res Function(_$PlayerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? aiLevel = freezed,
    Object? rating = freezed,
    Object? ratingDiff = freezed,
    Object? provisional = freezed,
    Object? onGame = freezed,
    Object? isGone = freezed,
    Object? offeringDraw = freezed,
    Object? offeringRematch = freezed,
    Object? proposingTakeback = freezed,
    Object? analysis = freezed,
  }) {
    return _then(_$PlayerImpl(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      aiLevel: freezed == aiLevel
          ? _value.aiLevel
          : aiLevel // ignore: cast_nullable_to_non_nullable
              as int?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int?,
      ratingDiff: freezed == ratingDiff
          ? _value.ratingDiff
          : ratingDiff // ignore: cast_nullable_to_non_nullable
              as int?,
      provisional: freezed == provisional
          ? _value.provisional
          : provisional // ignore: cast_nullable_to_non_nullable
              as bool?,
      onGame: freezed == onGame
          ? _value.onGame
          : onGame // ignore: cast_nullable_to_non_nullable
              as bool?,
      isGone: freezed == isGone
          ? _value.isGone
          : isGone // ignore: cast_nullable_to_non_nullable
              as bool?,
      offeringDraw: freezed == offeringDraw
          ? _value.offeringDraw
          : offeringDraw // ignore: cast_nullable_to_non_nullable
              as bool?,
      offeringRematch: freezed == offeringRematch
          ? _value.offeringRematch
          : offeringRematch // ignore: cast_nullable_to_non_nullable
              as bool?,
      proposingTakeback: freezed == proposingTakeback
          ? _value.proposingTakeback
          : proposingTakeback // ignore: cast_nullable_to_non_nullable
              as bool?,
      analysis: freezed == analysis
          ? _value.analysis
          : analysis // ignore: cast_nullable_to_non_nullable
              as PlayerAnalysis?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerImpl extends _Player {
  const _$PlayerImpl(
      {this.user,
      this.aiLevel,
      this.rating,
      this.ratingDiff,
      this.provisional,
      this.onGame,
      this.isGone,
      this.offeringDraw,
      this.offeringRematch,
      this.proposingTakeback,
      this.analysis})
      : super._();

  factory _$PlayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerImplFromJson(json);

  @override
  final UserModel? user;
  @override
  final int? aiLevel;
  @override
  final int? rating;
  @override
  final int? ratingDiff;

  /// if true, the rating is not definitive yet
  @override
  final bool? provisional;

  /// Whether the player is connected to the game websocket
  @override
  final bool? onGame;

  /// Is true if the player is disconnected from the game long enough that the
  /// opponent can claim a win
  @override
  final bool? isGone;
  @override
  final bool? offeringDraw;
  @override
  final bool? offeringRematch;
  @override
  final bool? proposingTakeback;

  /// Post game player analysis summary
  @override
  final PlayerAnalysis? analysis;

  @override
  String toString() {
    return 'Player(user: $user, aiLevel: $aiLevel, rating: $rating, ratingDiff: $ratingDiff, provisional: $provisional, onGame: $onGame, isGone: $isGone, offeringDraw: $offeringDraw, offeringRematch: $offeringRematch, proposingTakeback: $proposingTakeback, analysis: $analysis)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.aiLevel, aiLevel) || other.aiLevel == aiLevel) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.ratingDiff, ratingDiff) ||
                other.ratingDiff == ratingDiff) &&
            (identical(other.provisional, provisional) ||
                other.provisional == provisional) &&
            (identical(other.onGame, onGame) || other.onGame == onGame) &&
            (identical(other.isGone, isGone) || other.isGone == isGone) &&
            (identical(other.offeringDraw, offeringDraw) ||
                other.offeringDraw == offeringDraw) &&
            (identical(other.offeringRematch, offeringRematch) ||
                other.offeringRematch == offeringRematch) &&
            (identical(other.proposingTakeback, proposingTakeback) ||
                other.proposingTakeback == proposingTakeback) &&
            (identical(other.analysis, analysis) ||
                other.analysis == analysis));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      user,
      aiLevel,
      rating,
      ratingDiff,
      provisional,
      onGame,
      isGone,
      offeringDraw,
      offeringRematch,
      proposingTakeback,
      analysis);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerImplCopyWith<_$PlayerImpl> get copyWith =>
      __$$PlayerImplCopyWithImpl<_$PlayerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerImplToJson(
      this,
    );
  }
}

abstract class _Player extends Player {
  const factory _Player(
      {final UserModel? user,
      final int? aiLevel,
      final int? rating,
      final int? ratingDiff,
      final bool? provisional,
      final bool? onGame,
      final bool? isGone,
      final bool? offeringDraw,
      final bool? offeringRematch,
      final bool? proposingTakeback,
      final PlayerAnalysis? analysis}) = _$PlayerImpl;
  const _Player._() : super._();

  factory _Player.fromJson(Map<String, dynamic> json) = _$PlayerImpl.fromJson;

  @override
  UserModel? get user;
  @override
  int? get aiLevel;
  @override
  int? get rating;
  @override
  int? get ratingDiff;
  @override

  /// if true, the rating is not definitive yet
  bool? get provisional;
  @override

  /// Whether the player is connected to the game websocket
  bool? get onGame;
  @override

  /// Is true if the player is disconnected from the game long enough that the
  /// opponent can claim a win
  bool? get isGone;
  @override
  bool? get offeringDraw;
  @override
  bool? get offeringRematch;
  @override
  bool? get proposingTakeback;
  @override

  /// Post game player analysis summary
  PlayerAnalysis? get analysis;
  @override
  @JsonKey(ignore: true)
  _$$PlayerImplCopyWith<_$PlayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
