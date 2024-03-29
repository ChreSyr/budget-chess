// import 'package:crea_chess/package/chat/flutter_chat_types/src/message.dart';
// import 'package:crea_chess/package/chat/flutter_chat_types/src/messages/partial_custom.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:meta/meta.dart';

// part 'custom_message.g.dart';

// /// A class that represents custom message. Use [metadata] to store anything
// /// you want.
// @JsonSerializable()
// @immutable
// abstract class CustomMessage extends Message {
//   const factory CustomMessage({
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
//   }) = _CustomMessage;

//   /// Creates a custom message.
//   const CustomMessage._({
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
//   }) : super(type: type ?? MessageType.custom);

//   /// Creates a custom message from a map (decoded JSON).
//   factory CustomMessage.fromJson(Map<String, dynamic> json) =>
//       _$CustomMessageFromJson(json);

//   /// Creates a full custom message from a partial one.
//   factory CustomMessage.fromPartial({
//     required String authorId,
//     required String id,
//     required PartialCustom partialCustom,
//     int? createdAt,
//     String? remoteId,
//     String? roomId,
//     bool? showStatus,
//     MessageStatus? status,
//     int? updatedAt,
//   }) =>
//       _CustomMessage(
//         authorId: authorId,
//         createdAt: createdAt,
//         id: id,
//         metadata: partialCustom.metadata,
//         remoteId: remoteId,
//         repliedMessage: partialCustom.repliedMessage,
//         roomId: roomId,
//         showStatus: showStatus,
//         status: status,
//         type: MessageType.custom,
//         updatedAt: updatedAt,
//       );

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

//   /// Converts a custom message to the map representation,
//   /// encodable to JSON.
//   @override
//   Map<String, dynamic> toJson() => _$CustomMessageToJson(this);
// }

// /// A utility class to enable better copyWith.
// class _CustomMessage extends CustomMessage {
//   const _CustomMessage({
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
//       _CustomMessage(
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
