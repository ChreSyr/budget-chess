import 'package:crea_chess/package/atomic_design/dialog/yes_no.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showCancelRelationshipDialog(
  BuildContext pageContext,
  String relatedUserId,
) {
  final authUid = pageContext.read<AuthenticationCubit>().state?.uid;
  if (authUid == null) return; // should never happen

  showYesNoDialog(
    pageContext: pageContext,
    title: pageContext.l10n.friendRemove,
    content: FutureBuilder<UserModel?>(
      future: userCRUD.read(documentId: relatedUserId),
      builder: (context, snapshot) {
        final toBlock = snapshot.data;
        return ListTile(
          leading: UserPhoto(photo: toBlock?.photo),
          title: Text(toBlock?.username ?? ''),
        );
      },
    ),
    onYes: () {
      relationshipCRUD.cancel(
        cancelerId: authUid,
        otherId: relatedUserId,
      );
      snackBarNotify(pageContext, pageContext.l10n.friendRemoved);
    },
  );
}
