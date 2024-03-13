import 'dart:io';

import 'package:crea_chess/package/atomic_design/modal/modal.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

const avatarNames = [
  'antoine',
  'cassandra',
  'catherine',
  'charles',
  'claude',
  'gabrielle',
  'hugo',
  'ines',
  'lea',
  'leo',
  'lucas',
  'madeleine',
  'maeva',
  'manu',
  'mathis',
  'nathan',
  'nick',
  'orion',
  'ricardo',
  'victor',
  'yannick',
];

void showPhotoModal(BuildContext context, String userId) {
  return Modal.show(
    context: context,
    sections: [
      if (!kIsWeb)
        ListTile(
          leading: const Icon(Icons.photo_camera),
          title: Text(context.l10n.pictureTake),
          onTap: () async {
            context.pop();
            final photoRef =
                await uploadProfilePhoto(ImageSource.camera, userId);
            if (photoRef == null) return;
            await userCRUD.userCubit
                .setPhoto(photo: await photoRef.getDownloadURL());
          },
        ),
      ListTile(
        leading: const Icon(Icons.folder),
        title: Text(context.l10n.pictureImport),
        onTap: () async {
          context.pop();
          final photoRef =
              await uploadProfilePhoto(ImageSource.gallery, userId);
          if (photoRef == null) return;
          await userCRUD.userCubit
              .setPhoto(photo: await photoRef.getDownloadURL());
        },
      ),
      ListTile(
        leading: const Icon(Icons.face),
        title: Text(context.l10n.avatarChoose),
        onTap: () {
          context.pop();
          showAvatarModal(
            context,
            (avatarName) =>
                userCRUD.userCubit.setPhoto(photo: 'avatar-$avatarName'),
          );
        },
      ),
    ],
  );
}

void showAvatarModal(
  BuildContext context,
  void Function(String avatarName) onSelect,
) {
  Modal.show(
    context: context,
    sections: [
      GridView.count(
        shrinkWrap: true,
        crossAxisCount: 4,
        crossAxisSpacing: CCSize.large,
        mainAxisSpacing: CCSize.large,
        children: avatarNames
            .map(
              (e) => GestureDetector(
                onTap: () {
                  onSelect(e);
                  context.pop();
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar/$e.jpg'),
                ),
              ),
            )
            .toList(),
      ),
    ],
  );
}

Future<Reference?> uploadProfilePhoto(ImageSource source, String userId) async {
  final pickedFile = await ImagePicker().pickImage(source: source);

  if (pickedFile == null) return null;

  final photoRef = FirebaseStorage.instance.getUserPhotoRef(userId);
  await photoRef.putFile(File(pickedFile.path));
  return photoRef;
}
