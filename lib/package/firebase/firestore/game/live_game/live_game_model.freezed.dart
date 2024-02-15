// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_game_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LiveGameModel _$LiveGameModelFromJson(Map<String, dynamic> json) {
  return _LiveGameModel.fromJson(json);
}

/// @nodoc
mixin _$LiveGameModel {
  String get id => throw _privateConstructorUsedError;
  ChallengeModel get challenge => throw _privateConstructorUsedError;
  String get blackId => throw _privateConstructorUsedError;
  String get whiteId => throw _privateConstructorUsedError;
  String get pgn => throw _privateConstructorUsedError;
  GameStatus get status => throw _privateConstructorUsedError;
  Side? get winner => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LiveGameModelCopyWith<LiveGameModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiveGameModelCopyWith<$Res> {
  factory $LiveGameModelCopyWith(
          LiveGameModel value, $Res Function(LiveGameModel) then) =
      _$LiveGameModelCopyWithImpl<$Res, LiveGameModel>;
  @useResult
  $Res call(
      {String id,
      ChallengeModel challenge,
      String blackId,
      String whiteId,
      String pgn,
      GameStatus status,
      Side? winner});

  $ChallengeModelCopyWith<$Res> get challenge;
}

/// @nodoc
class _$LiveGameModelCopyWithImpl<$Res, $Val extends LiveGameModel>
    implements $LiveGameModelCopyWith<$Res> {
  _$LiveGameModelCopyWithImpl(this._value, this._then);

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
    Object? pgn = null,
    Object? status = null,
    Object? winner = freezed,
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
      pgn: null == pgn
          ? _value.pgn
          : pgn // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      winner: freezed == winner
          ? _value.winner
          : winner // ignore: cast_nullable_to_non_nullable
              as Side?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChallengeModelCopyWith<$Res> get challenge {
    return $ChallengeModelCopyWith<$Res>(_value.challenge, (value) {
      return _then(_value.copyWith(challenge: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LiveGameModelImplCopyWith<$Res>
    implements $LiveGameModelCopyWith<$Res> {
  factory _$$LiveGameModelImplCopyWith(
          _$LiveGameModelImpl value, $Res Function(_$LiveGameModelImpl) then) =
      __$$LiveGameModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      ChallengeModel challenge,
      String blackId,
      String whiteId,
      String pgn,
      GameStatus status,
      Side? winner});

  @override
  $ChallengeModelCopyWith<$Res> get challenge;
}

/// @nodoc
class __$$LiveGameModelImplCopyWithImpl<$Res>
    extends _$LiveGameModelCopyWithImpl<$Res, _$LiveGameModelImpl>
    implements _$$LiveGameModelImplCopyWith<$Res> {
  __$$LiveGameModelImplCopyWithImpl(
      _$LiveGameModelImpl _value, $Res Function(_$LiveGameModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? challenge = null,
    Object? blackId = null,
    Object? whiteId = null,
    Object? pgn = null,
    Object? status = null,
    Object? winner = freezed,
  }) {
    return _then(_$LiveGameModelImpl(
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
      pgn: null == pgn
          ? _value.pgn
          : pgn // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      winner: freezed == winner
          ? _value.winner
          : winner // ignore: cast_nullable_to_non_nullable
              as Side?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LiveGameModelImpl extends _LiveGameModel {
  const _$LiveGameModelImpl(
      {required this.id,
      required this.challenge,
      required this.blackId,
      required this.whiteId,
      required this.pgn,
      required this.status,
      this.winner})
      : super._();

  factory _$LiveGameModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LiveGameModelImplFromJson(json);

  @override
  final String id;
  @override
  final ChallengeModel challenge;
  @override
  final String blackId;
  @override
  final String whiteId;
  @override
  final String pgn;
  @override
  final GameStatus status;
  @override
  final Side? winner;

  @override
  String toString() {
    return 'LiveGameModel(id: $id, challenge: $challenge, blackId: $blackId, whiteId: $whiteId, pgn: $pgn, status: $status, winner: $winner)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiveGameModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.challenge, challenge) ||
                other.challenge == challenge) &&
            (identical(other.blackId, blackId) || other.blackId == blackId) &&
            (identical(other.whiteId, whiteId) || other.whiteId == whiteId) &&
            (identical(other.pgn, pgn) || other.pgn == pgn) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.winner, winner) || other.winner == winner));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, challenge, blackId, whiteId, pgn, status, winner);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LiveGameModelImplCopyWith<_$LiveGameModelImpl> get copyWith =>
      __$$LiveGameModelImplCopyWithImpl<_$LiveGameModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LiveGameModelImplToJson(
      this,
    );
  }
}

abstract class _LiveGameModel extends LiveGameModel {
  const factory _LiveGameModel(
      {required final String id,
      required final ChallengeModel challenge,
      required final String blackId,
      required final String whiteId,
      required final String pgn,
      required final GameStatus status,
      final Side? winner}) = _$LiveGameModelImpl;
  const _LiveGameModel._() : super._();

  factory _LiveGameModel.fromJson(Map<String, dynamic> json) =
      _$LiveGameModelImpl.fromJson;

  @override
  String get id;
  @override
  ChallengeModel get challenge;
  @override
  String get blackId;
  @override
  String get whiteId;
  @override
  String get pgn;
  @override
  GameStatus get status;
  @override
  Side? get winner;
  @override
  @JsonKey(ignore: true)
  _$$LiveGameModelImplCopyWith<_$LiveGameModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
