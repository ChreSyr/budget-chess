// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_completer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileForm {
  InputString get name => throw _privateConstructorUsedError;
  InputString get photo => throw _privateConstructorUsedError;
  ProfileFormStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProfileFormCopyWith<ProfileForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileFormCopyWith<$Res> {
  factory $ProfileFormCopyWith(
          ProfileForm value, $Res Function(ProfileForm) then) =
      _$ProfileFormCopyWithImpl<$Res, ProfileForm>;
  @useResult
  $Res call({InputString name, InputString photo, ProfileFormStatus status});
}

/// @nodoc
class _$ProfileFormCopyWithImpl<$Res, $Val extends ProfileForm>
    implements $ProfileFormCopyWith<$Res> {
  _$ProfileFormCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? photo = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as InputString,
      photo: null == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as InputString,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProfileFormStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileFormImplCopyWith<$Res>
    implements $ProfileFormCopyWith<$Res> {
  factory _$$ProfileFormImplCopyWith(
          _$ProfileFormImpl value, $Res Function(_$ProfileFormImpl) then) =
      __$$ProfileFormImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({InputString name, InputString photo, ProfileFormStatus status});
}

/// @nodoc
class __$$ProfileFormImplCopyWithImpl<$Res>
    extends _$ProfileFormCopyWithImpl<$Res, _$ProfileFormImpl>
    implements _$$ProfileFormImplCopyWith<$Res> {
  __$$ProfileFormImplCopyWithImpl(
      _$ProfileFormImpl _value, $Res Function(_$ProfileFormImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? photo = null,
    Object? status = null,
  }) {
    return _then(_$ProfileFormImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as InputString,
      photo: null == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as InputString,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProfileFormStatus,
    ));
  }
}

/// @nodoc

class _$ProfileFormImpl extends _ProfileForm {
  _$ProfileFormImpl(
      {required this.name, required this.photo, required this.status})
      : super._();

  @override
  final InputString name;
  @override
  final InputString photo;
  @override
  final ProfileFormStatus status;

  @override
  String toString() {
    return 'ProfileForm(name: $name, photo: $photo, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileFormImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, photo, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileFormImplCopyWith<_$ProfileFormImpl> get copyWith =>
      __$$ProfileFormImplCopyWithImpl<_$ProfileFormImpl>(this, _$identity);
}

abstract class _ProfileForm extends ProfileForm {
  factory _ProfileForm(
      {required final InputString name,
      required final InputString photo,
      required final ProfileFormStatus status}) = _$ProfileFormImpl;
  _ProfileForm._() : super._();

  @override
  InputString get name;
  @override
  InputString get photo;
  @override
  ProfileFormStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$ProfileFormImplCopyWith<_$ProfileFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
