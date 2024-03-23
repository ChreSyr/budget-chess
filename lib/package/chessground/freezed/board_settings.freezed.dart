// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BoardSettings _$BoardSettingsFromJson(Map<String, dynamic> json) {
  return _BoardSettings.fromJson(json);
}

/// @nodoc
mixin _$BoardSettings {
  /// Theme of the board
  BoardTheme get boardTheme => throw _privateConstructorUsedError;

  /// Piece set
  PieceSet get pieceSet => throw _privateConstructorUsedError;

  /// Whether to show board coordinates
  bool get enableCoordinates => throw _privateConstructorUsedError;

  /// Piece animation duration
  Duration get animationDuration => throw _privateConstructorUsedError;

  /// Whether to show last move highlight
  bool get showLastMove => throw _privateConstructorUsedError;

  /// Whether to show valid moves
  bool get showValidMoves => throw _privateConstructorUsedError;

  /// Pieces are hidden in blindfold mode
  bool get blindfoldMode =>
      throw _privateConstructorUsedError; // Scale up factor for the piece currently under drag
  double get dragFeedbackSize =>
      throw _privateConstructorUsedError; // Offset for the piece currently under drag
  @OffsetConverter()
  Offset get dragFeedbackOffset => throw _privateConstructorUsedError;

  /// Shape drawing options object containing data about how new shapes can be
  /// drawn.
  @DrawShapeOptionsConverter()
  DrawShapeOptions get drawShape => throw _privateConstructorUsedError;

  /// Whether castling is enabled with a premove.
  bool get enablePremoveCastling => throw _privateConstructorUsedError;

  /// If true the promotion selector won't appear and pawn will be promoted
// automatically to queen
  bool get autoQueenPromotion => throw _privateConstructorUsedError;

  /// If true the promotion selector won't appear and pawn will be promoted
  /// automatically to queen only if the premove is confirmed
  bool get autoQueenPromotionOnPremove => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BoardSettingsCopyWith<BoardSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoardSettingsCopyWith<$Res> {
  factory $BoardSettingsCopyWith(
          BoardSettings value, $Res Function(BoardSettings) then) =
      _$BoardSettingsCopyWithImpl<$Res, BoardSettings>;
  @useResult
  $Res call(
      {BoardTheme boardTheme,
      PieceSet pieceSet,
      bool enableCoordinates,
      Duration animationDuration,
      bool showLastMove,
      bool showValidMoves,
      bool blindfoldMode,
      double dragFeedbackSize,
      @OffsetConverter() Offset dragFeedbackOffset,
      @DrawShapeOptionsConverter() DrawShapeOptions drawShape,
      bool enablePremoveCastling,
      bool autoQueenPromotion,
      bool autoQueenPromotionOnPremove});

  $DrawShapeOptionsCopyWith<$Res> get drawShape;
}

/// @nodoc
class _$BoardSettingsCopyWithImpl<$Res, $Val extends BoardSettings>
    implements $BoardSettingsCopyWith<$Res> {
  _$BoardSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? boardTheme = null,
    Object? pieceSet = null,
    Object? enableCoordinates = null,
    Object? animationDuration = null,
    Object? showLastMove = null,
    Object? showValidMoves = null,
    Object? blindfoldMode = null,
    Object? dragFeedbackSize = null,
    Object? dragFeedbackOffset = null,
    Object? drawShape = null,
    Object? enablePremoveCastling = null,
    Object? autoQueenPromotion = null,
    Object? autoQueenPromotionOnPremove = null,
  }) {
    return _then(_value.copyWith(
      boardTheme: null == boardTheme
          ? _value.boardTheme
          : boardTheme // ignore: cast_nullable_to_non_nullable
              as BoardTheme,
      pieceSet: null == pieceSet
          ? _value.pieceSet
          : pieceSet // ignore: cast_nullable_to_non_nullable
              as PieceSet,
      enableCoordinates: null == enableCoordinates
          ? _value.enableCoordinates
          : enableCoordinates // ignore: cast_nullable_to_non_nullable
              as bool,
      animationDuration: null == animationDuration
          ? _value.animationDuration
          : animationDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      showLastMove: null == showLastMove
          ? _value.showLastMove
          : showLastMove // ignore: cast_nullable_to_non_nullable
              as bool,
      showValidMoves: null == showValidMoves
          ? _value.showValidMoves
          : showValidMoves // ignore: cast_nullable_to_non_nullable
              as bool,
      blindfoldMode: null == blindfoldMode
          ? _value.blindfoldMode
          : blindfoldMode // ignore: cast_nullable_to_non_nullable
              as bool,
      dragFeedbackSize: null == dragFeedbackSize
          ? _value.dragFeedbackSize
          : dragFeedbackSize // ignore: cast_nullable_to_non_nullable
              as double,
      dragFeedbackOffset: null == dragFeedbackOffset
          ? _value.dragFeedbackOffset
          : dragFeedbackOffset // ignore: cast_nullable_to_non_nullable
              as Offset,
      drawShape: null == drawShape
          ? _value.drawShape
          : drawShape // ignore: cast_nullable_to_non_nullable
              as DrawShapeOptions,
      enablePremoveCastling: null == enablePremoveCastling
          ? _value.enablePremoveCastling
          : enablePremoveCastling // ignore: cast_nullable_to_non_nullable
              as bool,
      autoQueenPromotion: null == autoQueenPromotion
          ? _value.autoQueenPromotion
          : autoQueenPromotion // ignore: cast_nullable_to_non_nullable
              as bool,
      autoQueenPromotionOnPremove: null == autoQueenPromotionOnPremove
          ? _value.autoQueenPromotionOnPremove
          : autoQueenPromotionOnPremove // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DrawShapeOptionsCopyWith<$Res> get drawShape {
    return $DrawShapeOptionsCopyWith<$Res>(_value.drawShape, (value) {
      return _then(_value.copyWith(drawShape: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BoardSettingsImplCopyWith<$Res>
    implements $BoardSettingsCopyWith<$Res> {
  factory _$$BoardSettingsImplCopyWith(
          _$BoardSettingsImpl value, $Res Function(_$BoardSettingsImpl) then) =
      __$$BoardSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BoardTheme boardTheme,
      PieceSet pieceSet,
      bool enableCoordinates,
      Duration animationDuration,
      bool showLastMove,
      bool showValidMoves,
      bool blindfoldMode,
      double dragFeedbackSize,
      @OffsetConverter() Offset dragFeedbackOffset,
      @DrawShapeOptionsConverter() DrawShapeOptions drawShape,
      bool enablePremoveCastling,
      bool autoQueenPromotion,
      bool autoQueenPromotionOnPremove});

  @override
  $DrawShapeOptionsCopyWith<$Res> get drawShape;
}

/// @nodoc
class __$$BoardSettingsImplCopyWithImpl<$Res>
    extends _$BoardSettingsCopyWithImpl<$Res, _$BoardSettingsImpl>
    implements _$$BoardSettingsImplCopyWith<$Res> {
  __$$BoardSettingsImplCopyWithImpl(
      _$BoardSettingsImpl _value, $Res Function(_$BoardSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? boardTheme = null,
    Object? pieceSet = null,
    Object? enableCoordinates = null,
    Object? animationDuration = null,
    Object? showLastMove = null,
    Object? showValidMoves = null,
    Object? blindfoldMode = null,
    Object? dragFeedbackSize = null,
    Object? dragFeedbackOffset = null,
    Object? drawShape = null,
    Object? enablePremoveCastling = null,
    Object? autoQueenPromotion = null,
    Object? autoQueenPromotionOnPremove = null,
  }) {
    return _then(_$BoardSettingsImpl(
      boardTheme: null == boardTheme
          ? _value.boardTheme
          : boardTheme // ignore: cast_nullable_to_non_nullable
              as BoardTheme,
      pieceSet: null == pieceSet
          ? _value.pieceSet
          : pieceSet // ignore: cast_nullable_to_non_nullable
              as PieceSet,
      enableCoordinates: null == enableCoordinates
          ? _value.enableCoordinates
          : enableCoordinates // ignore: cast_nullable_to_non_nullable
              as bool,
      animationDuration: null == animationDuration
          ? _value.animationDuration
          : animationDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      showLastMove: null == showLastMove
          ? _value.showLastMove
          : showLastMove // ignore: cast_nullable_to_non_nullable
              as bool,
      showValidMoves: null == showValidMoves
          ? _value.showValidMoves
          : showValidMoves // ignore: cast_nullable_to_non_nullable
              as bool,
      blindfoldMode: null == blindfoldMode
          ? _value.blindfoldMode
          : blindfoldMode // ignore: cast_nullable_to_non_nullable
              as bool,
      dragFeedbackSize: null == dragFeedbackSize
          ? _value.dragFeedbackSize
          : dragFeedbackSize // ignore: cast_nullable_to_non_nullable
              as double,
      dragFeedbackOffset: null == dragFeedbackOffset
          ? _value.dragFeedbackOffset
          : dragFeedbackOffset // ignore: cast_nullable_to_non_nullable
              as Offset,
      drawShape: null == drawShape
          ? _value.drawShape
          : drawShape // ignore: cast_nullable_to_non_nullable
              as DrawShapeOptions,
      enablePremoveCastling: null == enablePremoveCastling
          ? _value.enablePremoveCastling
          : enablePremoveCastling // ignore: cast_nullable_to_non_nullable
              as bool,
      autoQueenPromotion: null == autoQueenPromotion
          ? _value.autoQueenPromotion
          : autoQueenPromotion // ignore: cast_nullable_to_non_nullable
              as bool,
      autoQueenPromotionOnPremove: null == autoQueenPromotionOnPremove
          ? _value.autoQueenPromotionOnPremove
          : autoQueenPromotionOnPremove // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BoardSettingsImpl implements _BoardSettings {
  const _$BoardSettingsImpl(
      {this.boardTheme = BoardTheme.brown1,
      this.pieceSet = PieceSet.frenzy,
      this.enableCoordinates = true,
      this.animationDuration = const Duration(milliseconds: 250),
      this.showLastMove = true,
      this.showValidMoves = true,
      this.blindfoldMode = false,
      this.dragFeedbackSize = 2.0,
      @OffsetConverter() this.dragFeedbackOffset = const Offset(0, -1),
      @DrawShapeOptionsConverter() this.drawShape = const DrawShapeOptions(),
      this.enablePremoveCastling = true,
      this.autoQueenPromotion = false,
      this.autoQueenPromotionOnPremove = true});

  factory _$BoardSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoardSettingsImplFromJson(json);

  /// Theme of the board
  @override
  @JsonKey()
  final BoardTheme boardTheme;

  /// Piece set
  @override
  @JsonKey()
  final PieceSet pieceSet;

  /// Whether to show board coordinates
  @override
  @JsonKey()
  final bool enableCoordinates;

  /// Piece animation duration
  @override
  @JsonKey()
  final Duration animationDuration;

  /// Whether to show last move highlight
  @override
  @JsonKey()
  final bool showLastMove;

  /// Whether to show valid moves
  @override
  @JsonKey()
  final bool showValidMoves;

  /// Pieces are hidden in blindfold mode
  @override
  @JsonKey()
  final bool blindfoldMode;
// Scale up factor for the piece currently under drag
  @override
  @JsonKey()
  final double dragFeedbackSize;
// Offset for the piece currently under drag
  @override
  @JsonKey()
  @OffsetConverter()
  final Offset dragFeedbackOffset;

  /// Shape drawing options object containing data about how new shapes can be
  /// drawn.
  @override
  @JsonKey()
  @DrawShapeOptionsConverter()
  final DrawShapeOptions drawShape;

  /// Whether castling is enabled with a premove.
  @override
  @JsonKey()
  final bool enablePremoveCastling;

  /// If true the promotion selector won't appear and pawn will be promoted
// automatically to queen
  @override
  @JsonKey()
  final bool autoQueenPromotion;

  /// If true the promotion selector won't appear and pawn will be promoted
  /// automatically to queen only if the premove is confirmed
  @override
  @JsonKey()
  final bool autoQueenPromotionOnPremove;

  @override
  String toString() {
    return 'BoardSettings(boardTheme: $boardTheme, pieceSet: $pieceSet, enableCoordinates: $enableCoordinates, animationDuration: $animationDuration, showLastMove: $showLastMove, showValidMoves: $showValidMoves, blindfoldMode: $blindfoldMode, dragFeedbackSize: $dragFeedbackSize, dragFeedbackOffset: $dragFeedbackOffset, drawShape: $drawShape, enablePremoveCastling: $enablePremoveCastling, autoQueenPromotion: $autoQueenPromotion, autoQueenPromotionOnPremove: $autoQueenPromotionOnPremove)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoardSettingsImpl &&
            (identical(other.boardTheme, boardTheme) ||
                other.boardTheme == boardTheme) &&
            (identical(other.pieceSet, pieceSet) ||
                other.pieceSet == pieceSet) &&
            (identical(other.enableCoordinates, enableCoordinates) ||
                other.enableCoordinates == enableCoordinates) &&
            (identical(other.animationDuration, animationDuration) ||
                other.animationDuration == animationDuration) &&
            (identical(other.showLastMove, showLastMove) ||
                other.showLastMove == showLastMove) &&
            (identical(other.showValidMoves, showValidMoves) ||
                other.showValidMoves == showValidMoves) &&
            (identical(other.blindfoldMode, blindfoldMode) ||
                other.blindfoldMode == blindfoldMode) &&
            (identical(other.dragFeedbackSize, dragFeedbackSize) ||
                other.dragFeedbackSize == dragFeedbackSize) &&
            (identical(other.dragFeedbackOffset, dragFeedbackOffset) ||
                other.dragFeedbackOffset == dragFeedbackOffset) &&
            (identical(other.drawShape, drawShape) ||
                other.drawShape == drawShape) &&
            (identical(other.enablePremoveCastling, enablePremoveCastling) ||
                other.enablePremoveCastling == enablePremoveCastling) &&
            (identical(other.autoQueenPromotion, autoQueenPromotion) ||
                other.autoQueenPromotion == autoQueenPromotion) &&
            (identical(other.autoQueenPromotionOnPremove,
                    autoQueenPromotionOnPremove) ||
                other.autoQueenPromotionOnPremove ==
                    autoQueenPromotionOnPremove));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      boardTheme,
      pieceSet,
      enableCoordinates,
      animationDuration,
      showLastMove,
      showValidMoves,
      blindfoldMode,
      dragFeedbackSize,
      dragFeedbackOffset,
      drawShape,
      enablePremoveCastling,
      autoQueenPromotion,
      autoQueenPromotionOnPremove);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BoardSettingsImplCopyWith<_$BoardSettingsImpl> get copyWith =>
      __$$BoardSettingsImplCopyWithImpl<_$BoardSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BoardSettingsImplToJson(
      this,
    );
  }
}

abstract class _BoardSettings implements BoardSettings {
  const factory _BoardSettings(
      {final BoardTheme boardTheme,
      final PieceSet pieceSet,
      final bool enableCoordinates,
      final Duration animationDuration,
      final bool showLastMove,
      final bool showValidMoves,
      final bool blindfoldMode,
      final double dragFeedbackSize,
      @OffsetConverter() final Offset dragFeedbackOffset,
      @DrawShapeOptionsConverter() final DrawShapeOptions drawShape,
      final bool enablePremoveCastling,
      final bool autoQueenPromotion,
      final bool autoQueenPromotionOnPremove}) = _$BoardSettingsImpl;

  factory _BoardSettings.fromJson(Map<String, dynamic> json) =
      _$BoardSettingsImpl.fromJson;

  @override

  /// Theme of the board
  BoardTheme get boardTheme;
  @override

  /// Piece set
  PieceSet get pieceSet;
  @override

  /// Whether to show board coordinates
  bool get enableCoordinates;
  @override

  /// Piece animation duration
  Duration get animationDuration;
  @override

  /// Whether to show last move highlight
  bool get showLastMove;
  @override

  /// Whether to show valid moves
  bool get showValidMoves;
  @override

  /// Pieces are hidden in blindfold mode
  bool get blindfoldMode;
  @override // Scale up factor for the piece currently under drag
  double get dragFeedbackSize;
  @override // Offset for the piece currently under drag
  @OffsetConverter()
  Offset get dragFeedbackOffset;
  @override

  /// Shape drawing options object containing data about how new shapes can be
  /// drawn.
  @DrawShapeOptionsConverter()
  DrawShapeOptions get drawShape;
  @override

  /// Whether castling is enabled with a premove.
  bool get enablePremoveCastling;
  @override

  /// If true the promotion selector won't appear and pawn will be promoted
// automatically to queen
  bool get autoQueenPromotion;
  @override

  /// If true the promotion selector won't appear and pawn will be promoted
  /// automatically to queen only if the premove is confirmed
  bool get autoQueenPromotionOnPremove;
  @override
  @JsonKey(ignore: true)
  _$$BoardSettingsImplCopyWith<_$BoardSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
