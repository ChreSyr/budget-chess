// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_challenge_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CreateChallengeForm {
  InputSelect<Rule> get rule => throw _privateConstructorUsedError;
  InputSelect<TimeControl> get timeControl =>
      throw _privateConstructorUsedError;
  InputInt get budget => throw _privateConstructorUsedError;
  InputSelect<BoardSize> get boardSize => throw _privateConstructorUsedError;
  CreateChallengeStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateChallengeFormCopyWith<CreateChallengeForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateChallengeFormCopyWith<$Res> {
  factory $CreateChallengeFormCopyWith(
          CreateChallengeForm value, $Res Function(CreateChallengeForm) then) =
      _$CreateChallengeFormCopyWithImpl<$Res, CreateChallengeForm>;
  @useResult
  $Res call(
      {InputSelect<Rule> rule,
      InputSelect<TimeControl> timeControl,
      InputInt budget,
      InputSelect<BoardSize> boardSize,
      CreateChallengeStatus status});
}

/// @nodoc
class _$CreateChallengeFormCopyWithImpl<$Res, $Val extends CreateChallengeForm>
    implements $CreateChallengeFormCopyWith<$Res> {
  _$CreateChallengeFormCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rule = null,
    Object? timeControl = null,
    Object? budget = null,
    Object? boardSize = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      rule: null == rule
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as InputSelect<Rule>,
      timeControl: null == timeControl
          ? _value.timeControl
          : timeControl // ignore: cast_nullable_to_non_nullable
              as InputSelect<TimeControl>,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as InputInt,
      boardSize: null == boardSize
          ? _value.boardSize
          : boardSize // ignore: cast_nullable_to_non_nullable
              as InputSelect<BoardSize>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CreateChallengeStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateChallengeFormImplCopyWith<$Res>
    implements $CreateChallengeFormCopyWith<$Res> {
  factory _$$CreateChallengeFormImplCopyWith(_$CreateChallengeFormImpl value,
          $Res Function(_$CreateChallengeFormImpl) then) =
      __$$CreateChallengeFormImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {InputSelect<Rule> rule,
      InputSelect<TimeControl> timeControl,
      InputInt budget,
      InputSelect<BoardSize> boardSize,
      CreateChallengeStatus status});
}

/// @nodoc
class __$$CreateChallengeFormImplCopyWithImpl<$Res>
    extends _$CreateChallengeFormCopyWithImpl<$Res, _$CreateChallengeFormImpl>
    implements _$$CreateChallengeFormImplCopyWith<$Res> {
  __$$CreateChallengeFormImplCopyWithImpl(_$CreateChallengeFormImpl _value,
      $Res Function(_$CreateChallengeFormImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rule = null,
    Object? timeControl = null,
    Object? budget = null,
    Object? boardSize = null,
    Object? status = null,
  }) {
    return _then(_$CreateChallengeFormImpl(
      rule: null == rule
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as InputSelect<Rule>,
      timeControl: null == timeControl
          ? _value.timeControl
          : timeControl // ignore: cast_nullable_to_non_nullable
              as InputSelect<TimeControl>,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as InputInt,
      boardSize: null == boardSize
          ? _value.boardSize
          : boardSize // ignore: cast_nullable_to_non_nullable
              as InputSelect<BoardSize>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CreateChallengeStatus,
    ));
  }
}

/// @nodoc

class _$CreateChallengeFormImpl extends _CreateChallengeForm {
  _$CreateChallengeFormImpl(
      {required this.rule,
      required this.timeControl,
      required this.budget,
      required this.boardSize,
      required this.status})
      : super._();

  @override
  final InputSelect<Rule> rule;
  @override
  final InputSelect<TimeControl> timeControl;
  @override
  final InputInt budget;
  @override
  final InputSelect<BoardSize> boardSize;
  @override
  final CreateChallengeStatus status;

  @override
  String toString() {
    return 'CreateChallengeForm(rule: $rule, timeControl: $timeControl, budget: $budget, boardSize: $boardSize, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateChallengeFormImpl &&
            (identical(other.rule, rule) || other.rule == rule) &&
            (identical(other.timeControl, timeControl) ||
                other.timeControl == timeControl) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.boardSize, boardSize) ||
                other.boardSize == boardSize) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, rule, timeControl, budget, boardSize, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateChallengeFormImplCopyWith<_$CreateChallengeFormImpl> get copyWith =>
      __$$CreateChallengeFormImplCopyWithImpl<_$CreateChallengeFormImpl>(
          this, _$identity);
}

abstract class _CreateChallengeForm extends CreateChallengeForm {
  factory _CreateChallengeForm(
      {required final InputSelect<Rule> rule,
      required final InputSelect<TimeControl> timeControl,
      required final InputInt budget,
      required final InputSelect<BoardSize> boardSize,
      required final CreateChallengeStatus status}) = _$CreateChallengeFormImpl;
  _CreateChallengeForm._() : super._();

  @override
  InputSelect<Rule> get rule;
  @override
  InputSelect<TimeControl> get timeControl;
  @override
  InputInt get budget;
  @override
  InputSelect<BoardSize> get boardSize;
  @override
  CreateChallengeStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$CreateChallengeFormImplCopyWith<_$CreateChallengeFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
