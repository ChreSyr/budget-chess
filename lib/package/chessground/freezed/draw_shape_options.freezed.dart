// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'draw_shape_options.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DrawShapeOptions _$DrawShapeOptionsFromJson(Map<String, dynamic> json) {
  return _DrawShapeOptions.fromJson(json);
}

/// @nodoc
mixin _$DrawShapeOptions {
  /// Whether to enable shape drawing.
  bool get enable => throw _privateConstructorUsedError;

  /// The color of the shape being drawn.
  ///
  /// Default to lichess.org green.
  @ColorConverter()
  Color get newShapeColor => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DrawShapeOptionsCopyWith<DrawShapeOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrawShapeOptionsCopyWith<$Res> {
  factory $DrawShapeOptionsCopyWith(
          DrawShapeOptions value, $Res Function(DrawShapeOptions) then) =
      _$DrawShapeOptionsCopyWithImpl<$Res, DrawShapeOptions>;
  @useResult
  $Res call({bool enable, @ColorConverter() Color newShapeColor});
}

/// @nodoc
class _$DrawShapeOptionsCopyWithImpl<$Res, $Val extends DrawShapeOptions>
    implements $DrawShapeOptionsCopyWith<$Res> {
  _$DrawShapeOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enable = null,
    Object? newShapeColor = null,
  }) {
    return _then(_value.copyWith(
      enable: null == enable
          ? _value.enable
          : enable // ignore: cast_nullable_to_non_nullable
              as bool,
      newShapeColor: null == newShapeColor
          ? _value.newShapeColor
          : newShapeColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DrawShapeOptionsImplCopyWith<$Res>
    implements $DrawShapeOptionsCopyWith<$Res> {
  factory _$$DrawShapeOptionsImplCopyWith(_$DrawShapeOptionsImpl value,
          $Res Function(_$DrawShapeOptionsImpl) then) =
      __$$DrawShapeOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool enable, @ColorConverter() Color newShapeColor});
}

/// @nodoc
class __$$DrawShapeOptionsImplCopyWithImpl<$Res>
    extends _$DrawShapeOptionsCopyWithImpl<$Res, _$DrawShapeOptionsImpl>
    implements _$$DrawShapeOptionsImplCopyWith<$Res> {
  __$$DrawShapeOptionsImplCopyWithImpl(_$DrawShapeOptionsImpl _value,
      $Res Function(_$DrawShapeOptionsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enable = null,
    Object? newShapeColor = null,
  }) {
    return _then(_$DrawShapeOptionsImpl(
      enable: null == enable
          ? _value.enable
          : enable // ignore: cast_nullable_to_non_nullable
              as bool,
      newShapeColor: null == newShapeColor
          ? _value.newShapeColor
          : newShapeColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DrawShapeOptionsImpl implements _DrawShapeOptions {
  const _$DrawShapeOptionsImpl(
      {this.enable = false,
      @ColorConverter() this.newShapeColor = const Color(0xAA15781b)});

  factory _$DrawShapeOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DrawShapeOptionsImplFromJson(json);

  /// Whether to enable shape drawing.
  @override
  @JsonKey()
  final bool enable;

  /// The color of the shape being drawn.
  ///
  /// Default to lichess.org green.
  @override
  @JsonKey()
  @ColorConverter()
  final Color newShapeColor;

  @override
  String toString() {
    return 'DrawShapeOptions(enable: $enable, newShapeColor: $newShapeColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrawShapeOptionsImpl &&
            (identical(other.enable, enable) || other.enable == enable) &&
            (identical(other.newShapeColor, newShapeColor) ||
                other.newShapeColor == newShapeColor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, enable, newShapeColor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DrawShapeOptionsImplCopyWith<_$DrawShapeOptionsImpl> get copyWith =>
      __$$DrawShapeOptionsImplCopyWithImpl<_$DrawShapeOptionsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DrawShapeOptionsImplToJson(
      this,
    );
  }
}

abstract class _DrawShapeOptions implements DrawShapeOptions {
  const factory _DrawShapeOptions(
      {final bool enable,
      @ColorConverter() final Color newShapeColor}) = _$DrawShapeOptionsImpl;

  factory _DrawShapeOptions.fromJson(Map<String, dynamic> json) =
      _$DrawShapeOptionsImpl.fromJson;

  @override

  /// Whether to enable shape drawing.
  bool get enable;
  @override

  /// The color of the shape being drawn.
  ///
  /// Default to lichess.org green.
  @ColorConverter()
  Color get newShapeColor;
  @override
  @JsonKey(ignore: true)
  _$$DrawShapeOptionsImplCopyWith<_$DrawShapeOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
