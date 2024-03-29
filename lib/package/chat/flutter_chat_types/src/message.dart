
/// All possible message types.
enum MessageType {
  audio,
  custom,
  file,
  image,
  system,
  text,
  unsupported,
  video
}

/// All possible statuses message can have.
enum MessageStatus { delivered, error, seen, sending, sent }

// /// An abstract class that contains all variables and methods
// /// every message will have.
// @immutable
// abstract class Message extends Equatable {
//   const Message({
//     required this.authorId,
//     required this.id,
//     required this.type,
//     this.createdAt,
//     this.metadata,
//     this.remoteId,
//     this.repliedMessage,
//     this.roomId,
//     this.showStatus,
//     this.status,
//     this.updatedAt,
//   });

//   /// Creates a particular message from a map (decoded JSON).
//   /// Type is determined by the `type` field.
//   factory Message.fromJson(Map<String, dynamic> json) {
//     final type = MessageType.values.firstWhere(
//       (e) => e.name == json['type'],
//       orElse: () => MessageType.unsupported,
//     );

//     switch (type) {
//       case MessageType.audio:
//         return AudioMessage.fromJson(json);
//       case MessageType.custom:
//         return CustomMessage.fromJson(json);
//       case MessageType.file:
//         return FileMessage.fromJson(json);
//       case MessageType.image:
//         return ImageMessage.fromJson(json);
//       case MessageType.system:
//         return SystemMessage.fromJson(json);
//       case MessageType.text:
//         return TextMessage.fromJson(json);
//       case MessageType.unsupported:
//         return UnsupportedMessage.fromJson(json);
//       case MessageType.video:
//         return VideoMessage.fromJson(json);
//     }
//   }

//   /// User who sent this message.
//   final String authorId;

//   /// Created message timestamp, in ms.
//   final int? createdAt;

//   /// Unique ID of the message.
//   final String id;

//   /// Additional custom metadata or attributes related to the message.
//   final Map<String, dynamic>? metadata;

//   /// Unique ID of the message received from the backend.
//   final String? remoteId;

//   /// Message that is being replied to with the current message.
//   final Message? repliedMessage;

//   /// ID of the room where this message is sent.
//   final String? roomId;

//   /// Show status or not.
//   final bool? showStatus;

//   /// Message [MessageStatus].
//   final MessageStatus? status;

//   /// [MessageType].
//   final MessageType type;

//   /// Updated message timestamp, in ms.
//   final int? updatedAt;

//   /// Creates a copy of the message with an updated data.
//   Message copyWith({
//     String? authorId,
//     int? createdAt,
//     String? id,
//     Map<String, dynamic>? metadata,
//     String? remoteId,
//     Message? repliedMessage,
//     String? roomId,
//     bool? showStatus,
//     MessageStatus? status,
//     int? updatedAt,
//   });

//   /// Converts a particular message to the map representation, serializable to JSON.
//   Map<String, dynamic> toJson();

//   // TODO : remove
//   // static Message? complete(Message partialMessage, String senderId) {
//   //   Message? message;
//   //   if (partialMessage is PartialCustom) {
//   //     message = CustomMessage.fromPartial(
//   //       authorId: senderId,
//   //       id: '',
//   //       partialCustom: partialMessage as PartialCustom,
//   //     );
//   //   } else if (partialMessage is PartialFile) {
//   //     message = FileMessage.fromPartial(
//   //       authorId: senderId,
//   //       id: '',
//   //       partialFile: partialMessage as PartialFile,
//   //     );
//   //   } else if (partialMessage is PartialImage) {
//   //     message = ImageMessage.fromPartial(
//   //       authorId: senderId,
//   //       id: '',
//   //       partialImage: partialMessage as PartialImage,
//   //     );
//   //   } else if (partialMessage is PartialText) {
//   //     message = TextMessage.fromPartial(
//   //       authorId: senderId,
//   //       partialText: partialMessage as PartialText,
//   //     );
//   //   } else {
//   //     message = null;
//   //   }
//   //   return message;
//   // }
// }
