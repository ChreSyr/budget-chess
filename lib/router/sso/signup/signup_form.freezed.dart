// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SignupForm {
  InputString get email => throw _privateConstructorUsedError;
  InputString get password => throw _privateConstructorUsedError;
  SignupStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignupFormCopyWith<SignupForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupFormCopyWith<$Res> {
  factory $SignupFormCopyWith(
          SignupForm value, $Res Function(SignupForm) then) =
      _$SignupFormCopyWithImpl<$Res, SignupForm>;
  @useResult
  $Res call({InputString email, InputString password, SignupStatus status});
}

/// @nodoc
class _$SignupFormCopyWithImpl<$Res, $Val extends SignupForm>
    implements $SignupFormCopyWith<$Res> {
  _$SignupFormCopyWithImpl(this._value, this._then);

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
              as SignupStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignupFormImplCopyWith<$Res>
    implements $SignupFormCopyWith<$Res> {
  factory _$$SignupFormImplCopyWith(
          _$SignupFormImpl value, $Res Function(_$SignupFormImpl) then) =
      __$$SignupFormImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({InputString email, InputString password, SignupStatus status});
}

/// @nodoc
class __$$SignupFormImplCopyWithImpl<$Res>
    extends _$SignupFormCopyWithImpl<$Res, _$SignupFormImpl>
    implements _$$SignupFormImplCopyWith<$Res> {
  __$$SignupFormImplCopyWithImpl(
      _$SignupFormImpl _value, $Res Function(_$SignupFormImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? status = null,
  }) {
    return _then(_$SignupFormImpl(
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
              as SignupStatus,
    ));
  }
}

/// @nodoc

class _$SignupFormImpl extends _SignupForm {
  _$SignupFormImpl(
      {required this.email, required this.password, required this.status})
      : super._();

  @override
  final InputString email;
  @override
  final InputString password;
  @override
  final SignupStatus status;

  @override
  String toString() {
    return 'SignupForm(email: $email, password: $password, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupFormImpl &&
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
  _$$SignupFormImplCopyWith<_$SignupFormImpl> get copyWith =>
      __$$SignupFormImplCopyWithImpl<_$SignupFormImpl>(this, _$identity);
}

abstract class _SignupForm extends SignupForm {
  factory _SignupForm(
      {required final InputString email,
      required final InputString password,
      required final SignupStatus status}) = _$SignupFormImpl;
  _SignupForm._() : super._();

  @override
  InputString get email;
  @override
  InputString get password;
  @override
  SignupStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$SignupFormImplCopyWith<_$SignupFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
