import 'dart:async';
import 'dart:math';

import 'package:crea_chess/package/firebase/export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChallengeFiltersCubit extends Cubit<Iterable<ChallengeFilterModel>> {
  ChallengeFiltersCubit() : super(ChallengeFilterModel.defaults) {
    _authStream = FirebaseAuth.instance.userChanges().listen(_authChanged);
  }

  StreamSubscription<User?>? _authStream;
  StreamSubscription<Iterable<ChallengeFilterModel>?>? _filtersStream;

  Future<void> _authChanged(User? auth) async {
    await _filtersStream?.cancel();
    if (auth == null) {
      return emit(ChallengeFilterModel.defaults);
    }
    _filtersStream =
        challengeFilterCRUD.streamAll(parentDocumentId: auth.uid).listen(emit);
  }

  String get nextFilterId {
    var maxId = 0;
    for (final filter in state) {
      try {
        maxId = max(int.parse(filter.id), maxId);
      } catch (_) {
        continue;
      }
    }
    return (maxId + 1).toString();
  }

  @override
  Future<void> close() async {
    await _authStream?.cancel();
    await _filtersStream?.cancel();
    return super.close();
  }
}
