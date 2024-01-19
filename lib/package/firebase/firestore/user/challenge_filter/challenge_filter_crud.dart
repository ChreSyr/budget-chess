// ignore_for_file: comment_references

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/crud/model_converter.dart';
import 'package:crea_chess/package/firebase/firestore/crud/sub_collection_crud.dart';

class _ChallengeFilterModelConverter
    implements ModelConverter<ChallengeFilterModel> {
  @override
  ChallengeFilterModel fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? _,
  ) {
    return ChallengeFilterModel.fromFirestore(snapshot);
  }

  @override
  Map<String, dynamic> toFirestore(ChallengeFilterModel data, SetOptions? _) {
    return data.toFirestore();
  }
}

class _ChallengeFilterCRUD extends SubCollectionCRUD<ChallengeFilterModel> {
  _ChallengeFilterCRUD()
      : super(
          userCRUD.collectionName,
          'challengeFilter',
          _ChallengeFilterModelConverter(),
        );
}

final challengeFilterCRUD = _ChallengeFilterCRUD();
