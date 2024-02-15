// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signin_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SigninForm {
  InputString get email => throw _privateConstructorUsedError;
  InputString get password => throw _privateConstructorUsedError;
  SigninStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SigninFormCopyWith<SigninForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SigninFormCopyWith<$Res> {
  factory $SigninFormCopyWith(
          SigninForm value, $Res Function(SigninForm) then) =
      _$SigninFormCopyWithImpl<$Res, SigninForm>;
  @useResult
  $Res call({InputString email, InputString password, SigninStatus status});
}

/// @nodoc
class _$SigninFormCopyWithImpl<$Res, $Val extends SigninForm>
    implements $SigninFormCopyWith<$Res> {
  _$SigninFormCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as InputString,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as InputString,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SigninStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SigninFormImplCopyWith<$Res>
    implements $SigninFormCopyWith<$Res> {
  factory _$$SigninFormImplCopyWith(
          _$SigninFormImpl value, $Res Function(_$SigninFormImpl) then) =
      __$$SigninFormImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({InputString email, InputString password, SigninStatus status});
}

/// @nodoc
class __$$SigninFormImplCopyWithImpl<$Res>
    extends _$SigninFormCopyWithImpl<$Res, _$SigninFormImpl>
    implements _$$SigninFormImplCopyWith<$Res> {
  __$$SigninFormImplCopyWithImpl(
      _$SigninFormImpl _value, $Res Function(_$SigninFormImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? status = null,
  }) {
    return _then(_$SigninFormImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as InputString,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as InputString,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SigninStatus,
    ));
  }
}

/// @nodoc

class _$SigninFormImpl extends _SigninForm {
  _$SigninFormImpl(
      {required this.email, required this.password, required this.status})
      : super._();

  @override
  final InputString email;
  @override
  final InputString password;
  @override
  final SigninStatus status;

  @override
  String toString() {
    return 'SigninForm(email: $email, password: $password, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SigninFormImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SigninFormImplCopyWith<_$SigninFormImpl> get copyWith =>
      __$$SigninFormImplCopyWithImpl<_$SigninFormImpl>(this, _$identity);
}

abstract class _SigninForm extends SigninForm {
  factory _SigninForm(
      {required final InputString email,
      required final InputString password,
      required final SigninStatus status}) = _$SigninFormImpl;
  _SigninForm._() : super._();

  @override
  InputString get email;
  @override
  InputString get password;
  @override
  SigninStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$SigninFormImplCopyWith<_$SigninFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
