import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/crud/collection_crud.dart';
import 'package:crea_chess/package/firebase/firestore/game/live_game/game_indb.dart';

class LiveGameCRUD extends CollectionCRUD<GameModel> {
  LiveGameCRUD() : super(collectionName: 'liveGame');

  @override
  GameModel? jsonToModel(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? _,
  ) {
    try {
      final json = snapshot.data() ?? {};
      json['id'] = snapshot.id;
      return GameModel.fromDB(GameInDB.fromJson(json));
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, Object?> modelToJson(GameModel? data, SetOptions? _) {
    return (data?.toDB().toJson()
          ?..removeWhere(
            (key, value) => key == 'id' || value == null,
          )) ??
        {};
  }

  // ---

  void abort({required GameModel game}) {
    if (game.status.value >= GameStatus.started.value) return;

    update(
      documentId: game.id,
      data: game.copyWith(status: GameStatus.aborted),
      // TODO : Functions : delete aborted games
    );
  }

  Future<void> onChallengeAccepted({
    required ChallengeModel challenge,
    required String challengerId,
  }) async {
    final acceptedChallenge = challenge.copyWith(acceptedAt: DateTime.now());

    final authorId = acceptedChallenge.authorId;
    if (authorId == null || challengerId == authorId) return;

    final ids = [authorId, challengerId]..shuffle();

    final game = GameModel(
      id: acceptedChallenge.id,
      challenge: acceptedChallenge,
      blackId: ids[0],
      whiteId: ids[1],
      status: GameStatus.created,
    );

    await create(
      data: game,
      documentId: game.id,
    );

    await challengeCRUD.update(
      documentId: acceptedChallenge.id,
      data: acceptedChallenge,
    );
  }
}

final liveGameCRUD = LiveGameCRUD();
