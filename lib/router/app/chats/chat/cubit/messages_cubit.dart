import 'dart:async';

import 'package:crea_chess/package/firebase/export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesCubit extends Cubit<Iterable<MessageModel>> {
  MessagesCubit._() : super([]);

  static final i = MessagesCubit._();

  String? _relationshipId;
  StreamSubscription<Iterable<MessageModel>>? _messagesStream;

  void relationshipIdChanged(String? relationshipId) {
    if (_relationshipId == relationshipId) return;
    _relationshipId = relationshipId;

    print('NEW RELATIONSHIP ID : $relationshipId');

    _messagesStream?.cancel();

    emit([]);
    if (relationshipId == null) return;

    _messagesStream = messageCRUD
        .streamFiltered(
          parentDocumentId: relationshipId,
          filter: (collection) => collection.orderBy(
            'createdAt',
            descending: true,
          ),
        )
        .listen(
          emit,
          onError: (_) => relationshipIdChanged(null),
        );
  }

  @override
  Future<void> close() {
    _messagesStream?.cancel();
    return super.close();
  }
}
