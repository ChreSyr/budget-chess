import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/crud/sub_collection_crud.dart';

class _ChallengeFilterCRUD extends SubCollectionCRUD<ChallengeFilterModel> {
  _ChallengeFilterCRUD()
      : super(
          parentCollectionName: userCRUD.collectionName,
          collectionName: 'challengeFilter',
        );

  @override
  ChallengeFilterModel? jsonToModel(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? _,
  ) {
    try {
      final json = snapshot.data() ?? {};
      json['userId'] = snapshot.reference.parent.parent?.id ?? '';
      json['id'] = snapshot.id;
      return ChallengeFilterModel.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, Object?> modelToJson(ChallengeFilterModel? data, SetOptions? _) {
    return (data?.toJson()
          ?..removeWhere(
            (key, value) => key == 'id' || key == 'userId' || value == null,
          )) ??
        {};
  }

  void onAccountCreation(String authUid) {
    challengeFilterCRUD
      ..create(
        parentDocumentId: authUid,
        documentId: '1',
        data: ChallengeFilterModel.default1,
      )
      ..create(
        parentDocumentId: authUid,
        documentId: '2',
        data: ChallengeFilterModel.default2,
      )
      ..create(
        parentDocumentId: authUid,
        documentId: '3',
        data: ChallengeFilterModel.default3,
      );
  }
}

final challengeFilterCRUD = _ChallengeFilterCRUD();
