import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/crud/sub_collection_crud.dart';

class _ChallengeFilterCRUD extends SubCollectionCRUD<ChallengeFilterModel> {
  _ChallengeFilterCRUD()
      : super(
          parentCollectionName: userCRUD.collectionName,
          collectionName: 'challengeFilter',
          toFirestore: (
            ChallengeFilterModel data,
            SetOptions? _,
          ) =>
              data.toFirestore(),
          fromFirestore: (
            DocumentSnapshot<Map<String, dynamic>> snapshot,
            SnapshotOptions? _,
          ) =>
              ChallengeFilterModel.fromFirestore(snapshot),
        );
}

final challengeFilterCRUD = _ChallengeFilterCRUD();
