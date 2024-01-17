// Usage for ChallengeCRUD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/firebase/firestore/challenge/challenge_model.dart';
import 'package:crea_chess/package/firebase/firestore/crud/collection_crud.dart';
import 'package:crea_chess/package/firebase/firestore/crud/model_converter.dart';

class _ChallengeModelConverter implements ModelConverter<ChallengeModel> {
  const _ChallengeModelConverter();

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
}

class ChallengeCRUD extends CollectionCRUD<ChallengeModel> {
  ChallengeCRUD() : super('challenge', const _ChallengeModelConverter());
}

final challengeCRUD = ChallengeCRUD();
