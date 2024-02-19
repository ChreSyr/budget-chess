import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/firebase/firestore/crud/collection_crud.dart';
import 'package:crea_chess/package/firebase/firestore/game/challenge/challenge_model.dart';

class ChallengeCRUD extends CollectionCRUD<ChallengeModel> {
  ChallengeCRUD() : super(collectionName: 'challenge');

  @override
  ChallengeModel? jsonToModel(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? _,
  ) {
    try {
      final json = snapshot.data() ?? {};
      json['id'] = snapshot.id;
      return ChallengeModel.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, Object?> modelToJson(ChallengeModel? data, SetOptions? _) {
    return (data?.toJson()?..removeWhere((key, value) => key == 'id')) ?? {};
  }

  /// Delete the relationships of this user
  Future<void> onAccountDeletion({required String? userId}) async {
    final challenges = await readFiltered(
      filter: (collection) => collection.where('authorId', isEqualTo: userId),
    );
    for (final challenge in challenges) {
      await delete(documentId: challenge.id);
    }
  }
}

final challengeCRUD = ChallengeCRUD();
