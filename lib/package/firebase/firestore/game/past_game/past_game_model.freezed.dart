// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'past_game_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PastGameModel _$PastGameModelFromJson(Map<String, dynamic> json) {
  return _PastGameModel.fromJson(json);
}

/// @nodoc
mixin _$PastGameModel {
  String get id => throw _privateConstructorUsedError;
  ChallengeModel get challenge => throw _privateConstructorUsedError;
  String get blackId => throw _privateConstructorUsedError;
  String get whiteId => throw _privateConstructorUsedError;
  String get pgn => throw _privateConstructorUsedError;
  GameStatus get status => throw _privateConstructorUsedError;
  Side? get winner => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PastGameModelCopyWith<PastGameModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PastGameModelCopyWith<$Res> {
  factory $PastGameModelCopyWith(
          PastGameModel value, $Res Function(PastGameModel) then) =
      _$PastGameModelCopyWithImpl<$Res, PastGameModel>;
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
class _$PastGameModelCopyWithImpl<$Res, $Val extends PastGameModel>
    implements $PastGameModelCopyWith<$Res> {
  _$PastGameModelCopyWithImpl(this._value, this._then);

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
abstract class _$$PastGameModelImplCopyWith<$Res>
    implements $PastGameModelCopyWith<$Res> {
  factory _$$PastGameModelImplCopyWith(
          _$PastGameModelImpl value, $Res Function(_$PastGameModelImpl) then) =
      __$$PastGameModelImplCopyWithImpl<$Res>;
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
class __$$PastGameModelImplCopyWithImpl<$Res>
    extends _$PastGameModelCopyWithImpl<$Res, _$PastGameModelImpl>
    implements _$$PastGameModelImplCopyWith<$Res> {
  __$$PastGameModelImplCopyWithImpl(
      _$PastGameModelImpl _value, $Res Function(_$PastGameModelImpl) _then)
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
    return _then(_$PastGameModelImpl(
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
class _$PastGameModelImpl extends _PastGameModel {
  const _$PastGameModelImpl(
      {required this.id,
      required this.challenge,
      required this.blackId,
      required this.whiteId,
      required this.pgn,
      required this.status,
      this.winner})
      : super._();

  factory _$PastGameModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PastGameModelImplFromJson(json);

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
    return 'PastGameModel(id: $id, challenge: $challenge, blackId: $blackId, whiteId: $whiteId, pgn: $pgn, status: $status, winner: $winner)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PastGameModelImpl &&
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
  _$$PastGameModelImplCopyWith<_$PastGameModelImpl> get copyWith =>
      __$$PastGameModelImplCopyWithImpl<_$PastGameModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PastGameModelImplToJson(
      this,
    );
  }
}

abstract class _PastGameModel extends PastGameModel {
  const factory _PastGameModel(
      {required final String id,
      required final ChallengeModel challenge,
      required final String blackId,
      required final String whiteId,
      required final String pgn,
      required final GameStatus status,
      final Side? winner}) = _$PastGameModelImpl;
  const _PastGameModel._() : super._();

  factory _PastGameModel.fromJson(Map<String, dynamic> json) =
      _$PastGameModelImpl.fromJson;

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
  _$$PastGameModelImplCopyWith<_$PastGameModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
