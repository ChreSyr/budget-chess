// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setup_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SetupModel _$SetupModelFromJson(Map<String, dynamic> json) {
  return _SetupModel.fromJson(json);
}

/// @nodoc
mixin _$SetupModel {
  String get halfFen => throw _privateConstructorUsedError;
  Side? get betterWithSide => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SetupModelCopyWith<SetupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SetupModelCopyWith<$Res> {
  factory $SetupModelCopyWith(
          SetupModel value, $Res Function(SetupModel) then) =
      _$SetupModelCopyWithImpl<$Res, SetupModel>;
  @useResult
  $Res call({String halfFen, Side? betterWithSide});
}

/// @nodoc
class _$SetupModelCopyWithImpl<$Res, $Val extends SetupModel>
    implements $SetupModelCopyWith<$Res> {
  _$SetupModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? halfFen = null,
    Object? betterWithSide = freezed,
  }) {
    return _then(_value.copyWith(
      halfFen: null == halfFen
          ? _value.halfFen
          : halfFen // ignore: cast_nullable_to_non_nullable
              as String,
      betterWithSide: freezed == betterWithSide
          ? _value.betterWithSide
          : betterWithSide // ignore: cast_nullable_to_non_nullable
              as Side?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SetupModelImplCopyWith<$Res>
    implements $SetupModelCopyWith<$Res> {
  factory _$$SetupModelImplCopyWith(
          _$SetupModelImpl value, $Res Function(_$SetupModelImpl) then) =
      __$$SetupModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String halfFen, Side? betterWithSide});
}

/// @nodoc
class __$$SetupModelImplCopyWithImpl<$Res>
    extends _$SetupModelCopyWithImpl<$Res, _$SetupModelImpl>
    implements _$$SetupModelImplCopyWith<$Res> {
  __$$SetupModelImplCopyWithImpl(
      _$SetupModelImpl _value, $Res Function(_$SetupModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? halfFen = null,
    Object? betterWithSide = freezed,
  }) {
    return _then(_$SetupModelImpl(
      halfFen: null == halfFen
          ? _value.halfFen
          : halfFen // ignore: cast_nullable_to_non_nullable
              as String,
      betterWithSide: freezed == betterWithSide
          ? _value.betterWithSide
          : betterWithSide // ignore: cast_nullable_to_non_nullable
              as Side?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SetupModelImpl extends _SetupModel {
  const _$SetupModelImpl({required this.halfFen, this.betterWithSide})
      : super._();

  factory _$SetupModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SetupModelImplFromJson(json);

  @override
  final String halfFen;
  @override
  final Side? betterWithSide;

  @override
  String toString() {
    return 'SetupModel(halfFen: $halfFen, betterWithSide: $betterWithSide)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetupModelImpl &&
            (identical(other.halfFen, halfFen) || other.halfFen == halfFen) &&
            (identical(other.betterWithSide, betterWithSide) ||
                other.betterWithSide == betterWithSide));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, halfFen, betterWithSide);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetupModelImplCopyWith<_$SetupModelImpl> get copyWith =>
      __$$SetupModelImplCopyWithImpl<_$SetupModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SetupModelImplToJson(
      this,
    );
  }
}

abstract class _SetupModel extends SetupModel {
  const factory _SetupModel(
      {required final String halfFen,
      final Side? betterWithSide}) = _$SetupModelImpl;
  const _SetupModel._() : super._();

  factory _SetupModel.fromJson(Map<String, dynamic> json) =
      _$SetupModelImpl.fromJson;

  @override
  String get halfFen;
  @override
  Side? get betterWithSide;
  @override
  @JsonKey(ignore: true)
  _$$SetupModelImplCopyWith<_$SetupModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
