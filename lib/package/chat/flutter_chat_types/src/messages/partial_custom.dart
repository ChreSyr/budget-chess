// ignore_for_file: comment_references

import 'package:crea_chess/package/firebase/firestore/relationship/message/message_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'partial_custom.g.dart';

/// A class that represents partial custom message.
@JsonSerializable()
@immutable
class PartialCustom {
  /// Creates a partial custom message with metadata variable.
  /// Use [CustomMessage] to create a full message.
  /// You can use [CustomMessage.fromPartial] constructor to create a full
  /// message from a partial one.
  const PartialCustom({
    this.metadata,
    this.repliedMessage,
  });

  /// Creates a partial custom message from a map (decoded JSON).
  factory PartialCustom.fromJson(Map<String, dynamic> json) =>
      _$PartialCustomFromJson(json);

  /// Additional custom metadata or attributes related to the message.
  final Map<String, dynamic>? metadata;

  /// Message that is being replied to with the current message.
  final MessageModel? repliedMessage;

  /// Converts a partial custom message to the map representation, encodable
  /// to JSON.
  Map<String, dynamic> toJson() => _$PartialCustomToJson(this);
}