import 'package:crea_chess/package/atomic_design/dialog/user/email_verification.dart';
import 'package:crea_chess/package/atomic_design/flutter_chat_ui/widgets/chat.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/widget/user/friend_preview.Dart';
import 'package:crea_chess/package/chat/flutter_chat_types/flutter_chat_types.dart'
    as types;
import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/message/message_model.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/message/messsage_crud.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/relationship_crud.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/relationship_model.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_cubit.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// LATER: if other is not a friend, can only see friends in common

abstract class UserSection extends StatelessWidget {
  const UserSection({super.key});

  static List<UserSection> getNotVerifiedSections() {
    return [
      const UserSectionDetails(isVerified: false),
    ];
  }

  static List<UserSection> getSections(String current, String other) {
    if (current == other) {
      return [
        UserSectionFriends(userId: other),
        const UserSectionDetails(),
      ];
    } else {
      return [
        // TODO : messages only if friends
        UserSectionMessages(currentUserId: current, otherId: other),
        UserSectionFriends(userId: other),
      ];
    }
  }

  String getTitle(AppLocalizations l10n);
}

class UserSectionMessages extends UserSection {
  const UserSectionMessages({
    required this.currentUserId,
    required this.otherId,
    super.key,
  });

  final String currentUserId;
  final String otherId;

  @override
  String getTitle(AppLocalizations l10n) {
    return 'Messages'; // TODO : l10n
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserId == otherId) return Container(); // should never happen
    return ChatSection(currentUserId: currentUserId, otherId: otherId);
  }
}

class UserSectionFriends extends UserSection {
  const UserSectionFriends({required this.userId, super.key});

  final String userId;

  @override
  String getTitle(AppLocalizations l10n) => l10n.friends;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CCPadding.allMedium(
        child: StreamBuilder<Iterable<RelationshipModel>>(
          stream: relationshipCRUD.friendsOf(userId),
          builder: (context, snapshot) {
            final relations = snapshot.data;
            final List<Widget> friendsPreviews = (relations ?? [])
                .map(
                  (relationship) => FriendPreview(
                    friendId: (relationship.userIds ?? [])
                        .where((id) => id != userId)
                        .first,
                  ),
                )
                .toList();
            if (context.read<UserCubit>().state?.id == userId) {
              friendsPreviews.add(const FriendPreview(friendId: 'add'));
            }
            return Wrap(
              runSpacing: CCSize.medium,
              spacing: CCSize.medium,
              children: friendsPreviews,
            );
          },
        ),
      ),
    );
  }
}

class UserSectionDetails extends UserSection {
  const UserSectionDetails({this.isVerified = true, super.key});

  final bool isVerified;

  @override
  String getTitle(AppLocalizations l10n) => l10n.details;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CCPadding.allMedium(
        child: ListTile(
          leading: const Icon(Icons.email),
          title: Text(context.read<AuthenticationCubit>().state?.email ?? ''),
          trailing: isVerified
              ? null
              : const Icon(Icons.priority_high, color: Colors.red),
          onTap: isVerified ? null : () => showEmailVerificationDialog(context),
        ),
      ),
    );
  }
}

class ChatSection extends StatefulWidget {
  const ChatSection({
    required this.currentUserId,
    required this.otherId,
    super.key,
  });

  final String currentUserId;
  final String otherId;

  @override
  State<ChatSection> createState() => _ChatSectionState();
}

class _ChatSectionState extends State<ChatSection> {
  bool _isAttachmentUploading = false;

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleFileSelection() async {
    // TODO
    // final result = await FilePicker.platform.pickFiles(
    //   type: FileType.any,
    // );

    // if (result != null && result.files.single.path != null) {
    //   _setAttachmentUploading(true);
    //   final name = result.files.single.name;
    //   final filePath = result.files.single.path!;
    //   final file = File(filePath);

    //   try {
    //     final reference = FirebaseStorage.instance.ref(name);
    //     await reference.putFile(file);
    //     final uri = await reference.getDownloadURL();

    //     final message = types.PartialFile(
    //       mimeType: lookupMimeType(filePath),
    //       name: name,
    //       size: result.files.single.size,
    //       uri: uri,
    //     );

    //     FirebaseChatCore.instance.sendMessage(message, widget.room.id);
    //     _setAttachmentUploading(false);
    //   } finally {
    //     _setAttachmentUploading(false);
    //   }
    // }
  }

  Future<void> _handleImageSelection() async {
    // TODO
    // final result = await ImagePicker().pickImage(
    //   imageQuality: 70,
    //   maxWidth: 1440,
    //   source: ImageSource.gallery,
    // );

    // if (result != null) {
    //   _setAttachmentUploading(true);
    //   final file = File(result.path);
    //   final size = file.lengthSync();
    //   final bytes = await result.readAsBytes();
    //   final image = await decodeImageFromList(bytes);
    //   final name = result.name;

    //   try {
    //     final reference = FirebaseStorage.instance.ref(name);
    //     await reference.putFile(file);
    //     final uri = await reference.getDownloadURL();

    //     final message = types.PartialImage(
    //       height: image.height.toDouble(),
    //       name: name,
    //       size: size,
    //       uri: uri,
    //       width: image.width.toDouble(),
    //     );

    //     FirebaseChatCore.instance.sendMessage(
    //       message,
    //       widget.room.id,
    //     );
    //     _setAttachmentUploading(false);
    //   } finally {
    //     _setAttachmentUploading(false);
    //   }
    // }
  }

  Future<void> _handleMessageTap(BuildContext _, MessageModel message) async {
    // TODO
    // if (message is types.FileMessage) {
    //   var localPath = message.uri;

    //   if (message.uri.startsWith('http')) {
    //     try {
    //       final updatedMessage = message.copyWith(isLoading: true);
    //       FirebaseChatCore.instance.updateMessage(
    //         updatedMessage,
    //         widget.room.id,
    //       );

    //       final client = http.Client();
    //       final request = await client.get(Uri.parse(message.uri));
    //       final bytes = request.bodyBytes;
    //       final documentsDir = (await getApplicationDocumentsDirectory())
    //              .path;
    //       localPath = '$documentsDir/${message.name}';

    //       if (!File(localPath).existsSync()) {
    //         final file = File(localPath);
    //         await file.writeAsBytes(bytes);
    //       }
    //     } finally {
    //       final updatedMessage = message.copyWith(isLoading: false);
    //       FirebaseChatCore.instance.updateMessage(
    //         updatedMessage,
    //         widget.room.id,
    //       );
    //     }
    //   }

    //   await OpenFilex.open(localPath);
    // }
  }

  void _handlePreviewDataFetched(
    MessageModel message,
    types.PreviewData previewData,
  ) {
    // TODO
    // final updatedMessage = message.copyWith(previewData: previewData);

    // FirebaseChatCore.instance.updateMessage(updatedMessage, widget.room.id);
  }

  Future<void> _handleSendPressed(types.PartialText partialMessage) async {
    final relationshipId = relationshipCRUD.getId(
      widget.currentUserId,
      widget.otherId,
    );
    final message = MessageModel.fromPartialText(
      authorId: widget.currentUserId,
      id: '',
      partialText: partialMessage,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    try {
      await messageCRUD.create(
        parentDocumentId: relationshipId,
        documentId: null,
        data: message,
      );
    } catch (_) {
      // ignore: use_build_context_synchronously
      snackBarError(context, context.l10n.errorOccurred);
    }
  }

  // void _setAttachmentUploading(bool uploading) {
  //   setState(() {
  //     _isAttachmentUploading = uploading;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<UserCubit>().state;
    if (currentUser == null) return Container();

    final relationshipId = relationshipCRUD.getId(
      widget.currentUserId,
      widget.otherId,
    );

    return StreamBuilder<Iterable<MessageModel>>(
      stream: messageCRUD.streamFiltered(
        // TODO : package it
        parentDocumentId: relationshipId,
        filter: (collection) => collection.orderBy(
          'createdAt',
          descending: true,
        ),
      ),
      builder: (context, snapshot) {
        return Chat(
          isAttachmentUploading: _isAttachmentUploading,
          messages: snapshot.data?.toList() ?? [],
          onAttachmentPressed: _handleAtachmentPressed,
          onMessageTap: _handleMessageTap,
          onPreviewDataFetched: _handlePreviewDataFetched,
          onSendPressed: _handleSendPressed,
          user: currentUser,
        );
      },
    );
  }
}
