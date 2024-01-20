// ignore_for_file: public_member_api_docs, invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required String id, // same as auth
    DateTime? createdAt,
    String? username,
    String? usernameLowercase,
    String? photo,
    String? banner,
  }) = _UserModel;

  /// Required for the override getter
  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final json = doc.data() ?? {};
    json['id'] = doc.id;
    return UserModel.fromJson(json);
  }

  Map<String, dynamic> toFirestore() =>
      toJson()..removeWhere((key, value) => key == 'id' || value == null);

  // ---
}
