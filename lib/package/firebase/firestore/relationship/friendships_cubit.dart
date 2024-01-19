import 'dart:async';

import 'package:crea_chess/package/firebase/firestore/relationship/relationship_crud.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/relationship_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendshipCubit extends Cubit<Iterable<RelationshipModel>> {
  FriendshipCubit() : super([]) {
    _authStream = FirebaseAuth.instance.userChanges().listen(_authChanged);
  }

  String? _authUid;
  StreamSubscription<User?>? _authStream;
  StreamSubscription<Iterable<RelationshipModel>?>? _friendsStream;

  Future<void> _authChanged(User? auth) async {
    await _friendsStream?.cancel();
    _authUid = auth?.uid;
    if (auth == null) return emit([]);
    _friendsStream = relationshipCRUD.friendsOf(auth.uid).listen(emit);
  }

  Iterable<String> get friendIds => _authUid == null
      ? []
      : state
          .map((friendship) => friendship.otherUser(_authUid!))
          .whereType<String>();

  @override
  Future<void> close() async {
    await _authStream?.cancel();
    await _friendsStream?.cancel();
    return super.close();
  }
}
