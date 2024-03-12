// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'modify_username_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ModifyUsernameForm {
  InputString get name => throw _privateConstructorUsedError;
  ModifyUsernameStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ModifyUsernameFormCopyWith<ModifyUsernameForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModifyUsernameFormCopyWith<$Res> {
  factory $ModifyUsernameFormCopyWith(
          ModifyUsernameForm value, $Res Function(ModifyUsernameForm) then) =
      _$ModifyUsernameFormCopyWithImpl<$Res, ModifyUsernameForm>;
  @useResult
  $Res call({InputString name, ModifyUsernameStatus status});
}

/// @nodoc
class _$ModifyUsernameFormCopyWithImpl<$Res, $Val extends ModifyUsernameForm>
    implements $ModifyUsernameFormCopyWith<$Res> {
  _$ModifyUsernameFormCopyWithImpl(this._value, this._then);

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
              as ModifyUsernameStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ModifyUsernameFormImplCopyWith<$Res>
    implements $ModifyUsernameFormCopyWith<$Res> {
  factory _$$ModifyUsernameFormImplCopyWith(_$ModifyUsernameFormImpl value,
          $Res Function(_$ModifyUsernameFormImpl) then) =
      __$$ModifyUsernameFormImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({InputString name, ModifyUsernameStatus status});
}

/// @nodoc
class __$$ModifyUsernameFormImplCopyWithImpl<$Res>
    extends _$ModifyUsernameFormCopyWithImpl<$Res, _$ModifyUsernameFormImpl>
    implements _$$ModifyUsernameFormImplCopyWith<$Res> {
  __$$ModifyUsernameFormImplCopyWithImpl(_$ModifyUsernameFormImpl _value,
      $Res Function(_$ModifyUsernameFormImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? status = null,
  }) {
    return _then(_$ModifyUsernameFormImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as InputString,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ModifyUsernameStatus,
    ));
  }
}

/// @nodoc

class _$ModifyUsernameFormImpl extends _ModifyUsernameForm {
  _$ModifyUsernameFormImpl({required this.name, required this.status})
      : super._();

  @override
  final InputString name;
  @override
  final ModifyUsernameStatus status;

  @override
  String toString() {
    return 'ModifyUsernameForm(name: $name, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModifyUsernameFormImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ModifyUsernameFormImplCopyWith<_$ModifyUsernameFormImpl> get copyWith =>
      __$$ModifyUsernameFormImplCopyWithImpl<_$ModifyUsernameFormImpl>(
          this, _$identity);
}

abstract class _ModifyUsernameForm extends ModifyUsernameForm {
  factory _ModifyUsernameForm(
      {required final InputString name,
      required final ModifyUsernameStatus status}) = _$ModifyUsernameFormImpl;
  _ModifyUsernameForm._() : super._();

  @override
  InputString get name;
  @override
  ModifyUsernameStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$ModifyUsernameFormImplCopyWith<_$ModifyUsernameFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
