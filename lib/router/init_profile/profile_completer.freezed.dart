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
  ProfileFormStep get step => throw _privateConstructorUsedError;

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
  $Res call(
      {InputString name,
      InputString photo,
      ProfileFormStatus status,
      ProfileFormStep step});
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
    Object? step = null,
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
      step: null == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as ProfileFormStep,
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
  $Res call(
      {InputString name,
      InputString photo,
      ProfileFormStatus status,
      ProfileFormStep step});
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
    Object? step = null,
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
      step: null == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as ProfileFormStep,
    ));
  }
}

/// @nodoc

class _$ProfileFormImpl extends _ProfileForm with DiagnosticableTreeMixin {
  _$ProfileFormImpl(
      {required this.name,
      required this.photo,
      required this.status,
      required this.step})
      : super._();

  @override
  final InputString name;
  @override
  final InputString photo;
  @override
  final ProfileFormStatus status;
  @override
  final ProfileFormStep step;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProfileForm(name: $name, photo: $photo, status: $status, step: $step)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProfileForm'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('photo', photo))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('step', step));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileFormImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.step, step) || other.step == step));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, photo, status, step);

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
      required final ProfileFormStatus status,
      required final ProfileFormStep step}) = _$ProfileFormImpl;
  _ProfileForm._() : super._();

  @override
  InputString get name;
  @override
  InputString get photo;
  @override
  ProfileFormStatus get status;
  @override
  ProfileFormStep get step;
  @override
  @JsonKey(ignore: true)
  _$$ProfileFormImplCopyWith<_$ProfileFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
