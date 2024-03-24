import 'package:crea_chess/package/chat/message/message_model.dart';
import 'package:crea_chess/package/chat/message/messsage_crud.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

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
  SendingMessagesCubit() : super(SendingMessages());

  @override
  Map<String, dynamic>? toJson(SendingMessages state) => state.toJson();

  @override
  SendingMessages fromJson(Map<String, dynamic> json) =>
      SendingMessages.fromJson(json);

  void clearStatus() => emit(state.copyWith(status: SendingStatus.idle));

  void send({
    required String authorId,
    required String receiverId,
    required String text,
  }) {
    final relationshipId = relationshipCRUD.getId(authorId, receiverId);
    final message = MessageModel.fromText(
      relationshipId: relationshipId,
      authorId: authorId,
      text: text,
    );
    final oldMessages = List<MessageModel>.from(state.messages);

    emit(
      state.copyWith(
        messages: List<MessageModel>.from(oldMessages)..add(message),
        status: SendingStatus.sending,
      ),
    );

    try {
      messageCRUD.create(
        parentDocumentId: relationshipId,
        data: message.copyWith(status: MessageStatus.sent),
      );
      emit(
        state.copyWith(
          messages: oldMessages,
          status: SendingStatus.idle,
        ),
      );
    } catch (_) {
      emit(
        SendingMessages(
          messages: oldMessages
            ..add(message.copyWith(status: MessageStatus.error)),
          status: SendingStatus.error,
        ),
      );
    }
  }
}
