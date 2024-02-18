// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:crea_chess/package/firebase/firestore/crud/collection_crud.dart';
// import 'package:crea_chess/package/firebase/firestore/game/live_game/game_model.dart';

// class LiveGameCRUD extends CollectionCRUD<GameModel> {
//   LiveGameCRUD() : super(collectionName: 'live_game');

//   @override
//   GameModel? jsonToModel(
//     DocumentSnapshot<Map<String, dynamic>> snapshot,
//     SnapshotOptions? _,
//   ) {
//     try {
//       final json = snapshot.data() ?? {};
//       json['id'] = snapshot.id;
//       return GameModel.fromJson(json);
//     } catch (_) {
//       return null;
//     }
//   }

//   @override
//   Map<String, Object?> modelToJson(GameModel? data, SetOptions? _) {
//     return (data?.toJson()
//           ?..removeWhere(
//             (key, value) => key == 'id' || value == null,
//           )) ??
//         {};
//   }
// }

// final liveGameCRUD = LiveGameCRUD();
