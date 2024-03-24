import 'package:crea_chess/package/atomic_design/dialog/yes_no.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/user/widget/user_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showBlockUserDialog(
  BuildContext pageContext,
  String toBlockId,
) {
  final authUid = pageContext.read<UserCubit>().state.id;

  showYesNoDialog(
    pageContext: pageContext,
    title: pageContext.l10n.blockThisUser,
    content: FutureBuilder<UserModel?>(
      future: userCRUD.read(documentId: toBlockId),
      builder: (context, snapshot) {
        final toBlock = snapshot.data;
        return ListTile(
          leading: UserPhoto(photo: toBlock?.photo),
          title: Text(toBlock?.username ?? ''),
        );
      },
    ),
    onYes: () {
      relationshipCRUD.block(
        blockerId: authUid,
        toBlockId: toBlockId,
      );
      snackBarNotify(pageContext, pageContext.l10n.blockedUser);
    },
  );
}
