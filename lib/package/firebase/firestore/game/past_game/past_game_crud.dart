import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/firebase/firestore/crud/collection_crud.dart';
import 'package:crea_chess/package/firebase/firestore/game/past_game/past_game_model.dart';

class PastGameCRUD extends CollectionCRUD<PastGameModel> {
  PastGameCRUD() : super(collectionName: 'live_game');

  @override
  PastGameModel? jsonToModel(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? _,
  ) {
    try {
      final json = snapshot.data() ?? {};
      json['id'] = snapshot.id;
      return PastGameModel.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, Object?> modelToJson(PastGameModel? data, SetOptions? _) {
    return (data?.toJson()
          ?..removeWhere(
            (key, value) => key == 'id' || value == null,
          )) ??
        {};
  }
}

final pastGameCRUD = PastGameCRUD();
