// import 'package:crea_chess/package/chat/flutter_chat_types/src/message.dart';
// import 'package:crea_chess/package/chat/flutter_chat_types/src/messages/partial_image.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:meta/meta.dart';

// part 'image_message.g.dart';

// /// A class that represents image message.
// @JsonSerializable()
// @immutable
// abstract class ImageMessage extends Message {
//   const factory ImageMessage({
//     required String authorId,
//     required String id,
//     required String name,
//     required num size,
//     required String uri,
//     int? createdAt,
//     double? height,
//     Map<String, dynamic>? metadata,
//     String? remoteId,
//     Message? repliedMessage,
//     String? roomId,
//     bool? showStatus,
//     MessageStatus? status,
//     MessageType? type,
//     int? updatedAt,
//     double? width,
//   }) = _ImageMessage;

//   /// Creates an image message.
//   const ImageMessage._({
//     required super.authorId,
//     required super.id,
//     required this.name,
//     required this.size,
//     required this.uri,
//     super.createdAt,
//     this.height,
//     super.metadata,
//     super.remoteId,
//     super.repliedMessage,
//     super.roomId,
//     super.showStatus,
//     super.status,
//     MessageType? type,
//     super.updatedAt,
//     this.width,
//   }) : super(type: type ?? MessageType.image);

//   /// Creates an image message from a map (decoded JSON).
//   factory ImageMessage.fromJson(Map<String, dynamic> json) =>
//       _$ImageMessageFromJson(json);

//   /// Creates a full image message from a partial one.
//   factory ImageMessage.fromPartial({
//     required String id,
//     required String authorId,
//     required PartialImage partialImage,
//     int? createdAt,
//     String? remoteId,
//     String? roomId,
//     bool? showStatus,
//     MessageStatus? status,
//     int? updatedAt,
//   }) =>
//       _ImageMessage(
//         id: id,
//         authorId: authorId,
//         createdAt: createdAt,
//         height: partialImage.height,
//         metadata: partialImage.metadata,
//         name: partialImage.name,
//         remoteId: remoteId,
//         repliedMessage: partialImage.repliedMessage,
//         roomId: roomId,
//         showStatus: showStatus,
//         size: partialImage.size,
//         status: status,
//         type: MessageType.image,
//         updatedAt: updatedAt,
//         uri: partialImage.uri,
//         width: partialImage.width,
//       );

//   /// Image height in pixels.
//   final double? height;

//   /// The name of the image.
//   final String name;

//   /// Size of the image in bytes.
//   final num size;

//   /// The image source (either a remote URL or a local resource).
//   final String uri;

//   /// Image width in pixels.
//   final double? width;

//   /// Equatable props.
//   @override
//   List<Object?> get props => [
//         authorId,
//         createdAt,
//         height,
//         id,
//         metadata,
//         name,
//         remoteId,
//         repliedMessage,
//         roomId,
//         showStatus,
//         size,
//         status,
//         updatedAt,
//         uri,
//         width,
//       ];

//   @override
//   Message copyWith({
//     String? authorId,
//     int? createdAt,
//     double? height,
//     String? id,
//     Map<String, dynamic>? metadata,
//     String? name,
//     String? remoteId,
//     Message? repliedMessage,
//     String? roomId,
//     bool? showStatus,
//     num? size,
//     MessageStatus? status,
//     int? updatedAt,
//     String? uri,
//     double? width,
//   });

//   /// Converts an image message to the map representation, encodable to JSON.
//   @override
//   Map<String, dynamic> toJson() => _$ImageMessageToJson(this);
// }

// /// A utility class to enable better copyWith.
// class _ImageMessage extends ImageMessage {
//   const _ImageMessage({
//     required super.authorId,
//     required super.id,
//     required super.name,
//     required super.size,
//     required super.uri,
//     super.createdAt,
//     super.height,
//     super.metadata,
//     super.remoteId,
//     super.repliedMessage,
//     super.roomId,
//     super.showStatus,
//     super.status,
//     super.type,
//     super.updatedAt,
//     super.width,
//   }) : super._();

//   @override
//   Message copyWith({
//     String? authorId,
//     dynamic createdAt = _Unset,
//     dynamic height = _Unset,
//     String? id,
//     dynamic metadata = _Unset,
//     String? name,
//     dynamic remoteId = _Unset,
//     dynamic repliedMessage = _Unset,
//     dynamic roomId,
//     dynamic showStatus = _Unset,
//     num? size,
//     dynamic status = _Unset,
//     dynamic updatedAt = _Unset,
//     String? uri,
//     dynamic width = _Unset,
//   }) =>
//       _ImageMessage(
//         authorId: authorId ?? this.authorId,
//         createdAt: createdAt == _Unset ? this.createdAt : createdAt as int?,
//         height: height == _Unset ? this.height : height as double?,
//         id: id ?? this.id,
//         metadata: metadata == _Unset
//             ? this.metadata
//             : metadata as Map<String, dynamic>?,
//         name: name ?? this.name,
//         remoteId: remoteId == _Unset ? this.remoteId : remoteId as String?,
//         repliedMessage: repliedMessage == _Unset
//             ? this.repliedMessage
//             : repliedMessage as Message?,
//         roomId: roomId == _Unset ? this.roomId : roomId as String?,
//         showStatus:
//             showStatus == _Unset ? this.showStatus : showStatus as bool?,
//         size: size ?? this.size,
//         status: status == _Unset ? this.status : status as MessageStatus?,
//         updatedAt: updatedAt == _Unset ? this.updatedAt : updatedAt as int?,
//         uri: uri ?? this.uri,
//         width: width == _Unset ? this.width : width as double?,
//       );
// }

// class _Unset {}
