import 'package:crea_chess/package/atomic_design/dialog/yes_no.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showUnblockUserDialog(
  BuildContext pageContext,
  String toUnblockId,
) {
  final currentUserId = pageContext.read<UserCubit>().state?.id;
  if (currentUserId == null) return; // should never happen

  showYesNoDialog(
    pageContext: pageContext,
    title: pageContext.l10n.userUnblock,
    content: FutureBuilder<UserModel?>(
      future: userCRUD.read(documentId: toUnblockId),
      builder: (context, snapshot) {
        final toBlock = snapshot.data;
        return ListTile(
          leading: UserPhoto(photo: toBlock?.photo),
          title: Text(toBlock?.username ?? ''),
        );
      },
    ),
    onYes: () {
      relationshipCRUD.unblock(
        blockerId: currentUserId,
        toUnblockId: toUnblockId,
      );
      snackBarNotify(pageContext, pageContext.l10n.userUnblocked);
    },
  );
}
