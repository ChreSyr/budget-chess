import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/firebase/firestore/crud/collection_crud.dart';
import 'package:crea_chess/package/firebase/firestore/game/live_game/live_game_model.dart';

class LiveGameCRUD extends CollectionCRUD<LiveGameModel> {
  LiveGameCRUD() : super(collectionName: 'challenge');

  @override
  LiveGameModel? jsonToModel(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? _,
  ) {
    try {
      final json = snapshot.data() ?? {};
      json['id'] = snapshot.id;
      return LiveGameModel.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, Object?> modelToJson(LiveGameModel? data, SetOptions? _) {
    return (data?.toJson()
          ?..removeWhere(
            (key, value) => key == 'id' || value == null,
          )) ??
        {};
  }
}

final liveGameCRUD = LiveGameCRUD();
