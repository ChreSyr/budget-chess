import 'package:crea_chess/package/chat/flutter_chat_ui/util.dart';
import 'package:crea_chess/package/chat/flutter_chat_ui/widgets/state/inherited_chat_theme.dart';
import 'package:crea_chess/package/chat/flutter_chat_ui/widgets/state/inherited_l10n.dart';
import 'package:crea_chess/package/chat/flutter_chat_ui/widgets/state/inherited_user.dart';
import 'package:crea_chess/package/chat/message/message_model.dart';
import 'package:flutter/material.dart';

/// A class that represents file message widget.
class FileMessage extends StatelessWidget {
  /// Creates a file message widget based on a [MessageModel].
  const FileMessage({required this.message, super.key});

  /// [MessageModel].
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final user = InheritedUser.of(context).user;
    final color = user.id == message.authorId
        ? InheritedChatTheme.of(context).theme.sentMessageDocumentIconColor
        : InheritedChatTheme.of(context).theme.receivedMessageDocumentIconColor;

    return Semantics(
      label: InheritedL10n.of(context).l10n.fileButtonAccessibilityLabel,
      child: Container(
        padding: EdgeInsetsDirectional.fromSTEB(
          InheritedChatTheme.of(context).theme.messageInsetsVertical,
          InheritedChatTheme.of(context).theme.messageInsetsVertical,
          InheritedChatTheme.of(context).theme.messageInsetsHorizontal,
          InheritedChatTheme.of(context).theme.messageInsetsVertical,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(21),
              ),
              height: 42,
              width: 42,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // if (message.isLoading ?? false)
                  //   Positioned.fill(
                  //     child: CircularProgressIndicator(
                  //       color: color,
                  //       strokeWidth: 2,
                  //     ),
                  //   ),
                  if (InheritedChatTheme.of(context).theme.documentIcon != null)
                    InheritedChatTheme.of(context).theme.documentIcon!
                  else
                    Icon(Icons.description, color: color),
                ],
              ),
            ),
            Flexible(
              child: Container(
                margin: const EdgeInsetsDirectional.only(
                  start: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.mediaName ?? '',
                      style: user.id == message.authorId
                          ? InheritedChatTheme.of(context)
                              .theme
                              .sentMessageBodyTextStyle
                          : InheritedChatTheme.of(context)
                              .theme
                              .receivedMessageBodyTextStyle,
                      textWidthBasis: TextWidthBasis.longestLine,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 4,
                      ),
                      child: Text(
                        formatBytes((message.mediaSize ?? 0).truncate()),
                        style: user.id == message.authorId
                            ? InheritedChatTheme.of(context)
                                .theme
                                .sentMessageCaptionTextStyle
                            : InheritedChatTheme.of(context)
                                .theme
                                .receivedMessageCaptionTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
