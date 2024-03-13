// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'username_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UsernameForm {
  InputString get name => throw _privateConstructorUsedError;
  UsernameFormStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UsernameFormCopyWith<UsernameForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsernameFormCopyWith<$Res> {
  factory $UsernameFormCopyWith(
          UsernameForm value, $Res Function(UsernameForm) then) =
      _$UsernameFormCopyWithImpl<$Res, UsernameForm>;
  @useResult
  $Res call({InputString name, UsernameFormStatus status});
}

/// @nodoc
class _$UsernameFormCopyWithImpl<$Res, $Val extends UsernameForm>
    implements $UsernameFormCopyWith<$Res> {
  _$UsernameFormCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as InputString,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UsernameFormStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UsernameFormImplCopyWith<$Res>
    implements $UsernameFormCopyWith<$Res> {
  factory _$$UsernameFormImplCopyWith(
          _$UsernameFormImpl value, $Res Function(_$UsernameFormImpl) then) =
      __$$UsernameFormImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({InputString name, UsernameFormStatus status});
}

/// @nodoc
class __$$UsernameFormImplCopyWithImpl<$Res>
    extends _$UsernameFormCopyWithImpl<$Res, _$UsernameFormImpl>
    implements _$$UsernameFormImplCopyWith<$Res> {
  __$$UsernameFormImplCopyWithImpl(
      _$UsernameFormImpl _value, $Res Function(_$UsernameFormImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? status = null,
  }) {
    return _then(_$UsernameFormImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as InputString,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UsernameFormStatus,
    ));
  }
}

/// @nodoc

class _$UsernameFormImpl extends _UsernameForm {
  _$UsernameFormImpl({required this.name, required this.status}) : super._();

  @override
  final InputString name;
  @override
  final UsernameFormStatus status;

  @override
  String toString() {
    return 'UsernameForm(name: $name, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsernameFormImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UsernameFormImplCopyWith<_$UsernameFormImpl> get copyWith =>
      __$$UsernameFormImplCopyWithImpl<_$UsernameFormImpl>(this, _$identity);
}

abstract class _UsernameForm extends UsernameForm {
  factory _UsernameForm(
      {required final InputString name,
      required final UsernameFormStatus status}) = _$UsernameFormImpl;
  _UsernameForm._() : super._();

  @override
  InputString get name;
  @override
  UsernameFormStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$UsernameFormImplCopyWith<_$UsernameFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}