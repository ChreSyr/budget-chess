import 'package:crea_chess/package/chat/flutter_chat_types/src/message.dart';
import 'package:crea_chess/package/chat/flutter_chat_types/src/messages/partial_file.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'file_message.g.dart';

/// A class that represents file message.
@JsonSerializable()
@immutable
abstract class FileMessage extends Message {
  const factory FileMessage({
    required String authorId,
    required String id,
    required String name,
    required num size,
    required String uri,
    int? createdAt,
    bool? isLoading,
    Map<String, dynamic>? metadata,
    String? mimeType,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    MessageStatus? status,
    MessageType? type,
    int? updatedAt,
  }) = _FileMessage;

  /// Creates a file message.
  const FileMessage._({
    required super.authorId,
    required super.id,
    required this.name,
    required this.size,
    required this.uri,
    super.createdAt,
    this.isLoading,
    super.metadata,
    this.mimeType,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    super.status,
    MessageType? type,
    super.updatedAt,
  }) : super(type: type ?? MessageType.file);

  /// Creates a file message from a map (decoded JSON).
  factory FileMessage.fromJson(Map<String, dynamic> json) =>
      _$FileMessageFromJson(json);

  /// Creates a full file message from a partial one.
  factory FileMessage.fromPartial({
    required String authorId,
    required String id,
    required PartialFile partialFile,
    int? createdAt,
    bool? isLoading,
    String? remoteId,
    String? roomId,
    bool? showStatus,
    MessageStatus? status,
    int? updatedAt,
  }) =>
      _FileMessage(
        authorId: authorId,
        createdAt: createdAt,
        id: id,
        isLoading: isLoading,
        metadata: partialFile.metadata,
        mimeType: partialFile.mimeType,
        name: partialFile.name,
        remoteId: remoteId,
        repliedMessage: partialFile.repliedMessage,
        roomId: roomId,
        showStatus: showStatus,
        size: partialFile.size,
        status: status,
        type: MessageType.file,
        updatedAt: updatedAt,
        uri: partialFile.uri,
      );

  /// Specify whether the message content is currently being loaded.
  final bool? isLoading;

  /// Media type.
  final String? mimeType;

  /// The name of the file.
  final String name;

  /// Size of the file in bytes.
  final num size;

  /// The file source (either a remote URL or a local resource).
  final String uri;

  /// Equatable props.
  @override
  List<Object?> get props => [
        authorId,
        createdAt,
        id,
        isLoading,
        metadata,
        mimeType,
        name,
        remoteId,
        repliedMessage,
        roomId,
        showStatus,
        size,
        status,
        updatedAt,
        uri,
      ];

  @override
  Message copyWith({
    String? authorId,
    int? createdAt,
    String? id,
    bool? isLoading,
    Map<String, dynamic>? metadata,
    String? mimeType,
    String? name,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    num? size,
    MessageStatus? status,
    int? updatedAt,
    String? uri,
  });

  /// Converts a file message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$FileMessageToJson(this);
}

/// A utility class to enable better copyWith.
class _FileMessage extends FileMessage {
  const _FileMessage({
    required super.authorId,
    required super.id,
    required super.name,
    required super.size,
    required super.uri,
    super.createdAt,
    super.isLoading,
    super.metadata,
    super.mimeType,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    super.status,
    super.type,
    super.updatedAt,
  }) : super._();

  @override
  Message copyWith({
    String? authorId,
    dynamic createdAt = _Unset,
    dynamic height = _Unset,
    String? id,
    dynamic isLoading = _Unset,
    dynamic metadata = _Unset,
    dynamic mimeType = _Unset,
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
      _FileMessage(
        authorId: authorId ?? this.authorId,
        createdAt: createdAt == _Unset ? this.createdAt : createdAt as int?,
        id: id ?? this.id,
        isLoading: isLoading == _Unset ? this.isLoading : isLoading as bool?,
        metadata: metadata == _Unset
            ? this.metadata
            : metadata as Map<String, dynamic>?,
        mimeType: mimeType == _Unset ? this.mimeType : mimeType as String?,
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
      );
}

class _Unset {}
