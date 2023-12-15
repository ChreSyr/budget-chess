// Usage for ChallengeCRUD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/firebase/firestore/challenge/challenge_model.dart';
import 'package:crea_chess/package/firebase/firestore/crud/base_crud.dart';
import 'package:crea_chess/package/firebase/firestore/crud/model_converter.dart';

class ChallengeModelConverter implements ModelConverter<ChallengeModel> {
  @override
  ChallengeModel fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? _,
  ) {
    return ChallengeModel.fromFirestore(snapshot);
  }

  @override
  Map<String, dynamic> toFirestore(ChallengeModel data, SetOptions? _) {
    return data.toFirestore();
  }

  @override
  ChallengeModel emptyModel() {
    return ChallengeModel();
  }
}

class ChallengeCRUD extends BaseCRUD<ChallengeModel> {
  ChallengeCRUD() : super('challenges', ChallengeModelConverter());
}

final challengeCRUD = ChallengeCRUD();
