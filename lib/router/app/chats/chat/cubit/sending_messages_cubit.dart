import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/router/app/chats/chat/cubit/messages_cubit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:uuid/uuid.dart';

part 'sending_messages_cubit.freezed.dart';
part 'sending_messages_cubit.g.dart';

enum SendingStatus { idle, sending, error }

class ListMessagesConverter
    implements JsonConverter<List<MessageModel>, List<Map<String, dynamic>>> {
  const ListMessagesConverter();

  @override
  List<MessageModel> fromJson(List<Map<String, dynamic>> json) {
    return json.map(MessageModel.fromJson).toList();
  }

  @override
  List<Map<String, dynamic>> toJson(List<MessageModel> messages) {
    return messages.map((e) => e.toJson()).toList();
  }
}

@freezed
class SendingMessages with _$SendingMessages {
  factory SendingMessages({
    @ListMessagesConverter() @Default([]) List<MessageModel> messages,
    @Default(SendingStatus.idle) SendingStatus status,
  }) = _SendingMessages;

  factory SendingMessages.fromJson(Map<String, dynamic> json) =>
      _$SendingMessagesFromJson(json);
}

class SendingMessagesCubit extends HydratedCubit<SendingMessages> {
  SendingMessagesCubit._() : super(SendingMessages());

  @override
  Map<String, dynamic>? toJson(SendingMessages state) => state.toJson();

  @override
  SendingMessages fromJson(Map<String, dynamic> json) =>
      SendingMessages.fromJson(json);

  static final i = SendingMessagesCubit._();

  void clearStatus() => emit(state.copyWith(status: SendingStatus.idle));

  Future<void> send({
    required String authorId,
    required String receiverId,
    required String text,
  }) async {
    final relationshipId = relationshipCRUD.getId(authorId, receiverId);
    final message = MessageModel(
      relationshipId: relationshipId,
      id: const Uuid().v1(),
      sentAt: DateTime.now(),
      authorId: authorId,
      text: text,
      sendStatus: MessageSendStatus.sending,
      sentTo: {receiverId},
    );

    final oldMessages = List<MessageModel>.from(state.messages);

    emit(
      state.copyWith(
        messages: List<MessageModel>.from(oldMessages)..add(message),
        status: SendingStatus.sending,
      ),
    );

    Future<void> send() async {
      await messageCRUD.create(
        parentDocumentId: relationshipId,
        documentId: message.id,
        data: message.copyWith(
          sendStatus: MessageSendStatus.sent,
        ),
      );

      await relationshipCRUD.updateChat(relationshipId: relationshipId);

      emit(
        state.copyWith(
          messages: oldMessages,
          status: SendingStatus.idle,
        ),
      );
    }

    try {
      try {
        await send();
      } on FirebaseException catch (e) {
        if (e.code == 'permission-denied') {
          // Probably because the relationship doesn't exist yet
          await relationshipCRUD.create(
            documentId: relationshipId,
            data: RelationshipModel(
              id: relationshipId,
              users: {
                authorId: UserInRelationshipStatus.none,
                receiverId: UserInRelationshipStatus.none,
              },
              lastUserStatusUpdate: DateTime.now(),
            ),
          );

          // The MessagesCubit was closed due to permission denied. Now that the
          // relationship exists, we need to restart the stream.
          MessagesCubit.i.relationshipIdChanged(relationshipId);

          await send();
        } else {
          rethrow;
        }
      }
    } catch (e) {
      emit(
        SendingMessages(
          messages: oldMessages
            ..add(message.copyWith(sendStatus: MessageSendStatus.error)),
          status: SendingStatus.error,
        ),
      );
    }
  }
}
