import 'package:crea_chess/package/atomic_design/dialog/yes_no.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/relationship_crud.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_crud.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_cubit.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_model.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showBlockUserDialog(
  BuildContext pageContext,
  String toBlockId,
) {
  final currentUserId = pageContext.read<UserCubit>().state?.id;
  if (currentUserId == null) return; // should never happen

  showYesNoDialog(
    pageContext: pageContext,
    title: pageContext.l10n.blockThisUser,
    content: FutureBuilder<UserModel?>(
      future: userCRUD.read(documentId: toBlockId),
      builder: (context, snapshot) {
        final toBlock = snapshot.data;
        return ListTile(
          leading: UserPhoto(userId: toBlockId, photo: toBlock?.photo),
          title: Text(toBlock?.username ?? ''),
        );
      },
    ),
    onYes: () {
      relationshipCRUD.block(
        blockerId: currentUserId,
        toBlockId: toBlockId,
      );
      snackBarNotify(pageContext, pageContext.l10n.blockedUser);
    },
  );
}
