import 'dart:async';

import 'package:collection/collection.dart';
import 'package:crea_chess/package/firebase/export.dart';

class RelationsCubit extends AuthUidListenerCubit<Iterable<RelationshipModel>> {
  RelationsCubit()
      : _friendIds = const [],
        super([]);

  String? _authUid;
  StreamSubscription<Iterable<RelationshipModel>>? _relationsStream;
  Iterable<String> _friendIds;

  @override
  void authUidChanged(String? authUid) {
    _authUid = authUid;
    _relationsStream?.cancel();
    if (authUid == null) {
      _friendIds = [];
      return emit([]);
    }
    _relationsStream = relationshipCRUD
        .streamFiltered(
      filter: (collection) => collection.where('users.$authUid', isNull: false),
    )
        .listen((relations) {
      _friendIds = relations
          .where((r) => r.isFriendship)
          .map((r) => r.otherUser(authUid))
          .whereType<String>();
      emit(
        relations.sorted(
          (a, b) => a.lastChatUpdate == null
              ? 1
              : b.lastChatUpdate?.compareTo(a.lastChatUpdate!) ?? -1,
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _relationsStream?.cancel();
    return super.close();
  }

  Iterable<String> get friendIds => _friendIds;
  Iterable<String> get otherIds => _authUid == null
      ? []
      : state.map((e) => e.otherUser(_authUid!)).whereType<String>();

  RelationshipModel? getRelationWith(String userId) {
    if (_authUid == null) return null;
    return state.firstWhereOrNull((r) => r.otherUser(_authUid!) == userId);
  }
}
