import 'package:crea_chess/package/chat/flutter_chat_types/src/message.dart';
import 'package:crea_chess/package/chat/flutter_chat_types/src/messages/partial_audio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'audio_message.g.dart';

/// A class that represents audio message.
@JsonSerializable()
@immutable
abstract class AudioMessage extends Message {
  const factory AudioMessage({
    required String authorId,
    required Duration duration,
    required String id,
    required String name,
    required num size,
    required String uri,
    int? createdAt,
    Map<String, dynamic>? metadata,
    String? mimeType,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    MessageStatus? status,
    MessageType? type,
    int? updatedAt,
    List<double>? waveForm,
  }) = _AudioMessage;

  /// Creates an audio message.
  const AudioMessage._({
    required super.authorId,
    required this.duration,
    required super.id,
    required this.name,
    required this.size,
    required this.uri,
    super.createdAt,
    super.metadata,
    this.mimeType,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    super.status,
    MessageType? type,
    super.updatedAt,
    this.waveForm,
  }) : super(type: type ?? MessageType.audio);

  /// Creates an audio message from a map (decoded JSON).
  factory AudioMessage.fromJson(Map<String, dynamic> json) =>
      _$AudioMessageFromJson(json);

  /// Creates a full audio message from a partial one.
  factory AudioMessage.fromPartial({
    required String authorId,
    required String id,
    required PartialAudio partialAudio,
    int? createdAt,
    String? remoteId,
    String? roomId,
    bool? showStatus,
    MessageStatus? status,
    int? updatedAt,
  }) =>
      _AudioMessage(
        authorId: authorId,
        createdAt: createdAt,
        duration: partialAudio.duration,
        id: id,
        metadata: partialAudio.metadata,
        mimeType: partialAudio.mimeType,
        name: partialAudio.name,
        remoteId: remoteId,
        repliedMessage: partialAudio.repliedMessage,
        roomId: roomId,
        showStatus: showStatus,
        size: partialAudio.size,
        status: status,
        type: MessageType.audio,
        updatedAt: updatedAt,
        uri: partialAudio.uri,
        waveForm: partialAudio.waveForm,
      );

  /// The length of the audio.
  final Duration duration;

  /// Media type of the audio file.
  final String? mimeType;

  /// The name of the audio.
  final String name;

  /// Size of the audio in bytes.
  final num size;

  /// The audio file source (either a remote URL or a local resource).
  final String uri;

  /// Wave form represented as a list of decibel levels.
  final List<double>? waveForm;

  /// Equatable props.
  @override
  List<Object?> get props => [
        authorId,
        createdAt,
        duration,
        id,
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
        waveForm,
      ];

  @override
  Message copyWith({
    String? authorId,
    int? createdAt,
    Duration? duration,
    String? id,
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
    List<double>? waveForm,
  });

  /// Converts an audio message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$AudioMessageToJson(this);
}

/// A utility class to enable better copyWith.
class _AudioMessage extends AudioMessage {
  const _AudioMessage({
    required super.authorId,
    required super.duration,
    required super.id,
    required super.name,
    required super.size,
    required super.uri,
    super.createdAt,
    super.metadata,
    super.mimeType,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    super.status,
    super.type,
    super.updatedAt,
    super.waveForm,
  }) : super._();

  @override
  Message copyWith({
    String? authorId,
    dynamic createdAt = _Unset,
    Duration? duration,
    String? id,
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
    dynamic waveForm = _Unset,
  }) =>
      _AudioMessage(
        authorId: authorId ?? this.authorId,
        createdAt: createdAt == _Unset ? this.createdAt : createdAt as int?,
        duration: duration ?? this.duration,
        id: id ?? this.id,
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
        waveForm:
            waveForm == _Unset ? this.waveForm : waveForm as List<double>?,
      );
}

class _Unset {}
