import 'dart:io';

import 'package:crea_chess/package/atomic_design/modal/modal.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
