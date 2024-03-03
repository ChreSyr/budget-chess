// ignore_for_file: public_member_api_docs, invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required String id, // same as auth
    required String username,
    DateTime? createdAt,
    String? usernameLowercase,
    String? photo,
    String? banner,
    bool? isConnected,
  }) = _UserModel;

  /// Required for the override getter
  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  // ---
}
