// ignore_for_file: public_member_api_docs, invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/firebase/firestore/converter/timestamp_to_datetime.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'relationship_model.freezed.dart';
part 'relationship_model.g.dart';

typedef RelationshipUsers = Map<String, UserInRelationshipStatus>;

// Needs :
//   - easily query all friend request
//   - easily query all friendships

enum UserInRelationshipStatus {
  /// This user never pronounced himself, or canceled the relation
  none,

  /// This user requested someone else to start a relation
  requests,

  /// This user is asked to join a relation
  isRequested,

  /// This user was asked to join a relation, and he refused
  refuses,

  /// This user asked for a relation, and it got refused
  isRefused,

  /// This user is in a relationship with the other user
  open,

  /// This user canceled the relation
  cancels,

  /// The other user canceled the relation, intentionnally or by closing its
  /// account
  isCanceled,

  /// This user desn't want to be in this relation anymore
  blocks,

  /// This user can't be in this relation anymore
  isBlocked,

  /// This user deleted his account, the relation can't evolve anymore
  hasDeletedAccount,
}

@freezed
class RelationshipModel with _$RelationshipModel {
  factory RelationshipModel({
    required String id,
    @protected required RelationshipUsers users,

    /// Last time the status of one of the users changes. Used to determine the
    /// duration of a frienship.
    @TimestampToDateTimeConverter() DateTime? lastUserStatusUpdate,
  }) = _RelationshipModel;

  /// Required for the override getter
  const RelationshipModel._();

  factory RelationshipModel.fromJson(Map<String, dynamic> json) =>
      _$RelationshipModelFromJson(json);

  // ---

  RelationshipUsers get copyOfUsers => RelationshipUsers.from(users);
  UserInRelationshipStatus? statusOf(String userId) => users[userId];

  String? get blocker {
    return users.entries
        .where(
          (entry) => entry.value == UserInRelationshipStatus.blocks,
        )
        .firstOrNull
        ?.key;
  }

  String? get requester {
    return users.entries
        .where(
          (entry) => entry.value == UserInRelationshipStatus.requests,
        )
        .firstOrNull
        ?.key;
  }

  bool canSendFriendRequest(String requesterId) {
    final requestedId = otherUser(requesterId);
    if (requestedId == null) return false;

    // Can't send friend request if :
    //   - the requester status is :
    //     - requests
    //     - isBlocked
    //     - hasAccountDeleted
    switch (statusOf(requesterId)) {
      case UserInRelationshipStatus.requests:
      case UserInRelationshipStatus.isBlocked:
      case UserInRelationshipStatus.hasDeletedAccount:
        return false;
      // ignore: no_default_cases
      default:
    }

    // Can't send friend request if :
    //   - the other user's status is :
    //     - isRequested
    //     - blocks
    //     - hasAccountDeleted
    switch (statusOf(requestedId)) {
      case UserInRelationshipStatus.isRequested:
      case UserInRelationshipStatus.blocks:
      case UserInRelationshipStatus.hasDeletedAccount:
        return false;
      // ignore: no_default_cases
      default:
        return true;
    }
  }

  bool isBlockedBy(String userId) {
    return users[userId] == UserInRelationshipStatus.blocks;
  }

  bool isRequestedBy(String userId) {
    return users[userId] == UserInRelationshipStatus.requests;
  }

  /// Only works for relations of 2 users. If userId is not one of the users,
  /// returns null.
  String? otherUser(String user1) {
    final userIds = users.keys;
    assert(userIds.length == 2);
    if (userIds.isEmpty) return null;
    if (user1 == userIds.first) {
      return userIds.last;
    } else if (user1 == userIds.last) {
      return userIds.first;
    } else {
      return null;
    }
  }
}
