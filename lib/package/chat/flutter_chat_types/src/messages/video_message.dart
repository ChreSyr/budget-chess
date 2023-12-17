import 'package:crea_chess/package/chat/flutter_chat_types/src/message.dart';
import 'package:crea_chess/package/chat/flutter_chat_types/src/messages/partial_video.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'video_message.g.dart';

/// A class that represents video message.
@JsonSerializable()
@immutable
abstract class VideoMessage extends Message {
  const factory VideoMessage({
    required String authorId,
    required String id,
    required String name,
    required num size,
    required String uri,
    int? createdAt,
    double? height,
    Map<String, dynamic>? metadata,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    MessageStatus? status,
    MessageType? type,
    int? updatedAt,
    double? width,
  }) = _VideoMessage;

  /// Creates a video message.
  const VideoMessage._({
    required super.authorId,
    required super.id,
    required this.name,
    required this.size,
    required this.uri,
    super.createdAt,
    this.height,
    super.metadata,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    super.status,
    MessageType? type,
    super.updatedAt,
    this.width,
  }) : super(type: type ?? MessageType.video);

  /// Creates a video message from a map (decoded JSON).
  factory VideoMessage.fromJson(Map<String, dynamic> json) =>
      _$VideoMessageFromJson(json);

  /// Creates a full video message from a partial one.
  factory VideoMessage.fromPartial({
    required String authorId,
    required String id,
    required PartialVideo partialVideo,
    int? createdAt,
    String? remoteId,
    String? roomId,
    bool? showStatus,
    MessageStatus? status,
    int? updatedAt,
  }) =>
      _VideoMessage(
        authorId: authorId,
        createdAt: createdAt,
        height: partialVideo.height,
        id: id,
        metadata: partialVideo.metadata,
        name: partialVideo.name,
        remoteId: remoteId,
        repliedMessage: partialVideo.repliedMessage,
        roomId: roomId,
        showStatus: showStatus,
        size: partialVideo.size,
        status: status,
        type: MessageType.video,
        updatedAt: updatedAt,
        uri: partialVideo.uri,
        width: partialVideo.width,
      );

  /// Video height in pixels.
  final double? height;

  /// The name of the video.
  final String name;

  /// Size of the video in bytes.
  final num size;

  /// The video source (either a remote URL or a local resource).
  final String uri;

  /// Video width in pixels.
  final double? width;

  /// Equatable props.
  @override
  List<Object?> get props => [
        authorId,
        createdAt,
        height,
        id,
        metadata,
        name,
        remoteId,
        repliedMessage,
        roomId,
        showStatus,
        size,
        status,
        updatedAt,
        uri,
        width,
      ];

  @override
  Message copyWith({
    String? authorId,
    int? createdAt,
    double? height,
    String? id,
    Map<String, dynamic>? metadata,
    String? name,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    num? size,
    MessageStatus? status,
    int? updatedAt,
    String? uri,
    double? width,
  });

  /// Converts an video message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$VideoMessageToJson(this);
}

/// A utility class to enable better copyWith.
class _VideoMessage extends VideoMessage {
  const _VideoMessage({
    required super.authorId,
    required super.id,
    required super.name,
    required super.size,
    required super.uri,
    super.createdAt,
    super.height,
    super.metadata,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    super.status,
    super.type,
    super.updatedAt,
    super.width,
  }) : super._();

  @override
  Message copyWith({
    String? authorId,
    dynamic createdAt = _Unset,
    dynamic height = _Unset,
    String? id,
    dynamic metadata = _Unset,
    String? name,
    dynamic remoteId = _Unset,
    dynamic repliedMessage = _Unset,
    dynamic roomId,
    dynamic showStatus = _Unset,
    num? size,
    dynamic status = _Unset,
    dynamic updatedAt = _Unset,
    String? uri,
    dynamic width = _Unset,
  }) =>
      _VideoMessage(
        authorId: authorId ?? this.authorId,
        createdAt: createdAt == _Unset ? this.createdAt : createdAt as int?,
        height: height == _Unset ? this.height : height as double?,
        id: id ?? this.id,
        metadata: metadata == _Unset
            ? this.metadata
            : metadata as Map<String, dynamic>?,
        name: name ?? this.name,
        remoteId: remoteId == _Unset ? this.remoteId : remoteId as String?,
        repliedMessage: repliedMessage == _Unset
            ? this.repliedMessage
            : repliedMessage as Message?,
        roomId: roomId == _Unset ? this.roomId : roomId as String?,
        showStatus:
            showStatus == _Unset ? this.showStatus : showStatus as bool?,
        size: size ?? this.size,
        status: status == _Unset ? this.status : status as MessageStatus?,
        updatedAt: updatedAt == _Unset ? this.updatedAt : updatedAt as int?,
        uri: uri ?? this.uri,
        width: width == _Unset ? this.width : width as double?,
      );
}

class _Unset {}
