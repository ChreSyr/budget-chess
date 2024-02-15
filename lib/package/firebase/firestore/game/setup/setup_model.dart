import 'package:chessground/chessground.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'setup_model.freezed.dart';
part 'setup_model.g.dart';

@freezed
class SetupModel with _$SetupModel {
  const factory SetupModel({
    required String halfFen,
    Side? betterWithSide,
  }) = _SetupModel;

  /// Required for the override getter
  const SetupModel._();

  factory SetupModel.fromJson(Map<String, dynamic> json) =>
      _$SetupModelFromJson(json);

  // ---
}
