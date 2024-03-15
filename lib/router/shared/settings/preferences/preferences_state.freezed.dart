// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'preferences_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PreferencesState _$PreferencesStateFromJson(Map<String, dynamic> json) {
  return _PreferencesState.fromJson(json);
}

/// @nodoc
mixin _$PreferencesState {
  Brightness get brightness => throw _privateConstructorUsedError;
  @JsonKey(name: 'language_code')
  String get languageCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'seed_color')
  SeedColor get seedColor => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PreferencesStateCopyWith<PreferencesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreferencesStateCopyWith<$Res> {
  factory $PreferencesStateCopyWith(
          PreferencesState value, $Res Function(PreferencesState) then) =
      _$PreferencesStateCopyWithImpl<$Res, PreferencesState>;
  @useResult
  $Res call(
      {Brightness brightness,
      @JsonKey(name: 'language_code') String languageCode,
      @JsonKey(name: 'seed_color') SeedColor seedColor});
}

/// @nodoc
class _$PreferencesStateCopyWithImpl<$Res, $Val extends PreferencesState>
    implements $PreferencesStateCopyWith<$Res> {
  _$PreferencesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brightness = null,
    Object? languageCode = null,
    Object? seedColor = null,
  }) {
    return _then(_value.copyWith(
      brightness: null == brightness
          ? _value.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as Brightness,
      languageCode: null == languageCode
          ? _value.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String,
      seedColor: null == seedColor
          ? _value.seedColor
          : seedColor // ignore: cast_nullable_to_non_nullable
              as SeedColor,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PreferencesStateImplCopyWith<$Res>
    implements $PreferencesStateCopyWith<$Res> {
  factory _$$PreferencesStateImplCopyWith(_$PreferencesStateImpl value,
          $Res Function(_$PreferencesStateImpl) then) =
      __$$PreferencesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Brightness brightness,
      @JsonKey(name: 'language_code') String languageCode,
      @JsonKey(name: 'seed_color') SeedColor seedColor});
}

/// @nodoc
class __$$PreferencesStateImplCopyWithImpl<$Res>
    extends _$PreferencesStateCopyWithImpl<$Res, _$PreferencesStateImpl>
    implements _$$PreferencesStateImplCopyWith<$Res> {
  __$$PreferencesStateImplCopyWithImpl(_$PreferencesStateImpl _value,
      $Res Function(_$PreferencesStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brightness = null,
    Object? languageCode = null,
    Object? seedColor = null,
  }) {
    return _then(_$PreferencesStateImpl(
      brightness: null == brightness
          ? _value.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as Brightness,
      languageCode: null == languageCode
          ? _value.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String,
      seedColor: null == seedColor
          ? _value.seedColor
          : seedColor // ignore: cast_nullable_to_non_nullable
              as SeedColor,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PreferencesStateImpl extends _PreferencesState {
  _$PreferencesStateImpl(
      {required this.brightness,
      @JsonKey(name: 'language_code') required this.languageCode,
      @JsonKey(name: 'seed_color') required this.seedColor})
      : super._();

  factory _$PreferencesStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PreferencesStateImplFromJson(json);

  @override
  final Brightness brightness;
  @override
  @JsonKey(name: 'language_code')
  final String languageCode;
  @override
  @JsonKey(name: 'seed_color')
  final SeedColor seedColor;

  @override
  String toString() {
    return 'PreferencesState(brightness: $brightness, languageCode: $languageCode, seedColor: $seedColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreferencesStateImpl &&
            (identical(other.brightness, brightness) ||
                other.brightness == brightness) &&
            (identical(other.languageCode, languageCode) ||
                other.languageCode == languageCode) &&
            (identical(other.seedColor, seedColor) ||
                other.seedColor == seedColor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, brightness, languageCode, seedColor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PreferencesStateImplCopyWith<_$PreferencesStateImpl> get copyWith =>
      __$$PreferencesStateImplCopyWithImpl<_$PreferencesStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PreferencesStateImplToJson(
      this,
    );
  }
}

abstract class _PreferencesState extends PreferencesState {
  factory _PreferencesState(
          {required final Brightness brightness,
          @JsonKey(name: 'language_code') required final String languageCode,
          @JsonKey(name: 'seed_color') required final SeedColor seedColor}) =
      _$PreferencesStateImpl;
  _PreferencesState._() : super._();

  factory _PreferencesState.fromJson(Map<String, dynamic> json) =
      _$PreferencesStateImpl.fromJson;

  @override
  Brightness get brightness;
  @override
  @JsonKey(name: 'language_code')
  String get languageCode;
  @override
  @JsonKey(name: 'seed_color')
  SeedColor get seedColor;
  @override
  @JsonKey(ignore: true)
  _$$PreferencesStateImplCopyWith<_$PreferencesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
