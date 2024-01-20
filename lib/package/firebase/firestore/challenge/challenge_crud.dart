// Usage for ChallengeCRUD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/firebase/firestore/challenge/challenge_model.dart';
import 'package:crea_chess/package/firebase/firestore/crud/collection_crud.dart';

class ChallengeCRUD extends CollectionCRUD<ChallengeModel> {
  ChallengeCRUD()
      : super(
          collectionName: 'challenge',
          toFirestore: (
            ChallengeModel data,
            SetOptions? _,
          ) =>
              data.toFirestore(),
          fromFirestore: (
            DocumentSnapshot<Map<String, dynamic>> snapshot,
            SnapshotOptions? _,
          ) =>
              ChallengeModel.fromFirestore(snapshot),
        );
}

final challengeCRUD = ChallengeCRUD();
