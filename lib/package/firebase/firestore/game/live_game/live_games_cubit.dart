import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveGamesCubit extends Cubit<Iterable<GameModel>> {
  LiveGamesCubit() : super([]) {
    _authStream = FirebaseAuth.instance.userChanges().listen(_fromAuth);
  }

  void _fromAuth(User? auth) {
    _liveGamesStream?.cancel();

    if (auth == null || !auth.isVerified) {
      emit([]);
      return;
    }

    _liveGamesStream = liveGameCRUD
        .streamFiltered(
          filter: (collection) => collection.where(
            Filter.or(
              Filter('whiteId', isEqualTo: auth.uid),
              Filter('blackId', isEqualTo: auth.uid),
            ),
          ),
        )
        .listen(emit);
  }

  StreamSubscription<Iterable<GameModel>>? _liveGamesStream;
  late StreamSubscription<User?> _authStream;

  @override
  Future<void> close() {
    _liveGamesStream?.cancel();
    _authStream.cancel();
    return super.close();
  }
}
