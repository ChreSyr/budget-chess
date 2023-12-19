import 'package:crea_chess/package/chat/flutter_chat_types/src/preview_data.dart'
    show PreviewData;
import 'package:crea_chess/package/firebase/firestore/relationship/message/message_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'partial_text.g.dart';

// TODO : rework

/// A class that represents partial text message.
@JsonSerializable()
@immutable
class PartialText {
  /// Creates a partial text message with all variables text can have.
  /// Use [TextMessage] to create a full message.
  /// You can use [TextMessage.fromPartial] constructor to create a full
  /// message from a partial one.
  const PartialText({
    required this.text,
    this.metadata,
    this.previewData,
    this.repliedMessage,
  });

  /// Creates a partial text message from a map (decoded JSON).
  factory PartialText.fromJson(Map<String, dynamic> json) =>
      _$PartialTextFromJson(json);

  /// Additional custom metadata or attributes related to the message.
  final Map<String, dynamic>? metadata;

  /// See [PreviewData].
  final PreviewData? previewData;

  /// Message that is being replied to with the current message.
  final MessageModel? repliedMessage;

  /// User's message.
  final String text;

  /// Converts a partial text message to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => _$PartialTextToJson(this);
}
