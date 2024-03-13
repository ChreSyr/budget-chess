// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PhotoForm {
  InputString get photo => throw _privateConstructorUsedError;
  PhotoFormStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PhotoFormCopyWith<PhotoForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoFormCopyWith<$Res> {
  factory $PhotoFormCopyWith(PhotoForm value, $Res Function(PhotoForm) then) =
      _$PhotoFormCopyWithImpl<$Res, PhotoForm>;
  @useResult
  $Res call({InputString photo, PhotoFormStatus status});
}

/// @nodoc
class _$PhotoFormCopyWithImpl<$Res, $Val extends PhotoForm>
    implements $PhotoFormCopyWith<$Res> {
  _$PhotoFormCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photo = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      photo: null == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as InputString,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PhotoFormStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhotoFormImplCopyWith<$Res>
    implements $PhotoFormCopyWith<$Res> {
  factory _$$PhotoFormImplCopyWith(
          _$PhotoFormImpl value, $Res Function(_$PhotoFormImpl) then) =
      __$$PhotoFormImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({InputString photo, PhotoFormStatus status});
}

/// @nodoc
class __$$PhotoFormImplCopyWithImpl<$Res>
    extends _$PhotoFormCopyWithImpl<$Res, _$PhotoFormImpl>
    implements _$$PhotoFormImplCopyWith<$Res> {
  __$$PhotoFormImplCopyWithImpl(
      _$PhotoFormImpl _value, $Res Function(_$PhotoFormImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photo = null,
    Object? status = null,
  }) {
    return _then(_$PhotoFormImpl(
      photo: null == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as InputString,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PhotoFormStatus,
    ));
  }
}

/// @nodoc

class _$PhotoFormImpl extends _PhotoForm {
  _$PhotoFormImpl({required this.photo, required this.status}) : super._();

  @override
  final InputString photo;
  @override
  final PhotoFormStatus status;

  @override
  String toString() {
    return 'PhotoForm(photo: $photo, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhotoFormImpl &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, photo, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhotoFormImplCopyWith<_$PhotoFormImpl> get copyWith =>
      __$$PhotoFormImplCopyWithImpl<_$PhotoFormImpl>(this, _$identity);
}

abstract class _PhotoForm extends PhotoForm {
  factory _PhotoForm(
      {required final InputString photo,
      required final PhotoFormStatus status}) = _$PhotoFormImpl;
  _PhotoForm._() : super._();

  @override
  InputString get photo;
  @override
  PhotoFormStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$PhotoFormImplCopyWith<_$PhotoFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
