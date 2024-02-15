// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InventoryModel _$InventoryModelFromJson(Map<String, dynamic> json) {
  return _InventoryModel.fromJson(json);
}

/// @nodoc
mixin _$InventoryModel {
  String get id => throw _privateConstructorUsedError;
  String get ownerId => throw _privateConstructorUsedError;
  int get bishops => throw _privateConstructorUsedError;
  int get kings => throw _privateConstructorUsedError;
  int get knights => throw _privateConstructorUsedError;
  int get pawns => throw _privateConstructorUsedError;
  int get queens => throw _privateConstructorUsedError;
  int get rooks => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryModelCopyWith<InventoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryModelCopyWith<$Res> {
  factory $InventoryModelCopyWith(
          InventoryModel value, $Res Function(InventoryModel) then) =
      _$InventoryModelCopyWithImpl<$Res, InventoryModel>;
  @useResult
  $Res call(
      {String id,
      String ownerId,
      int bishops,
      int kings,
      int knights,
      int pawns,
      int queens,
      int rooks});
}

/// @nodoc
class _$InventoryModelCopyWithImpl<$Res, $Val extends InventoryModel>
    implements $InventoryModelCopyWith<$Res> {
  _$InventoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ownerId = null,
    Object? bishops = null,
    Object? kings = null,
    Object? knights = null,
    Object? pawns = null,
    Object? queens = null,
    Object? rooks = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      bishops: null == bishops
          ? _value.bishops
          : bishops // ignore: cast_nullable_to_non_nullable
              as int,
      kings: null == kings
          ? _value.kings
          : kings // ignore: cast_nullable_to_non_nullable
              as int,
      knights: null == knights
          ? _value.knights
          : knights // ignore: cast_nullable_to_non_nullable
              as int,
      pawns: null == pawns
          ? _value.pawns
          : pawns // ignore: cast_nullable_to_non_nullable
              as int,
      queens: null == queens
          ? _value.queens
          : queens // ignore: cast_nullable_to_non_nullable
              as int,
      rooks: null == rooks
          ? _value.rooks
          : rooks // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryModelImplCopyWith<$Res>
    implements $InventoryModelCopyWith<$Res> {
  factory _$$InventoryModelImplCopyWith(_$InventoryModelImpl value,
          $Res Function(_$InventoryModelImpl) then) =
      __$$InventoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String ownerId,
      int bishops,
      int kings,
      int knights,
      int pawns,
      int queens,
      int rooks});
}

/// @nodoc
class __$$InventoryModelImplCopyWithImpl<$Res>
    extends _$InventoryModelCopyWithImpl<$Res, _$InventoryModelImpl>
    implements _$$InventoryModelImplCopyWith<$Res> {
  __$$InventoryModelImplCopyWithImpl(
      _$InventoryModelImpl _value, $Res Function(_$InventoryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ownerId = null,
    Object? bishops = null,
    Object? kings = null,
    Object? knights = null,
    Object? pawns = null,
    Object? queens = null,
    Object? rooks = null,
  }) {
    return _then(_$InventoryModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      bishops: null == bishops
          ? _value.bishops
          : bishops // ignore: cast_nullable_to_non_nullable
              as int,
      kings: null == kings
          ? _value.kings
          : kings // ignore: cast_nullable_to_non_nullable
              as int,
      knights: null == knights
          ? _value.knights
          : knights // ignore: cast_nullable_to_non_nullable
              as int,
      pawns: null == pawns
          ? _value.pawns
          : pawns // ignore: cast_nullable_to_non_nullable
              as int,
      queens: null == queens
          ? _value.queens
          : queens // ignore: cast_nullable_to_non_nullable
              as int,
      rooks: null == rooks
          ? _value.rooks
          : rooks // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryModelImpl extends _InventoryModel {
  const _$InventoryModelImpl(
      {required this.id,
      required this.ownerId,
      this.bishops = 2,
      this.kings = 1,
      this.knights = 2,
      this.pawns = 8,
      this.queens = 1,
      this.rooks = 2})
      : super._();

  factory _$InventoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryModelImplFromJson(json);

  @override
  final String id;
  @override
  final String ownerId;
  @override
  @JsonKey()
  final int bishops;
  @override
  @JsonKey()
  final int kings;
  @override
  @JsonKey()
  final int knights;
  @override
  @JsonKey()
  final int pawns;
  @override
  @JsonKey()
  final int queens;
  @override
  @JsonKey()
  final int rooks;

  @override
  String toString() {
    return 'InventoryModel(id: $id, ownerId: $ownerId, bishops: $bishops, kings: $kings, knights: $knights, pawns: $pawns, queens: $queens, rooks: $rooks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.bishops, bishops) || other.bishops == bishops) &&
            (identical(other.kings, kings) || other.kings == kings) &&
            (identical(other.knights, knights) || other.knights == knights) &&
            (identical(other.pawns, pawns) || other.pawns == pawns) &&
            (identical(other.queens, queens) || other.queens == queens) &&
            (identical(other.rooks, rooks) || other.rooks == rooks));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, ownerId, bishops, kings, knights, pawns, queens, rooks);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryModelImplCopyWith<_$InventoryModelImpl> get copyWith =>
      __$$InventoryModelImplCopyWithImpl<_$InventoryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryModelImplToJson(
      this,
    );
  }
}

abstract class _InventoryModel extends InventoryModel {
  const factory _InventoryModel(
      {required final String id,
      required final String ownerId,
      final int bishops,
      final int kings,
      final int knights,
      final int pawns,
      final int queens,
      final int rooks}) = _$InventoryModelImpl;
  const _InventoryModel._() : super._();

  factory _InventoryModel.fromJson(Map<String, dynamic> json) =
      _$InventoryModelImpl.fromJson;

  @override
  String get id;
  @override
  String get ownerId;
  @override
  int get bishops;
  @override
  int get kings;
  @override
  int get knights;
  @override
  int get pawns;
  @override
  int get queens;
  @override
  int get rooks;
  @override
  @JsonKey(ignore: true)
  _$$InventoryModelImplCopyWith<_$InventoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
