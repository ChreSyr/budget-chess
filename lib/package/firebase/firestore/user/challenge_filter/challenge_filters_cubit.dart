import 'dart:async';
import 'dart:math';

import 'package:crea_chess/package/firebase/export.dart';

class ChallengeFiltersCubit
    extends AuthUidListenerCubit<Iterable<ChallengeFilterModel>> {
  ChallengeFiltersCubit() : super(ChallengeFilterModel.defaults);

  StreamSubscription<Iterable<ChallengeFilterModel>?>? _filtersStream;

  @override
  Future<void> authUidChanged(String? authUid) async {
    await _filtersStream?.cancel();
    if (authUid == null) {
      return emit(ChallengeFilterModel.defaults);
    }
    _filtersStream =
        challengeFilterCRUD.streamAll(parentDocumentId: authUid).listen(emit);
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
  Future<void> close() {
    _filtersStream?.cancel();
    return super.close();
  }
}
