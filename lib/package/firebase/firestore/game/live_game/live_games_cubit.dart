import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/firebase/export.dart';

class LiveGamesCubit extends AuthUidListenerCubit<Iterable<GameModel>> {
  LiveGamesCubit() : super([]);

  @override
  void authUidChanged(String? authUid) {
    _liveGamesStream?.cancel();

    if (authUid == null) {
      emit([]);
      return;
    }

    _liveGamesStream = liveGameCRUD
        .streamFiltered(
          filter: (collection) => collection.where(
            Filter.or(
              Filter('whiteId', isEqualTo: authUid),
              Filter('blackId', isEqualTo: authUid),
            ),
          ),
        )
        .listen(emit);
  }

  StreamSubscription<Iterable<GameModel>>? _liveGamesStream;

  @override
  Future<void> close() {
    _liveGamesStream?.cancel();
    return super.close();
  }
}
