// import 'package:crea_chess/package/chat/flutter_chat_types/src/message.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:meta/meta.dart';

// part 'unsupported_message.g.dart';

// /// A class that represents unsupported message. Used for backwards
// /// compatibility. If chat's end user doesn't update to a new version
// /// where new message types are being sent, some of them will result
// /// to unsupported.
// @JsonSerializable()
// @immutable
// abstract class UnsupportedMessage extends Message {
//   const factory UnsupportedMessage({
//     required String authorId,
//     required String id,
//     int? createdAt,
//     Map<String, dynamic>? metadata,
//     String? remoteId,
//     Message? repliedMessage,
//     String? roomId,
//     bool? showStatus,
//     MessageStatus? status,
//     MessageType? type,
//     int? updatedAt,
//   }) = _UnsupportedMessage;

//   /// Creates an unsupported message.
//   const UnsupportedMessage._({
//     required super.authorId,
//     required super.id,
//     super.createdAt,
//     super.metadata,
//     super.remoteId,
//     super.repliedMessage,
//     super.roomId,
//     super.showStatus,
//     super.status,
//     MessageType? type,
//     super.updatedAt,
//   }) : super(type: type ?? MessageType.unsupported);

//   /// Creates an unsupported message from a map (decoded JSON).
//   factory UnsupportedMessage.fromJson(Map<String, dynamic> json) =>
//       _$UnsupportedMessageFromJson(json);

//   /// Equatable props.
//   @override
//   List<Object?> get props => [
//         authorId,
//         createdAt,
//         id,
//         metadata,
//         remoteId,
//         repliedMessage,
//         roomId,
//         showStatus,
//         status,
//         updatedAt,
//       ];

//   @override
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

//   /// Converts an unsupported message to the map representation,
//   /// encodable to JSON.
//   @override
//   Map<String, dynamic> toJson() => _$UnsupportedMessageToJson(this);
// }

// /// A utility class to enable better copyWith.
// class _UnsupportedMessage extends UnsupportedMessage {
//   const _UnsupportedMessage({
//     required super.authorId,
//     required super.id,
//     super.createdAt,
//     super.metadata,
//     super.remoteId,
//     super.repliedMessage,
//     super.roomId,
//     super.showStatus,
//     super.status,
//     super.type,
//     super.updatedAt,
//   }) : super._();

//   @override
//   Message copyWith({
//     String? authorId,
//     dynamic createdAt = _Unset,
//     String? id,
//     dynamic metadata = _Unset,
//     dynamic remoteId = _Unset,
//     dynamic repliedMessage = _Unset,
//     dynamic roomId,
//     dynamic showStatus = _Unset,
//     dynamic status = _Unset,
//     dynamic updatedAt = _Unset,
//   }) =>
//       _UnsupportedMessage(
//         authorId: authorId ?? this.authorId,
//         createdAt: createdAt == _Unset ? this.createdAt : createdAt as int?,
//         id: id ?? this.id,
//         metadata: metadata == _Unset
//             ? this.metadata
//             : metadata as Map<String, dynamic>?,
//         remoteId: remoteId == _Unset ? this.remoteId : remoteId as String?,
//         repliedMessage: repliedMessage == _Unset
//             ? this.repliedMessage
//             : repliedMessage as Message?,
//         roomId: roomId == _Unset ? this.roomId : roomId as String?,
//         showStatus:
//             showStatus == _Unset ? this.showStatus : showStatus as bool?,
//         status: status == _Unset ? this.status : status as MessageStatus?,
//         updatedAt: updatedAt == _Unset ? this.updatedAt : updatedAt as int?,
//       );
// }

// class _Unset {}
