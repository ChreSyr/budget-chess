// ignore_for_file: public_member_api_docs, invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge_model.freezed.dart';
part 'challenge_model.g.dart';

enum ChallengeStatus { open, started, finished }

@freezed
class ChallengeModel with _$ChallengeModel {
  factory ChallengeModel({
    String? id,
    String? ref, // TODO : remove ?
    DateTime? createdAt,
    String? authorId,
    ChallengeStatus? status,
    int? time, // in seconds
    int? increment, // in seconds
    int? boardWidth,
    int? boardHeight,
    int? budget,
  }) = _ChallengeModel;

  /// Required for the override getter
  const ChallengeModel._();

  factory ChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeModelFromJson(json);

  factory ChallengeModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    return ChallengeModel.fromJson(doc.data() ?? {})
        .copyWith(id: doc.id, ref: doc.reference.path);
  }

  Map<String, dynamic> toFirestore() {
    return toJson()
      ..removeWhere((key, value) {
        return key == 'id' || key == 'ref' || value == null;
      });
  }
}
